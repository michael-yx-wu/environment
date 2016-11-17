#!/usr/bin/env ruby

require 'English'
require 'optparse'
require 'pathname'

module Mode
    BACKUP = 0
    SYNC = 1
    INSTALL = 2
end

def parse_options
    user_options = {}
    option_parser = OptionParser.new do |parser|
        parser.banner = "Usage: #{File.basename($PROGRAM_NAME)} [mode]"
        parser.on('-b', '--backup', 'Backup configuration') do
            user_options[:mode] = Mode::BACKUP
        end
        parser.on('-s', '--sync', 'Sync configuration') do
            user_options[:mode] = Mode::SYNC
        end
        parser.on('-i', '--install', 'Install environment dependencies') do
            user_options[:mode] = Mode::INSTALL
        end
    end

    begin
        option_parser.parse!
        mandatory = [:mode]
        missing = mandatory.select { |param| user_options[param].nil? }
        unless missing.empty?
            puts 'Need to specify mode'
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
    generate_vim_files

    tracked_files.each do |filename|
        puts "Syncing into home folder: #{filename}"
        `cp #{filename} ~/`
    end

    include_in_bash_profile(default_profile)
end

# rubocop:disable Metrics/LineLength
def generate_vim_files
    run_with_message('cat .vimrc > .ideavimrc && cat vim-templates/.ideavimrc_template >> .ideavimrc', message: 'Generating .ideavimrc...')
    run_with_message('cat .vimrc > .vrapperrc && cat vim-templates/.vrapperrc_template >> .vrapperrc', message: 'Generating .vrapperrc...')
end
# rubocop:enable Metrics/LineLength

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

def run_with_message(command, message: nil, show_output: false)
    puts message if message
    output = `#{command} 2>&1`
    puts output if show_output
end

# rubocop:disable Metrics/LineLength
def install
    run_with_message('git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim', message: 'Installing Vundle...')
    run_with_message('vim +PluginInstall +qall', message: 'Installing Vim plugins...') if $CHILD_STATUS.exitstatus.zero?
    run_with_message('./install_bash_dependencies.sh', message: 'Intalling Bash dependencies...')
end
# rubocop:enable Metrics/LineLength

def main
    default_profile = '.default.bash'

    tracked_files = [
        default_profile,
        '.ideavimrc',
        '.inputrc',
        '.gitconfig',
        '.vimrc',
        '.vrapperrc'
    ]

    options = parse_options
    raise 'Can only be run from within the environment repository' unless running_in_repo?
    if options[:mode] == Mode::BACKUP
        backup(tracked_files)
    elsif options[:mode] == Mode::SYNC
        sync(tracked_files, default_profile)
    elsif options[:mode] == Mode::INSTALL
        install
    end
end

main if __FILE__ == $PROGRAM_NAME
