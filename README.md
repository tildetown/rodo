# rodo

A simple to-do list program for people who live on the command-line

![](screenshot.png)

# Table of Contents

* [Platforms](https://github.com/m455/rodo#platforms)
* [Requirements](https://github.com/m455/rodo#requirements)
* [Downloading](https://github.com/m455/rodo#downloading)
* [Setup](https://github.com/m455/rodo#setup)
	* [GNU/Linux](https://github.com/m455/rodo#gnulinux)
* [Usage](https://github.com/m455/rodo#usage)
* [Examples](https://github.com/m455/rodo#examples)
* [Configuration](https://github.com/m455/rodo#configuring-rodo)

## Platforms

* GNU/Linux

## Requirements

* [Racket 6.x](https://racket-lang.org/)
* [Git (Optional)](https://git-scm.com/)

## Downloading

* Via Browser
	* Download this repository by clicking the **Clone or download** button at the top right, then choose **Download ZIP** from the drop-down list

* Via Git
	* Run `git clone https://github.com/m455/rodo` at the command line

## Setup

The steps below will assist the user in setting up rodo

### GNU/Linux

1. Setup a $PATH
	1. Create a directory for your `$PATH` by running `mkdir ~/bin/`
	2. Associate your `$PATH` with the ~/bin/ folder you created by running `echo "export PATH=~/bin:\$PATH" >> .bashrc`

2. Using the binary
	1. Copy the rodo binary file to your `$PATH` folder by running `cp /path/to/rodo ~/bin/`
	2. Make the rodo binary file executable by running `chmod u+x ~/bin/rodo`

3. Creating a wrapper
	1. Create an empty wrapper file by running `touch ~/bin/rodo`. 
	2. Add the following contents show below to it
	```
	#!/usr/bin/env bash
	racket ~/path/to/rodo.rkt "$@"
	```
	For example, if you downloaded the project to your ~/downloads/ folder you would change the line `racket ~/path/to/rodo.rkt "$@"` to `racket ~/downloads/rodo/rodo.rkt "$@"`
	
	3. Save the file
	4. Make the rodo wrapper file executable by running`chmod u+x ~/bin/rodo`

## Usage

init - Initializes a file in ~/.rodo/todo-list by default

ls - Lists items from the list

add - Adds an entry to the list

rm - Removes an item from the list

**Note:** You may have to run `rodo ls` to see which number corresponds to which item when removing items.

## Examples

The examples below assume that you have rodo [set up](https://github.com/m455/rodo#setup-a-path) in your `$PATH`

init - `rodo init`

ls - `rodo ls`

add (Single-word entry) - `rodo add bread`

add (Multi-word entry) - `rodo add "go to the bank"`

rm - `rodo rm 1`

## Configuring rodo

Right now, the configurations can be found in the config.rkt file. Settings such at program name, path and directory can be set here.

