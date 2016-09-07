#!/usr/bin/env ruby

require 'optparse'
require 'pathname'

module Mode
    BACKUP = 0
    SYNC = 1
end

def parse_options
    user_options = {}
    option_parser = OptionParser.new do |parser|
        parser.banner = "Usage: #{File.basename($PROGRAM_NAME)} [options] ENV"
        parser.on('-b', '--backup', 'Backup configuration') do
            user_options[:mode] = Mode::BACKUP
        end
        parser.on('-s', '--sync', 'Sync configuration') do
            user_options[:mode] = Mode::SYNC
        end
    end

    begin
        option_parser.parse!
        mandatory = [:mode]
        missing = mandatory.select { |param| user_options[param].nil? }
        unless missing.empty?
            puts "Required options: #{missing.join(', ').sub('mode', '-b or -s')}"
            puts option_parser
            exit
        end
    rescue OptionParser::InvalidOption, OptionParser::MissingArgument
        puts $ERROR_INFO.to_s
        puts option_parser
        exit
    end
    user_options
end

def running_in_repo?
    script_path = Pathname.new(File.path(__FILE__))
    current_path = Pathname.new(Dir.pwd)
    current_path.realpath == script_path.parent.realpath
end

def backup(tracked_files)
    tracked_files.each do |filename|
        puts "Copying from home folder: #{filename}"
        `cp ~/#{filename} ./`
    end
end

def sync(tracked_files, default_profile)
    tracked_files.each do |filename|
        puts "Syncing into home folder: #{filename}"
        `cp #{filename} ~/`
    end

    include_in_bash_profile(default_profile)
end

def include_in_bash_profile(default_profile)
    path_to_bash_profile = "#{Dir.home}/.bash_profile"
    line_to_add = "source ~/#{default_profile}"
    already_included = false
    File.readlines(path_to_bash_profile).each do |line|
        next unless line.strip.eql?(line_to_add)
        already_included = true
        break
    end
    return if already_included

    puts "Adding '#{line_to_add}' to .bash_profile"
    open(path_to_bash_profile, 'a') do |f|
        f.puts line_to_add
    end
end

def main
    default_profile = '.default.bash'

    tracked_files = [
        default_profile,
        '.ideavimrc',
        '.vimrc',
        '.vrapperrc'
    ]

    options = parse_options
    raise 'Can only be run from within the environment repository' unless running_in_repo?
    if options[:mode] == Mode::BACKUP
        backup(tracked_files)
    else
        sync(tracked_files, default_profile)
    end
end

main if __FILE__ == $PROGRAM_NAME
