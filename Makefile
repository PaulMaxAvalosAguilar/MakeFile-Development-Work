include Makefile.config

#---------------------------------------------------------------------------------
#DO NOT EDIT BELOW THIS LINE
#---------------------------------------------------------------------------------

export

#DEFAULT PART
all: Application

#DIRECTORIES PART
directories: 
	@mkdir -p $(TARGETDIRECTORY)
	@mkdir -p $(BUILDDIRECTORY)
	@mkdir -p $(RESDIRECTORY)
	@mkdir -p $(LIBDIRECTORY)
	@mkdir -p $(SRC_MODULES_DIR)
	@mkdir -p $(HEADERSDIRECTORY)

	@for module in $(DEPMODULES); do\
		mkdir -p $(SRC_MODULES_DIR)/$$module/$(SRCDIR);\
	done

	@mkdir -p $(SRC_MODULES_DIR)/$(MAINMODULE)/$(SRCDIR)

installdirectories:
	@mkdir -p $(EXECINSTALLDIR)/
	@mkdir -p $(LIBINSTALLDIR)/
	@mkdir -p $(RESINSTALLDIR)/

Application: 

	@for module in $(DEPMODULES); do\
		make -C ./$(SRC_MODULES_DIR)/$$module;\
	done

	@make -C ./$(SRC_MODULES_DIR)/$(MAINMODULE)

run:	Application install
	./$(TARGETDIRECTORY)/$(VERSION)/$(TARGET)

sync: 
	@rsync -r --delete ./$(TARGETDIRECTORY)/$(VERSION) $(CROSSCOMPILE_HOSTNAME)@$(CROSSCOMPILE_SSH_HOST):$(CROSSCOMPILE_DIR)

#Clean PART
clean: 
	@$(RM) -rf $(BUILDDIRECTORY)/$(VERSION)/
	@$(RM) -rf $(LIBDIRECTORY)/$(VERSION)/
	@$(RM) -rf $(TARGETDIRECTORY)/$(VERSION)/
	@$(RM) -rf $(HEADERSDIRECTORY)/*

install: installdirectories 
	@echo Running shared libraries install commands
	@rsync -r --delete ./$(LIBDIRECTORY)/$(VERSION)/*.so  $(LIBINSTALLDIR)
	@echo Libraries installed

	@echo Running executable install command
	@rsync -r --delete ./$(TARGETDIRECTORY)/$(VERSION)/$(TARGET) $(EXECINSTALLDIR)
	@echo Executable installed

	@echo Running resources install commands
	@rsync -r --delete  $(RESDIRECTORY) $(RESINSTALLDIR)
	@echo Resources installed

uninstall:
	@echo Running shared libraries uninstall commands
	$(eval SOURCEDYLIBS := $(shell find $(LIBDIRECTORY)/$(VERSION) -type f -name *.$(DLEXT)))
	$(eval DYLIBS	:= $(patsubst $(LIBDIRECTORY)/$(VERSION)%,%,$(SOURCEDYLIBS)))
	@echo Running libraries uninstall command
	@for library in $(DYLIBS); do\
		$(RM) $(LIBINSTALLDIR)$$library;\
	done
	@echo Libraries uninstalled

	@echo Running executable uninstall command
	@rm $(EXECINSTALLDIR)/$(TARGET)
	@echo Executable uninstalled

	@echo Running resources uninstall commands
	$(eval ALLRESTOBEDELETED := $(shell find ./$(RESDIRECTORY)))
	$(eval RESTOBEDELETED := $(patsubst .%,%,$(ALLRESTOBEDELETED)))

	@for files in $(RESTOBEDELETED); do\
		$(RM) $$files;\
	done
	@echo Resources uninstalled
