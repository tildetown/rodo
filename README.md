# rodo

A easy-to-use todo list program for people who live on the command line

# Screenshot

![](screenshot.png)

# New things!

Now the default directory and todo list file have better default permissions:

* `rodo` is now license under AGPL3!
* `~/.rodo/` is set to 700 by default
* `~/.rodo/todo.txt` is set to 600 by default.

# Todos

- Update README so it's up to "technical writing standards"
- Add color option to `config.rkt` file
- Encrypt `todo.txt` file

# TL;DR

1. Make sure [Racket](https://racket-lang.org/) is installed
2. `git clone https://github.com/m455/rodo` into a directory of your choice
3. `cd` into the `rodo` directory
4. Run one of the following commands:
    * To use `rodo` using the Racket interpreter run: `racket rodo.rkt`
    * To use `rodo` as an single-file executable follow the two steps below:
        1. Run `raco exe rodo.rkt` to compile the `rodo` into a single-file executable
        2. Run `./rodo`
5. (optional) Add the following to your `$PATH` directory to run `rodo` from
anywhere.

```
#!/usr/bin/env bash
racket ~/path/to/rodo.rkt "$@"
```

Note: If you made an executable, remember to change the `rodo.rkt` part above to just `rodo`

# Table of Contents

* [Platforms](https://github.com/m455/rodo#platforms)
* [Requirements](https://github.com/m455/rodo#requirements)
* [Downloading](https://github.com/m455/rodo#downloading)
* [Setup](https://github.com/m455/rodo#setup)
* [Usage](https://github.com/m455/rodo#usage)
    * [Usage examples](https://github.com/m455/rodo#usage-examples)
* [Configuration](https://github.com/m455/rodo#configuring-rodo)

# Platforms

Below is a list of platform(s) that `rodo` is currently available for.

* Unix-like operating systems:
    * Windows Subsystem for Linux (Tested)
    * GNU/Linux (Untested)
    * macOS (Untested)

# Requirements

Below is a list of items needed for running `rodo` on your machine.

* [Racket 6.x](https://racket-lang.org/)

# Downloading

Run the command below to download `rodo` using the `git` command.

```
git clone https://github.com/m455/rodo
```

# Setup

Follow the sections below to set up `rodo`, so it can be used from anywhere on
your system.

**Tip: If you just want to test `rodo` out, then just `cd` into the directory you downloaded
`rodo` into, and then run `./rodo.rkt`.**

## Set up a `$PATH`

Follow the steps below if you haven't set up a `$PATH`.

**Tip: If you have set up a `$PATH` already, then skip to the next step, [Adding
`rodo` to your `$PATH`](https://github.com/m455/rodo#adding-rodo-to-your-path).**

1. Create a directory for your `$PATH` by running `mkdir ~/bin/`
2. Add your newly-created `~/bin/` to your `$PATH` by running `echo "export PATH=~/bin:\$PATH" >> .bashrc`

## Adding `rodo` to your `$PATH`

Follow the steps below to add the `rodo.rkt` file to your `$PATH`.

**Tip: If you prefer to use an executable, rather than a wrapper (see the note after step one below to see what a "wrapper" is), you can create an
executable binary file with `raco exe rodo.rkt` when in the same folder as the
`rodo.rkt` file. If you are having trouble with the `raco exe` command, refer to Racket's
documentation regarding the [creation of standalone executables](https://docs.racket-lang.org/raco/exe.html).**

1. Create a file in your `~/bin/` directory with the following contents in it:

```
#!/usr/bin/env bash
racket ~/path/to/rodo.rkt "$@"
```

**Note: The file created above is called a "wrapper". This is a script that
runs the `rodo.rkt` file through the Racket interpreter. If you wish to
directly run `rodo` as an executable from your `$PATH`, see the tip above**

For example: If you downloaded the project to your `~/downloads/` folder you would change the line
`racket ~/path/to/rodo.rkt "$@"` to `racket ~/downloads/rodo/rodo.rkt "$@"`.

2. Save the file

3. Make the file executable by running `chmod u+x ~/bin/name-of-your-file`

# Usage

Type `rodo` plus one of the commands below with a space
between `rodo` and the command.

`-h` or `--help` - Displays the help message

`init` - Creates a file called `todo.txt` in `~/.rodo/` by default

**Note: The directory and filename can be changed by modifying the `config.rkt` file**

`ls` - Displays numbered items in the todo list

`add` - Adds an item to the todo list

`rm` - Removes an item from the todo list

**Note: You may have to run `rodo ls` to see which number corresponds to which item when removing items.**

## Usage examples

The examples below assume that you have `rodo` [set up in your `$PATH`](https://github.com/m455/rodo#set-up-a-path) in your `$PATH`

`rodo -h`

`rodo --help`

`rodo init`

`rodo ls`

`rodo add "this is a task"`

`rodo add this is a task without quotes`

`rodo rm 1`

**Note: You may have to run `rodo ls` to see which number corresponds to which item when removing items.**

# Configuring `rodo`

**Caution: Change the `config.rkt` file at your own risk, as it may break things!**

Right now, the configurations can be found in the `config.rkt file`. Settings,
such as the program name, directory, and the filename of the todo list file can
be changed.

