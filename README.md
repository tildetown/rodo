# rodo

An easy-to-use todo list program for people who live on the command line written in Racket.

### Requirements

* GNU/Linux
* Racket 6.x

### Setting up rodo

#### Using the Linux binary

Download rodo by running: 

`git clone https://github.com/m455/rodo`

Create a $PATH if you haven't done so already by running: 

`echo "export PATH=~/bin:\$PATH" >> .bashrc`

Make the actual directory for your `$PATH`:

`mkdir ~/bin/`

Add the `rodo` binary to your $PATH folder (in your ~/bin/ folder if you followed the instructions above) and make sure it's executable: 

`chmod u+x ~/bin/rodo`

#### Manually

Download rodo by running: 

`git clone https://github.com/m455/rodo`

Create a $PATH if you haven't done so already by running: 

`echo "export PATH=~/bin:\$PATH" >> .bashrc`

Make the actual directory for your `$PATH`:

`mkdir ~/bin/`

Create a file called `rodo` in your $PATH folder (in your ~/bin/ folder if you followed the instructions above) and add the
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

`chmod u+x ~/bin/rodo`

## Usage

The below examples assume that you have rodo set up in your
$PATH folder. If you don't, you would simply go to the
directory of the `rodo.rkt` file and use `./rodo <command>`
instead.

### init

Initializes a file in `~/.rodo/todo-list` by default

Example: `rodo init`

### ls

Lists items from the list
	
Example: `rodo ls`

### add

Adds an item to the list

Example: `rodo add bread`

**Note:** For multi-word items you will need to surround your item in double quotes like this:
`$ rodo add "go to the bank"`

### rm

Removes an item from the list
	
Example: `rodo rm 1`

**Note:** You may have to run `rodo ls` to see which number corresponds to which item to remove it.

## Configuring rodo

Right now, the configurations can be found in the `config.rkt` file. Settings such at program name, path, and directory can be set here.
