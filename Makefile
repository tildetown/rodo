directory-local = ~/.local/bin
directory-global = /usr/local/bin
directory-source = src

file-source = rodo.rkt
file-source-source = $(directory-source)/$(file-source)

file-executable = rodo
file-executable-local = $(directory-local)/$(file-executable)
file-executable-global = $(directory-global)/$(file-executable)
file-executable-source= $(directory-source)/$(file-executable)

help:
	@echo "How to use this Makefile"
	@echo "    make [command]"
	@echo ""
	@echo "This Makefile supports the following commands:"
	@echo "    help             - Displays this help message"
	@echo "    clean            - Removes any $(file-executable) executable from $(directory-source)/"
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

install-local: executable
	@echo "Moving $(file-executable-source) to $(file-executable-local) ..."
	@mv $(file-executable-source) $(file-executable-local)

install-global: executable
	@echo "Moving $(file-executable-source) to $(file-executable-global) ..."
	@mv $(file-executable-source) $(file-executable-global)

clean:
	@echo "Deleting any $(file-executable) executables found at $(file-executable-source) ..."
	@rm -f $(file-executable-source)

executable:
	@echo "Creating $(file-executable-source) executable from $(file-source-source) ..."
	@raco exe $(file-source-source)
