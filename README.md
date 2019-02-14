# rodo

A simple todo list tool for people who live on the command-line

By Jesse Laprade

## Todo

- [ ] Only allow quoted items to be added
- [ ] Add color option to config.rkt file
- [ ] Encrypt todo-list file
- [ ] Change default permissions of todo-list file
- [ ] Add note on .bash_history about items being added here before going into the todo-list file

# Screenshot

![](screenshot.png)

# Table of Contents

* [Platforms](https://github.com/m455/rodo#platforms)
* [Requirements](https://github.com/m455/rodo#requirements)
* [Downloading](https://github.com/m455/rodo#downloading)
* [Setup](https://github.com/m455/rodo#setup)
    * [GNU/Linux](https://github.com/m455/rodo#gnulinux)
* [Usage](https://github.com/m455/rodo#usage)
    * [Usage examples](https://github.com/m455/rodo#usage-examples)
* [Configuration](https://github.com/m455/rodo#configuring-rodo)

# Platforms

Below is a list of platform(s) that `rodo` is currently available for.

* GNU/Linux

# Requirements

Below is a list of items needed for running `rodo` on your machine.

* [Racket 6.x](https://racket-lang.org/)
* [Git](https://git-scm.com/) (Optional method for downloading using `git clone`)

# Downloading

Currently, there are two ways to download the source code. Please choose one:

* Via GitHub on a web browser
    1. Click the *Clone or download* button at the top of this page
    2. Click *Download ZIP* from the drop-down list

* Via Git
    * Run `git clone https://github.com/m455/rodo` on the command line

# Setup

Follow the steps below to set up `rodo` on your platform, if available.

## GNU/Linux

Follow the steps below to add `rodo` to your `$PATH`.

### Set up a `$PATH`

Follow the steps below if you haven't set up a `$PATH`. If you have set up a `$PATH` already,
then skip to the next step, [Adding `rodo` to your `$PATH`](https://github.com/m455/rodo#adding-rodo-to-your-path).

1. Create a directory for your `$PATH` by running `mkdir ~/bin/`
2. Add your newly-created `~/bin/` to your `$PATH` by running `echo "export PATH=~/bin:\$PATH" >> .bashrc`

### Adding `rodo` to your `$PATH`

Follow the steps below if you have set up your `$PATH`.

1. Create a file in your `~/bin/` directory with the following contents in it:

```
#!/usr/bin/env bash
racket ~/path/to/rodo.rkt "$@"
```

Note: If you downloaded the project to your `~/downloads/` folder you would change the line
`racket ~/path/to/rodo.rkt "$@"` to `racket ~/downloads/rodo/rodo.rkt "$@"`.

2. Save the file

3. Make the file executable by running `chmod u+x ~/bin/name-of-your-file`

If you prefer to use an executable, rather than a wrapper,
you can create an executable binary file with `raco exe rodo.rkt` when in the same
folder as the `rodo.rkt` file. If you are having trouble with this please refer to Racket's documentation
regarding the [creation of standalone executables](https://docs.racket-lang.org/raco/exe.html).

# Usage

Type `rodo` plus one of the options below with a space
between `rodo` and the option.

`init` - Initializes a file called `todo-list` in `~/.rodo/` by default

`ls` - Lists items from the list

`add` - Adds an entry to the list

`rm` - Removes an item from the list

**Note:** You may have to run `rodo ls` to see which number corresponds to which item when removing items.

## Usage examples

The examples below assume that you have `rodo` [set up](https://github.com/m455/rodo#set-up-a-path) in your `$PATH`

`rodo init`

`rodo ls`

`rodo add bread` (Single-word entry) (**Soon the use of unquoted items will be depreciated**)

`rodo add "go to the bank"` (Multi-word entry)

`rodo rm 1`

# Configuring `rodo`

Right now, the configurations can be found in the `config.rkt file`. Settings, such as program name, path, and directory can be changed.

