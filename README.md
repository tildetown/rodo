# rodo

A simple to-do list tool for people who live on the command-line

# Todos
- [ ] Only allow quoted items to be added

By: Jesse Laprade
=======
A simple todo list program for people who live on the command line

![](screenshot.png)

# Table of Contents

* [Platforms](https://github.com/m455/rodo#platforms)
* [Requirements](https://github.com/m455/rodo#requirements)
* [Downloading](https://github.com/m455/rodo#downloading)
* [Setup](https://github.com/m455/rodo#setup)
    * [GNU/Linux and Windows Subsystem for Linux](https://github.com/m455/rodo#gnulinux-and-windows-subsystem-for-linux)
* [Usage](https://github.com/m455/rodo#usage)
* [Examples](https://github.com/m455/rodo#examples)
* [Configuration](https://github.com/m455/rodo#configuring-rodo)

# Platforms

* GNU/Linux
* Windows Subsystem for Linux

## Requirements

* [Racket 6.x](https://racket-lang.org/)
* [Git](https://git-scm.com/)(Optional method for downloading)

# Downloading

* Via GitHub
    1. Click the *Clone or download* button in the top right
    2. Click *Download ZIP* from the drop-down list
* Via Git
    * Run `git clone https://github.com/m455/rodo` on the command line

# Setup

The steps below will assist the user in setting up rodo

## GNU/Linux and Windows Subsystem for Linux

Follow the steps below to set up rodo

### Setup a $PATH

1. Create a directory for your `$PATH` by running `mkdir ~/bin/`
2. Add your newly-created `~/bin/` to your `$PATH` by running `echo "export PATH=~/bin:\$PATH" >> .bashrc`

### Adding rodo to your $PATH

1. Create a file in your `~/bin/` directory with the following contents in it:

```
#!/usr/bin/env bash
racket ~/path/to/rodo.rkt "$@"
```

For example, if you downloaded the project to your
~/downloads/ folder you would change the line `racket
~/path/to/rodo.rkt "$@"` to `racket
~/downloads/rodo/rodo.rkt "$@"`.

If you prefer to use an executable, rather than a wrapper,
you can create an executable binary file with `raco exe
file-name-here.rkt`.

2. Save the file

3. Make the file executable by running `chmod u+x ~/bin/name-of-your-file`

# Usage

Type `rodo` plus one of the options below with a space
between `rodo` and the option.

`init` - Initializes a file in ~/.rodo/todo-list by default

`ls` - Lists items from the list

`add` - Adds an entry to the list

`rm` - Removes an item from the list

**Note:** You may have to run `rodo ls` to see which number corresponds to which item when removing items.

## Usage examples

The examples below assume that you have rodo [set up](https://github.com/m455/rodo#setup-a-path) in your `$PATH`

`rodo init`

`rodo ls`

`rodo add bread` (Single-word entry)

`rodo add "go to the bank"` (Multi-word entry)

`rodo rm 1`

# Configuring rodo

Right now, the configurations can be found in the `config.rkt file`. Settings, such as program name, path, and directory can be changed.

