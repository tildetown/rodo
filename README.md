# rodo

A command-line todo list in Racket

## Commands

### `init`

Initializes a file in *~/.rodo/todo-list*

**Example:** `$ rodo init`

### `ls`

Lists items from the list
	
 **Example:** `$ rodo rm 1`

### `add`

Adds an item to the list

**Example:** `$ rodo add bread`

**Note:** For multi-word items you will need to surround your item in double quotes like this:
`$ rodo add "go to the bank"`

### `rm`

Removes an item from the list
	
**Example:** `$ rodo rm 1`

**Note:** You may have to run `rodo ls` to see which number corresponds to which item to remove it.

## Configure rodo

Right now, the configurations can be found in the `config.rkt` file. Settings such at program name, path, and directory can be set here.
