# rodo

A easy-to-use todo list program for people who live on the command line.

Also available from the following Git services:

* https://github.com/m455/rodo
* https://gitlab.com/m455/rodo
* https://notabug.org/m455/rodo

# Screenshot

![](screenshot.png)

# Table of Contents

- [TL;DR](#tldr)
- [New features](#new-features)
- [Todos](#todos)
- [Platforms](#platforms)
- [Installing rodo](#installing-rodo)
    - [Requirements](#requirements)
    - [Downloading Racket](#downloading-racket)
        - [To download Racket using apt](#to-download-racket-using-apt)
        - [To download Racket using pacman](#to-download-racket-using-pacman)
    - [Downloading the rodo source code](#downloading-the-rodo-source-code)
        - [To download the rodo source code](#to-download-the-rodo-source-code)
- [Setup](#setup)
    - [Setting up a $PATH](#setting-up-a-path)
        - [To set up a $PATH](#to-set-up-a-path)
    - [Adding rodo to your $PATH](#adding-rodo-to-your-path)
        - [To add rodo to your $PATH](#to-add-rodo-to-your-path)
- [List of commands](#list-of-commands)
- [Usage examples](#usage-examples)
- [Configuring `rodo`](#configuring-rodo)

# TL;DR

1. Make sure [Racket](https://racket-lang.org/) is installed
2. `git clone https://github.com/m455/rodo` into a directory of your choice
3. `cd` into the `rodo` directory
4. Choose one of the options below for running `rodo`.
    * To use `rodo` using the Racket interpreter run: `racket rodo.rkt`
    * To use `rodo` as an single-file executable follow the two steps below:
        1. Run `raco exe rodo.rkt` to compile the `rodo` into a single-file executable
        2. Run `./rodo`
5. (optional) Add the following to your `$PATH` directory to run `rodo` from anywhere.

```
#!/usr/bin/env bash
racket ~/path/to/rodo.rkt "$@"
```

Note: If you made an executable, remember to change the `rodo.rkt` part above to `rodo`

# New features

Now the default directory and todo list file have better default permissions:

* `rodo` is now licensed under AGPL3!
* `~/.rodo/` is set to 700 by default
* `~/.rodo/todo.txt` is set to 600 by default.

# Todos

When I have time, I plan on adding the following features to rodo:

- Add a purpose, context, and overview for each h1 in `README.md`
- A boolean color option in the `config.rkt` file
- Encrypt/decrypt `todo.txt` file

# Platforms

Below is a list of platforms that `rodo` can run on.

* Windows Subsystem for Linux
* GNU/Linux
* macOS (Untested)

# Installing rodo
This section will guide you through installing `rodo`, so you can use it on your platform.

## Requirements

This section will provide you with the requirements needed to run `rodo`. This
section will guide you through downloading Racket and downloading the `rodo`
source code.

* [Racket 6.x](https://racket-lang.org/)
* `rodo` source code

## Downloading Racket

Racket can be download using your machine's package manager. Depending on what
package manager you use, commands may vary. See the two sections below for a
list of examples using the `apt` and `pacman` package managers on the command
line.

### To download Racket using apt

1. run `sudo apt install racket`

Note: You may need to run this command as root

### To download Racket using pacman

1. run `pacman -Syu racket`

Note: You may need to run this command as root

## Downloading the rodo source code

The `rodo` source code is available from this repository, and can be downloaded using `git`.

### To download the rodo source code

1. run `git clone https://github.com/m455/rodo`

Tip: If you want to download this into a different directory, you can specify a
directory by running the command below:

```
git clone https://github.com/m455/rodo your-directory-name/
```

# Setup

For convenience, `rodo` can be added to your `$PATH`. This section will guide
you through setting up a `$PATH` and adding `rodo` to your `$PATH`.

## Setting up a $PATH

A `$PATH` is a directory in which you can place executable files or script files. These files
can then be ran from any directory on your machine.

Tip: If you have set up a `$PATH` already, then skip to the next step, [Adding
`rodo` to your `$PATH`](https://github.com/m455/rodo#adding-rodo-to-your-path).

### To set up a $PATH

1. Create a directory for your `$PATH` by running `mkdir ~/bin/`
2. Add your newly-created `~/bin/` to your `$PATH` by running `echo "export PATH=~/bin:\$PATH" >> .bashrc`

## Adding rodo to your $PATH

Adding `rodo` to your `$PATH` allows you to run `rodo` from any directory on your machine.

### To add rodo to your $PATH

1. Create a file in your `~/bin/` directory with the following contents in it:

```
#!/usr/bin/env bash
racket ~/path/to/rodo.rkt "$@"
```

For example: If you downloaded the project to your `~/downloads/` folder you would change the line
`racket ~/path/to/rodo.rkt "$@"` to `racket ~/downloads/rodo/rodo.rkt "$@"`.

2. Save the file
3. Make the file executable by running `chmod u+x ~/bin/name-of-your-file`

Tip: Racket can make executables. You can do this by running the following
command when in the same folder as the `rodo.rkt` file:

```
raco exe rodo.rkt
```

# List of commands

This section lists and describes `rodo`'s commands.

* `-h` or `--help` displays the help message
* `init` creates a file called `todo.txt` in `~/.rodo/` by default
* `ls` displays numbered items in the todo list
* `add` adds an item to the todo list
* `rm` removes an item from the todo list

Note: You may have to run `rodo ls` to see which number corresponds to which item when removing items.

# Usage examples

The examples below assume that you have [added `rodo` to your `$PATH`](https://github.com/m455/rodo#adding-rodo-to-your-path).

`rodo -h`

`rodo --help`

`rodo init`

`rodo ls`

`rodo add "this is a task"`

`rodo add this is a task without quotes`

`rodo rm 1` (This removes the first item in your list)

Note: You may have to run `rodo ls` to see which number corresponds to which item when removing items.

# Configuring `rodo`

**Caution: Changing the `config.rkt` file should be done at your own risk as it may break `rodo`'s functionality**

Right now, the configurations can be found in the `config.rkt file`. Settings,
such as the program name, directory, and the filename of the todo list file can
be changed.

