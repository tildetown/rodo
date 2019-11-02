# rodo

A minimal todo list program for people who live on the command line.

# Screenshot

![](screenshot.png)

# Table of Contents

- [rodo](#rodo)
- [Screenshot](#screenshot)
- [Table of Contents](#table-of-contents)
- [TL;DR](#tldr)
- [Platforms](#platforms)
- [Requirements](#requirements)
    - [Downloading Racket](#downloading-racket)
    - [Downloading the rodo source code](#downloading-the-rodo-source-code)
- [Setup](#setup)
    - [Setting up a $PATH](#setting-up-a-path)
    - [Adding rodo to your $PATH](#adding-rodo-to-your-path)
- [List of commands](#list-of-commands)
- [Usage examples](#usage-examples)
- [Configuring rodo](#configuring-rodo)
- [Todos](#todos)

# TL;DR

1. Make sure [Racket](https://racket-lang.org/) is installed
2. `git clone https://github.com/m455/rodo` into a directory of your choice
3. `cd` into the `rodo` directory
4. Choose one of the options below for running rodo:
    * To use rodo using the Racket interpreter run: `racket rodo.rkt`
    * To use rodo as an single-file executable follow the two steps below:
        1. Run `raco exe rodo.rkt` to compile rodo into a single-file executable.
        2. Run `./rodo`.
5. (optional) Create a wrapper in your `$PATH` directory to run rodo from anywhere:

```
#!/usr/bin/env bash
racket ~/path/to/rodo.rkt "$@"
```

# Platforms

Below is a list of platforms that rodo can run on.

* GNU/Linux
* Windows Subsystem for Linux
* macOS (Untested)

# Requirements

The following items must be installed before you can use rodo:

* Racket: [https://racket-lang.org/](https://racket-lang.org/)
* rodo's source code: [https://github.com/m455/rodo](https://github.com/m455/rodo)

## Downloading Racket

1. run `sudo apt install racket` on the command line

## Downloading the rodo source code

1. run `git clone https://github.com/m455/rodo`

# Setup

For convenience, rodo can be added to your `$PATH`. This section will guide
you through setting up a `$PATH` and adding rodo to your `$PATH`.

## Setting up a $PATH

A `$PATH` is a directory in which you can place executable files or scripts.
After placing executable files or scripts in your `$PATH` directory, you can run
these files or scripts from any directory on your machine.

Tip: If you have set up a `$PATH` already, then skip to the next step, [Adding rodo to your $PATH](https://github.com/m455/rodo#adding-rodo-to-your-path).

1. Create a directory for your `$PATH` by running `mkdir ~/bin/`
2. Add your newly-created `~/bin/` directory to your `$PATH` by running `echo "export PATH=~/bin:\$PATH" >> .bashrc`

## Adding rodo to your $PATH

1. Create a file in your `~/bin/` directory with the following contents in it:

```
#!/usr/bin/env bash
racket ~/path/to/rodo.rkt "$@"
```

For example: If you downloaded the project to your `~/downloads/` folder you would change the line
`racket ~/path/to/rodo.rkt "$@"` to `racket ~/downloads/rodo/rodo.rkt "$@"`.

2. Save the file
3. Make the file executable by running `chmod u+x ~/bin/name-of-your-file`

# List of commands

This section lists and describes rodo's commands.

* `-h` or `--help` displays the help message
* `init` creates a list file (See the `config.rkt` file for the default location of this file)
* `ls` displays your list
* `add` adds an item to your list
* `rm` removes an item from your list

# Usage examples

The examples below assume that you have [added rodo to your $PATH](https://github.com/m455/rodo#adding-rodo-to-your-path).

`rodo -h`

`rodo --help`

`rodo init`

`rodo ls`

`rodo add "this is an item"`

`rodo add this is an item without quotation marks`

`rodo rm 1` (This removes the first item from your list)

Note: You may have to run `rodo ls` to see which number corresponds to which item in your list.

# Configuring rodo

**Caution: Changing the `config.rkt` file should be done at your own risk as it may break rodo's functionality**

Settings such as the program name, directory, and the filename of the todo list
file can be changed by editing the `config.rkt` file.

# Todos

When I have time, I plan on adding the following features to rodo:

- Colour
- Encrypted list files
