#!/usr/bin/env python3

import argparse
import pathlib
import shutil

parser = argparse.ArgumentParser(
    prog='myenv',
    description='Keep managed dotfiles in sync across multiple environments',
    exit_on_error=True,
)
group = parser.add_mutually_exclusive_group(required=True)
group.add_argument('--copy', '-c', action='store_true', help='Copies managed dotfiles to home directory')
group.add_argument('--save', '-s', action='store_true', help='Copies managed dotfiles from home directory')

# Managed dot files
default_bash_settings_file = '.default.bash'
tracked_files = [
    default_bash_settings_file,
    '.inputrc',
    '.gitconfig',
    '.ideavimrc',
    '.vimrc',
]

current_dir = pathlib.Path(__file__).readlink().parent.resolve()

def copy():
    generate_vim_files()
    for filename in tracked_files:
        print(f"Copying into home folder: {filename}")
        shutil.copy2(current_dir / filename, pathlib.Path.home())
    include_in_bash_profile()


def generate_vim_files():
    with open(current_dir / 'vim-templates/.ideavimrc_template') as f:
        ideavimrc_template = f.read()
    with open(current_dir / '.vimrc') as f:
        vimrc = f.read()
    with open(current_dir / '.ideavimrc', 'w') as f:
        f.write(vimrc + '\n' + ideavimrc_template)


def include_in_bash_profile():
    source_default_bash = f"source ~/{default_bash_settings_file}\n"
    with open(pathlib.Path.home() / '.bash_profile', 'r+') as f:
        bash_profile = f.read()
        if source_default_bash not in bash_profile:
            print(f"Prepending {source_default_bash} to ~/.bash_profile")
            f.seek(0)
            f.write(source_default_bash)
            f.write(bash_profile)


def save():
    for filename in tracked_files:
        print(f"Copying from home folder: {filename}")
        shutil.copy2(pathlib.Path.home() / filename, current_dir)


args = parser.parse_args()
print(f"Resolved script directory: {current_dir}")
if args.copy:
    copy()
elif args.save:
    save()
else:
    # This should never happen
    print("Expected one of copy or save to be set")
    parser.print_help()
