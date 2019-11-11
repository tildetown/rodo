# rodo

A minimal todo list program for people who live on the command line.

# Screenshot

![](screenshot.png)

# Table of Contents

- [TL;DR](#tldr)
- [Introduction](#introduction)
- [Conventions used in this readme](#conventions-used-in-this-readme)
- [Platforms](#platforms)
- [Requirements](#requirements)
- [Downloading the requirements](#downloading-the-requirements)
    - [Downloading Racket](#downloading-racket)
        - [To download Racket](#to-download-racket)
    - [Downloading the rodo source code](#downloading-the-rodo-source-code)
        - [To download the rodo source code](#to-download-the-rodo-source-code)
- [Running rodo from any directory](#downloading-rodo-from-any-directory)
    - [Setting up a $PATH](#setting-up-a-path)
        - [To set up a $PATH](#to-set-up-a-path)
    - [Adding rodo to your $PATH](#adding-rodo-to-your-path)
        - [To add rodo to your $PATH](#to-add-rodo-to-your-path)
- [List of commands](#list-of-commands)
- [Usage examples](#usage-examples)
- [Configuring rodo](#configuring-rodo)

# TL;DR

1. Make sure [Racket](https://racket-lang.org/) is installed
2. `git clone https://github.com/m455/rodo` into a directory of your choice
3. `cd` into the `rodo` directory
4. Choose one of the options below for running rodo:
    * To use rodo using the Racket interpreter run: `racket rodo.rkt`
    * To use rodo as an single-file executable follow the steps below:
        1. Run `raco exe rodo.rkt` to compile rodo into a single-file executable
        2. Run `./rodo`
5. (optional) Create a wrapper in your `$PATH` directory to run rodo from anywhere:

```
#!/usr/bin/env bash
racket ~/path/to/rodo.rkt "$@"
```

If you are using a single-file executable, create a wrapper as follows:

```
#!/usr/bin/env bash
~/path/to/rodo "$@"
```

# Introduction

This readme will guide you through downloading, installing, and using the rodo
todo list program. It is intended for people who spend a lot of their time on the
command line and want a minimal todo list application.

# Conventions used in this readme

* Notes - Notes signify additional information
* Tips - Tips signify an alternate procedure for completing a step
* Cautions - Cautions signify that damage may occur
* Examples - Examples provide a visual reference of how a procedure would be carried out in the real world
* `Inline code` - Inline code signifies package names, filenames, or commands
* ```Code blocks``` - Code blocks signify file contents

# Platforms

Below is a list of platforms that rodo can run on:

* GNU/Linux
* Windows Subsystem for Linux
* macOS (Untested)

# Requirements

The following items must be installed before you can use rodo:

* Racket: [https://racket-lang.org/](https://racket-lang.org/)
* rodo's source code: [https://github.com/m455/rodo](https://github.com/m455/rodo)

# Downloading the requirements

This section will guide you through downloading the required items for running
rodo.

## Downloading Racket

The Racket programming language will be needed to interpret or compile rodo.

### To download Racket

1. run `sudo apt install racket` on the command line

## Downloading the rodo source code

rodo's source code is needed so Racket can interpret or compile rodo.

### To download the rodo source code

1. run `git clone https://github.com/m455/rodo`

# Running rodo from any directory

This section will guide you through setting up your `$PATH` and adding rodo to
your `$PATH`. This will allow you to run rodo from any directory on your system.

## Setting up a $PATH

A `$PATH` is a directory in which you can place executable files or scripts.
After placing executable files or scripts in your `$PATH` directory, you can
then run these files or scripts from any directory on your machine.

**Tip**: If you have a `$PATH` already, then skip to [Adding rodo to your
$PATH](#adding-rodo-to-your-path)

### To set up a $PATH

1. Create a `~/bin/` directory for your `$PATH` by running `mkdir ~/bin/`
2. Add the `~/bin` directory to your `$PATH` by running the following command:

```
echo "export PATH=~/bin:\$PATH" >> .bashrc
```

## Adding rodo to your $PATH

After rodo has been added to your `$PATH`, you will be able to run it from any
directory on your machine.

### To add rodo to your $PATH

1. Create a file in your `~/bin/` directory with the following contents in it:

```
#!/usr/bin/env bash
racket ~/path/to/rodo.rkt "$@"
```

2. Save the file
3. Make the file executable by running `chmod u+x ~/bin/name-of-your-file`

**Example**: You create a file called `rodo` in your `~/bin/` directory with
the following contents in it if you downloaded the rodo directory to your
`~/downloads/` directory:

```
racket ~/downloads/rodo/rodo.rkt "$@"
```

You would then make the rodo file executable by running the following
command:

```
chmod u+x ~/bin/rodo
```

# List of commands

This section lists and describes rodo's commands.

* `-h` or `--help` displays the help message
* `init` creates a list file (See the `config.rkt` file for the default location of this file)
* `ls` displays your list
* `add` adds an item to your list
* `rm` removes an item from your list

# Usage examples

The examples below assume that you have [added rodo to your $PATH](#adding-rodo-to-your-path).

`rodo -h`

`rodo --help`

`rodo init`

`rodo ls`

`rodo add "this is an item"`

`rodo add this is an item without quotation marks`

`rodo rm 1`

**Note**: You may have to run `rodo ls` to see which number corresponds to which item in your list.

# Configuring rodo

**Caution**: Changing the `config.rkt` file should be done at your own risk as it may break rodo's functionality

Settings such as the program name, directory, and the filename of the todo list
file can be changed by editing the `config.rkt` file.
