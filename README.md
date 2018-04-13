# rodo
A command-line todo list in Racket

* `init`: initialize a file in ~/.rodo/todo-list
	
    Example: `rodo init`

* `ls`: lists items on the list
	
    Example: `rodo rm 1`

* `add`: adds an item to the list

	Example: `rodo add bread`

	Note: For multi-word items you will need to
	surround your item in double quotes as so:
	`rodo add "go to the bank"`

* `rm`: removes an item from the list
	
    Example: `rodo rm 1`

    Note: You may have to run `rodo ls` to see which
	number corresponds to which item to remove it.
	
