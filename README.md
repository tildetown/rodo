# rodo

A minimal list manager for people who live on the command line.

# Screenshot

![](screenshot.png)

<!-- markdown-toc start - Don't edit this section. Run M-x markdown-toc-refresh-toc -->
# Table of Contents

- [Quick start](#quick-start)
- [Getting started](#getting-started)
- [Conventions used in this readme](#conventions-used-in-this-readme)
- [Platforms](#platforms)
- [Requirements](#requirements)
    - [Downloading Racket](#downloading-racket)
        - [To download and install Racket](#to-download-and-install-racket)
    - [Downloading the rodo source code](#downloading-the-rodo-source-code)
        - [To download the rodo source code](#to-download-the-rodo-source-code)
- [Running rodo from any directory](#running-rodo-from-any-directory)
    - [Setting up a $PATH](#setting-up-a-path)
        - [To set up a $PATH](#to-set-up-a-path)
    - [Adding rodo to your $PATH](#adding-rodo-to-your-path)
        - [To add rodo to your $PATH](#to-add-rodo-to-your-path)
- [Using rodo](#using-rodo)
    - [Showing the help message](#showing-the-help-message)
        - [To show the help message](#to-show-the-help-message)
    - [Initializing rodo](#initializing-rodo)
        - [To initialize rodo](#to-initialize-rodo)
    - [Displaying your list](#displaying-your-list)
        - [To display your list](#to-display-your-list)
    - [Adding an item to your list](#adding-an-item-to-your-list)
        - [To add an item to your list](#to-add-an-item-to-your-list)
    - [Removing an item from your list](#removing-an-item-from-your-list)
        - [To remove an item from your list](#to-remove-an-item-from-your-list)
    - [Configuring rodo](#configuring-rodo)
        - [To configure rodo](#to-configure-rodo)
- [List of commands](#list-of-commands)
- [Usage examples](#usage-examples)

<!-- markdown-toc end -->


# Quick Start

**Note** - This section is for users who are familiar with git, a Unix-like
command line environment, or scripting.

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

# Getting Started

This readme will guide you through downloading, setting up, and using the rodo
list manager. This readme is intended for people who spend a lot of their time
on the command line and want a minimal list manager.

# Conventions used in this readme

* **Note** - Notes signify additional information
* **Tip**- Tips signify an alternate procedure for completing a step
* **Caution** - Cautions signify that damage may occur
* **Example** - Examples provide a visual reference of how a procedure would be carried out in the real world
* `Inline code` - Inline code signifies package names, filenames, or commands
* ```Code block``` - Code blocks signify file contents

# Platforms

Below is a list of platforms that rodo can run on:

* GNU/Linux
* Windows Subsystem for Linux
* macOS (Untested)

# Requirements

The following items must be downloaded and installed before you can use rodo:

* Racket: [https://racket-lang.org/](https://racket-lang.org/)
* rodo's source code: [https://github.com/m455/rodo](https://github.com/m455/rodo)

## Downloading Racket

The Racket programming language will be needed to interpret or compile rodo.

### To Download and install Racket

1. run `sudo apt install racket` on the command line

## Downloading the rodo Source Code

rodo's source code is needed so Racket can interpret or compile rodo.

### To Download the rodo Source Code

1. run `git clone https://github.com/m455/rodo`

# Running rodo from Any Directory

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

# Using rodo

This section will guide you the various commands that rodo can
use. This section assumes you know how to run either the `rodo.rkt`
using the Racket interpreter (`racket rodo.rkt`) or you have created
an executable using `raco exe rodo.rkt`.

## Showing the Help Message

The help message will provide a list of available commands. This is useful
in case you forget the name of a comamnd or how to use a command.

### To Show the Help Message

1. Run `rodo -h`

## Initializing rodo

Before using rodo, you must initialize rodo. Initializing will allow you to save
your list to a text file for later access.

### To initialize rodo

1. Run `rodo init`

## Displaying Your List

Displaying your list will allow you to view items you have added to your list.
You will notice numbers beside the items in your list. These numbers are for
references when removing items. See the [Removing an Item from Your
List](#removing-an-item-from-your-list) topic for more information.

### To Display Your List

1. Run `rodo ls`

## Adding an Item to Your List

Adding an item to your list will save it to a text file to access later.

### To Add an Item to Your List

1. Run `rodo add "this is an example of an item using double quotation marks"`

**Note** - The double quotation marks are optional, but recommended

## Removing an Item from Your List

When removing an item from your list, you can reference the numbers beside each
item when [Displaying Your List](#displaying-your-list). You can use these
numbers when removing an item from your list.

### To Remove an Item from Your List

1. Run `rodo rm 1`

**Note 1** - The "1" in the procedure above will remove the first item in your
list.

**Note 2** - You may need to run `rodo ls` first to see which numbers correspond
with which item in your list.

## Configuring rodo

You can configure rodo's settings, such as the location of the list file, and
command names.

### To Configure rodo

**Caution**: Changing the `config.rkt` file should be done at your own risk as it may break rodo's functionality

1. Edit the `config.rkt` file

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
