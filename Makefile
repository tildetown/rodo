program-name = rodo
program-source = $(program-name).rkt

directory-local = ~/.local/bin
directory-global = /usr/local/bin
directory-source = src

.PHONY: help
help:
	@echo "Usage"
	@echo "    make <command> [<args>]"
	@echo ""
	@echo "Commands:"
	@echo "    help"
	@echo "        Displays this help message"
	@echo ""
	@echo "    clean"
	@echo "        Removes the $(program-name) executable from $(directory-source)/"
	@echo ""
	@echo "    build"
	@echo "        Creates a $(program-name) executable in your current directory"
	@echo ""
	@echo "    install-global"
	@echo "        Installs a $(program-name) executable in $(directory-global)/"
	@echo "        Note: This command requires sudo or root access"
	@echo ""
	@echo "    uninstall-global"
	@echo "        Deletes a $(program-name) executable from $(directory-global)/"
	@echo "        Note: This command requires sudo or root access"
	@echo ""
	@echo "    install-local"
	@echo "        Installs a $(program-name) executable in $(directory-local)/"
	@echo ""
	@echo "    uninstall-local"
	@echo "        Deletes a $(program-name) executable from $(directory-local)/"
	@echo ""
	@echo "    install-custom location=<args>"
	@echo "        Installs a $(program-name) executable in a custom location"
	@echo ""
	@echo "Examples:"
	@echo "    make help"
	@echo "    make clean"
	@echo "    make build"
	@echo "    sudo make install-global"
	@echo "    sudo make uninstall-global"
	@echo "    make install-local"
	@echo "    make uninstall-local"
	@echo "    make install-custom location=~/bin/"
	@echo ""
	@echo "Note: You will have to manually uninstall custom installations"


.PHONY: install
install:
	@echo "Try running make help"

.PHONY: uninstall
uninstall:
	@echo "Try running make help"

# Uninstallation ---------------------------------------------------------
.PHONY: uninstall-local
uninstall-local:
	@echo "Uninstalling $(program-name) from $(directory-local) ..."
	@rm $(directory-local)/$(program-name)

.PHONY: uninstall-global
uninstall-global:
	@echo "Uninstalling $(program-name) from $(directory-global) ..."
	@rm $(directory-global)/$(program-name)

# Installation -----------------------------------------------------------
.PHONY: install-custom
install-custom: build
	@echo "Moving ./$(program-name) to $(location) ..."
	@mv ./$(program-name) $(location)

.PHONY: install-local
install-local: build
	@echo "Moving ./$(program-name) to $(directory-local)/$(program-name) ..."
	@mv ./$(program-name) $(directory-local)/$(progam-name)

.PHONY: install-global
install-global: build
	@echo "Moving ./$(program-name) to $(directory-global)/$(program-name) ..."
	@mv ./$(program-name) $(directory-global)/$(progam-name)

.PHONY: clean
clean:
	@echo "Deleting any $(program-name) executables found in your current folder ..."
	@rm ./$(program-name)

build:
	@echo "Creating a $(directory-source)/$(program-name) executable from $(directory-source)/$(program-source) ..."
	@raco exe $(directory-source)/$(program-source)
	@echo "Moving $(directory-source)/$(program-name) executable to your current folder ..."
	@mv $(directory-source)/$(program-name) ./
