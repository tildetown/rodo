# rodo

**rodo** is a command-line todo list written in Racket

## Getting started

The following instructions will get you a copy of the
project for use on your local machine

### Requirements

* GNU/Linux
* Racket 6.x

## Setting up rodo

1. Download from your terminal by running: 

`git clone https://github.com/m455/rodo`

2. Create a $PATH if you haven't done so already: 

`echo "export PATH=~/bin:$PATH" >> .bashrc`

3. Create a file called `rodo` in your $PATH: 

```
#!/usr/bin/env bash
racket ~/path/to/rodo.rkt "$@"
```
(For example, if you `git clone`d the project to your
`~/downloads/` folder you would change `racket
~/path/to/rodo.rkt "$@"` to 'racket
~/downloads/rodo/rodo.rkt "$@"`)

4. Make the `rodo` file executable: 

`chmod u+x rodo`

### Usage

## `init`

Initializes a file in *~/.rodo/todo-list*

**Example:** `$ rodo init`

## `ls`

Lists items from the list
	
 **Example:** `$ rodo rm 1`

## `add`

Adds an item to the list

**Example:** `$ rodo add bread`

**Note:** For multi-word items you will need to surround your item in double quotes like this:
`$ rodo add "go to the bank"`

## `rm`

Removes an item from the list
	
**Example:** `$ rodo rm 1`

**Note:** You may have to run `rodo ls` to see which number corresponds to which item to remove it.

## Configure rodo

Right now, the configurations can be found in the `config.rkt` file. Settings such at program name, path, and directory can be set here.
