# rodo

An easy-to-use todo list program for people who live on the command line written in Racket

# Table of Contents

* [Platforms](https://github.com/m455/rodo#platforms)
* [Requirements](https://github.com/m455/rodo#requirements)
* [Download](https://github.com/m455/rodo#download)
	* [Via Browser](https://github.com/m455/rodo#via-browser)
	* [Via Git](https://github.com/m455/rodo#via-git)
* [Setup](https://github.com/m455/rodo#setting-up-rodo)
	* [GNU/Linux](https://github.com/m455/rodo#gnulinux)
		* [Using the executable binary](https://github.com/m455/rodo#using-the-executable-binary)
		* [Using and creating a wrapper](https://github.com/m455/rodo#using-and-creating-a-wrapper)
	* [Windows](https://github.com/m455/rodo#windows)
	* [Mac](https://github.com/m455/rodo#mac)
* [Usage](https://github.com/m455/rodo#usage)
	* [init](https://github.com/m455/rodo#init)
	* [ls](https://github.com/m455/rodo#ls)
	* [add](https://github.com/m455/rodo#add)
 		* [Adding a single-word entry](https://github.com/m455/rodo#adding-a-single-word-entry)
		* [Adding a multi-word entry](https://github.com/m455/rodo#adding-a-multi-word-entry)
	* [rm](https://github.com/m455/rodo#rm)
* [Configuration](https://github.com/m455/rodo#configuring-rodo)

## Platforms

* GNU/Linux
* Microsoft Windows
* OS X

## Requirements

* [Racket 6.x](https://racket-lang.org/)
* [Git (Optional)](https://git-scm.com/)

## Download

### Via Browser

Download this repository by clicking the `Clone or download` button at the top right and then by clicking `Download ZIP` from the drop-down list

### Via Git

Run `git clone https://github.com/m455/rodo` at the command line if you use Git

## Setup

### GNU/Linux

#### Using the executable binary

Create a **$PATH** if you haven't done so already by running `echo "export PATH=~/bin:\$PATH" >> .bashrc`

Make the actual directory for your **$PATH** by running `mkdir ~/bin/`

Add the **rodo** binary to your **$PATH** folder (in your **~/bin/** folder if you followed the instructions above) and make sure it's executable by running `chmod u+x ~/bin/rodo`

#### Using and creating a wrapper

Create a file called **rodo** in your **$PATH** folder (in your **~/bin/** folder if you followed the instructions above) by running `touch ~/bin/rodo` and then add the following contents to it: 
```
#!/usr/bin/env bash
racket ~/path/to/rodo.rkt "$@"
```
For example, if you downloaded the project to your `~/downloads/` folder you would change the line `racket ~/path/to/rodo.rkt "$@"` to `racket ~/downloads/rodo/rodo.rkt "$@"`

Make the **rodo** file executable by running`chmod u+x ~/bin/rodo`

### Windows

*Instructions coming soon*

### Mac

*Instructions coming soon*

## Usage

The below examples assume that you have **rodo** set up in your **$PATH** folder. If you don't, you would navigate to the directory of the **rodo.rkt** file and use `./rodo.rkt <command>` if the **rodo.rkt** is executable or `racket rodo.rkt <command>` if it is not.

### init

Initializes a file in `~/.rodo/todo-list` by default

Example: `rodo init`

### ls

Lists items from the list
	
Example: `rodo ls`

### add

Adds an entry to the list

#### Adding a single-word entry

Example: `rodo add bread`

#### Adding a multi-word entry

Example: `rodo add "go to the bank"`

### rm

Removes an item from the list
	
Example: `rodo rm 1`

**Note:** You may have to run `rodo ls` to see which number corresponds to which item to remove it.

## Configuring rodo

Right now, the configurations can be found in the `config.rkt` file. Settings such at **program name**, **path**, and **directory** can be set here.
