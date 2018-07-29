# rodo

A command-line todo list written in Racket

## Getting started

The following instructions will get you a copy of the
project for use on your local machine

### Requirements

* GNU/Linux
* Racket 6.x

### Setting up rodo

Download from your terminal by running: 

`git clone https://github.com/m455/rodo`

Create a $PATH if you haven't done so already: 

`echo "export PATH=~/bin:$PATH" >> .bashrc`

Create a file called `rodo` in your $PATH and add the
following contents to it: 

```
#!/usr/bin/env bash
racket ~/path/to/rodo.rkt "$@"
```
For example, if you `git clone`d the project to your
`~/downloads/` folder you would change the line:

`racket ~/path/to/rodo.rkt "$@"` 

to 

`racket ~/downloads/rodo/rodo.rkt "$@"`

Make the `rodo` file executable: 

`chmod u+x rodo`

## Usage

The below examples assume that you have rodo set up in your
$PATH folder. If you don't, you would simply go to the
directory of the `rodo.rkt` file and use `./rodo <command>`
instead.

### `init`

Initializes a file in `~/.rodo/todo-list` by default

**Example:** `rodo init`

### `ls`

Lists items from the list
	
 **Example:** `rodo rm 1`

### `add`

Adds an item to the list

**Example:** `rodo add bread`

**Note:** For multi-word items you will need to surround your item in double quotes like this:
`$ rodo add "go to the bank"`

### `rm`

Removes an item from the list
	
**Example:** `rodo rm 1`

**Note:** You may have to run `rodo ls` to see which number corresponds to which item to remove it.

## Configuring rodo

Right now, the configurations can be found in the `config.rkt` file. Settings such at program name, path, and directory can be set here.
