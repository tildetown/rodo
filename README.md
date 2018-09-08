# rodo

An easy-to-use todo list program for people who live on the command line written in Racket

# Table of Contents

* [Legend](https://github.com/m455/rodo#legend)
* [Platforms](https://github.com/m455/rodo#platforms)
* [Requirements](https://github.com/m455/rodo#requirements)
* [Download](https://github.com/m455/rodo#download)
	* [Via Browser](https://github.com/m455/rodo#via-browser)
	* [Via Git](https://github.com/m455/rodo#via-git)
* [Setup](https://github.com/m455/rodo#setup)
	* [GNU/Linux](https://github.com/m455/rodo#gnulinux)
		* [Setup a $PATH](https://github.com/m455/rodo#setup-a-path)
		* [Using the binary](https://github.com/m455/rodo#using-the-binary)
		* [Creating a wrapper](https://github.com/m455/rodo#creating-a-wrapper)
	* [Windows](https://github.com/m455/rodo#windows)
	* [Mac](https://github.com/m455/rodo#mac)
* [Usage](https://github.com/m455/rodo#usage)
* [Configuration](https://github.com/m455/rodo#configuring-rodo)

## Legend

`Items marked like this` are instructions for running on the command line

**Items marked like this** are keywords, buttons, variables or specific files/folders

## Platforms

* GNU/Linux
* Microsoft Windows
* OS X

## Requirements

* [Racket 6.x](https://racket-lang.org/)
* [Git (Optional)](https://git-scm.com/)

## Download

### Via Browser

Download this repository by clicking the **Clone or download** button at the top right and then choosing **Download ZIP** from the drop-down list

### Via Git

Run `git clone https://github.com/m455/rodo` at the command line if you use Git

## Setup

### GNU/Linux

#### Setup a $PATH

1. Create a directory for your **$PATH** by running `mkdir ~/bin/`

2. Associate your **$PATH** with the **~/bin/** folder you created by running `echo "export PATH=~/bin:\$PATH" >> .bashrc`

#### Using the binary

1. Copy the **rodo** binary file to your **$PATH** folder by running `cp /path/to/rodo ~/bin/`

2. Make sure the **rodo** binary file is executable by running `chmod u+x ~/bin/rodo`

#### Creating a wrapper

1. Create an empty wrapper file by running `touch ~/bin/rodo` and then add the following contents to it and save: 

```
#!/usr/bin/env bash
racket ~/path/to/rodo.rkt "$@"
```

**Example**: if you downloaded the project to your **~/downloads/** folder you would change the line **racket ~/path/to/rodo.rkt "$@"** to **racket ~/downloads/rodo/rodo.rkt "$@"**

2. Make the **rodo** wrapper file executable by running`chmod u+x ~/bin/rodo`

### Windows

*No instructions yet*

### Mac

*No instructions yet*

## Usage

The below examples assume that you have **rodo** [set up](https://github.com/m455/rodo#setup-a-path) in your **$PATH** folder. 

`init` - Initializes a file in **~/.rodo/todo-list** by default

Example: `rodo init`

`ls` - Lists items from the list
	
Example: `rodo ls`

`add` - Adds an entry to the list

Example of adding a single-word entry: `rodo add bread`

Example of adding a multi-word entry: `rodo add "go to the bank"`

`rm` - Removes an item from the list
	
Example: `rodo rm 1`

**Note:** You may have to run `rodo ls` to see which number corresponds to which item to remove it.

## Configuring rodo

Right now, the configurations can be found in the **config.rkt** file. Settings such at **program name**, **path**, and **directory** can be set here.
