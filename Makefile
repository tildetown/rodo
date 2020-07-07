program-name = rodo
directory-local = ~/.local/bin
directory-global = /usr/local/bin
directory-source = src
directory-current = .

file-source = $(program-name).rkt
file-source-origin = $(directory-source)/$(file-source)

file-executable = $(program-name)
file-executable-local = $(directory-local)/$(file-executable)
file-executable-global = $(directory-global)/$(file-executable)
file-executable-origin= $(directory-source)/$(file-executable)
file-executable-current= $(directory-current)/$(file-executable)

.PHONY: help
help:
	@echo "Usage"
	@echo "    make command [<args>]"
	@echo ""
	@echo "Commands:"
	@echo "    help             	   - Displays this help message"
	@echo "    clean            	   - Removes the $(file-executable) executable from $(directory-source)/"
	@echo "    build                   - Creates a $(file-executable) executable in your current directory"
	@echo "    install-global   	   - Installs a $(file-executable) executable in $(directory-global)/"
	@echo "    uninstall-global 	   - Deletes a $(file-executable) executable from $(directory-global)/"
	@echo "    install-local           - Installs a $(file-executable) executable in $(directory-local)/"
	@echo "    uninstall-local         - Deletes a $(file-executable) executable from $(directory-local)/"
	@echo "    install-custom [<args>] - Installs a $(file-executable) executable in a custom location"
	@echo ""
	@echo "Examples:"
	@echo "    make help"
	@echo "    make clean"
	@echo "    make build"
	@echo "    sudo make install-global"
	@echo "    sudo make uninstall-global"
	@echo "    make install-local"
	@echo "    make uninstall-local"
	@echo "    make install-custom custom-location=~/bin/"
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
	@echo "Uninstalling $(file-executable) from $(file-executable-local) ..."
	@rm $(file-executable-local)

.PHONY: uninstall-global
uninstall-global:
	@echo "Uninstalling $(file-executable) from $(file-executable-global) ..."
	@rm $(file-executable-global)

# Installation -----------------------------------------------------------
.PHONY: install-custom
install-custom: build
	@echo "Moving $(file-executable-current) to $(custom-location) ..."
	@mv $(file-executable-current) $(custom-location)

.PHONY: install-local
install-local: build
	@echo "Moving $(file-executable-current) to $(file-executable-local) ..."
	@mv $(file-executable-current) $(file-executable-local)

.PHONY: install-global
install-global: build
	@echo "Moving $(file-executable-current) to $(file-executable-global) ..."
	@mv $(file-executable-current) $(file-executable-global)

.PHONY: clean
clean:
	@echo "Deleting any $(file-executable) executables found in your current folder ..."
	@rm $(file-executable-current)

build:
	@echo "Creating $(file-executable-origin) executable from $(file-source-origin) ..."
	@raco exe $(file-source-origin)
	@echo "Moving $(file-executable-origin) executable to your current folder ..."
	@mv $(file-executable-origin) $(directory-current)/
