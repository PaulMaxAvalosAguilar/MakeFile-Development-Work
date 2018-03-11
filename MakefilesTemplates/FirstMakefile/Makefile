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
	@mkdir -p $(RESDIR)
	@mkdir -p $(LIBDIRECTORY)
	@mkdir -p $(SRC_MODULES_DIR)
	@mkdir -p $(HEADERSDIRECTORY)

	@for module in $(DEPMODULES); do\
		mkdir -p $(SRC_MODULES_DIR)/$$module/$(SRCDIR);\
	done

	@mkdir -p $(SRC_MODULES_DIR)/$(MAINMODULE)/$(SRCDIR)

resources:
	rsync -r --delete $(RESDIR) $(TARGETDIRECTORY)/$(VERSION)

Application:

	@for module in $(DEPMODULES); do\
		make -C ./$(SRC_MODULES_DIR)/$$module;\
	done

	@make -C ./$(SRC_MODULES_DIR)/$(MAINMODULE)

run:	
	./$(TARGETDIRECTORY)/$(VERSION)/$(TARGET)

sync: 
	@rsync -r --delete ./$(TARGETDIRECTORY)/$(VERSION) $(CROSSCOMPILE_HOSTNAME)@$(CROSSCOMPILE_SSH_HOST):$(CROSSCOMPILE_DIR)

#Clean PART
clean: 
	@$(RM) -rf $(BUILDDIRECTORY)/$(VERSION)/
	@$(RM) -rf $(LIBDIRECTORY)/$(VERSION)/
	@$(RM) -rf $(TARGETDIRECTORY)/$(VERSION)/
	@$(RM) -rf $(HEADERSDIRECTORY)/*

install:
	@echo Running shared libraries install commands
	@sudo cp ./$(LIBDIRECTORY)/$(VERSION)/*.so  $(LIBINSTALLDIR)
	@echo Everything installed

uninstall:
	@echo Running shared libraries uninstall commands
	$(eval SOURCEDYLIBS := $(shell find $(LIBDIRECTORY)/$(VERSION) -type f -name *.$(DLEXT)))
	$(eval DYLIBS	:= $(patsubst $(LIBDIRECTORY)/$(VERSION)%,%,$(SOURCEDYLIBS)))
	@for library in $(DYLIBS); do\
		sudo $(RM) $(LIBINSTALLDIR)$$library;\
	done
	@echo Everything uninstalled

.PHONY: all directories resources clean  Application run sync install uninstall

