directory-local = ~/.local/bin
directory-global = /usr/local/bin
directory-source = src
directory-current = .

file-source = rodo.rkt
file-source-source = $(directory-source)/$(file-source)

file-executable = rodo
file-executable-local = $(directory-local)/$(file-executable)
file-executable-global = $(directory-global)/$(file-executable)
file-executable-source= $(directory-source)/$(file-executable)
file-executable-current= $(directory-current)/$(file-executable)

help:
	@echo "How to use this Makefile"
	@echo "    make [command]"
	@echo ""
	@echo "This Makefile supports the following commands:"
	@echo "    help             - Displays this help message"
	@echo "    clean            - Removes any $(file-executable) executable from $(directory-source)/"
	@echo "    build            - Creates a $(file-executable) in your current directory"
	@echo "    install-global   - Installs a $(file-executable) executable in $(directory-global)/"
	@echo "    uninstall-global - Deletes a $(file-executable) executable from $(directory-global)/"
	@echo "    install-local    - Installs a $(file-executable) executable in $(directory-local)/"
	@echo "    uninstall-local  - Deletes a $(file-executable) executable from $(directory-local)/"

install:
	@echo "Try running make help"

uninstall:
	@echo "Try running make help"

uninstall-local:
	@echo "Uninstalling $(file-executable) from $(file-executable-local) ..."
	@rm -f $(file-executable-local)

uninstall-global:
	@echo "Uninstalling $(file-executable) from $(file-executable-global) ..."
	@rm -f $(file-executable-global)

install-local: build
	@echo "Moving $(file-executable-current) to $(file-executable-local) ..."
	@mv $(file-executable-current) $(file-executable-local)

install-global: build
	@echo "Moving $(file-executable-current) to $(file-executable-global) ..."
	@mv $(file-executable-current) $(file-executable-global)

clean:
	@echo "Deleting any $(file-executable) executables found in your current folder ..."
	@rm -f $(file-executable-current)

build:
	@echo "Creating $(file-executable-source) executable from $(file-source-source) ..."
	@raco exe $(file-source-source)
	@echo "Moving $(file-executable-source) executable to your current folder ..."
	@mv $(file-executable-source) $(directory-current)/
