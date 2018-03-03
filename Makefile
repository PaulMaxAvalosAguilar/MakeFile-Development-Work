#CROSSCOMPILE SECTION
CROSSCOMPILE_HOSTNAME 	:= pi
CROSSCOMPILE_SSH_HOST 	:= 192.168.1.70
CROSSCOMPILE_DIR 	:= /home/pi

#The Directories and extensions SECTION
SRC_MODULES_DIR	:= Src_Modules
BUILDDIRECTORY 	:= Objects
TARGETDIRECTORY	:= Release
RESDIR      	:= Resources
LIBDIRECTORY	:= Libraries

DLEXT	:= so
SLEXT	:= a
SRCEXT	:= c
OBJEXT	:= o
SRCDIR	:= src

#Modules SECTION
MODULEA := Application
MODULEB := StaticLibTest
MODULEC	:= SharedLibTest
MODULED := DataStructures

DEPMODULES	:= $(MODULEC) $(MODULEB) 
MAINMODULE	:= $(MODULEA)

LIBSTOLINK    	:=  -l $(MODULEB)\
	-l $(MODULEC)

#Compiler and archiver SECTION
TARGET 		:= Application
VERSION		:= Debugx64
CC 		:= gcc
ARCH		:= ar rcs
LIBSEARCHDIR	:= $(LIBDIRECTORY)/$(VERSION)/
LIBSRSEARCHPATH	:= $(LIBDIRECTORY)/$(VERSION)/
LIBINSTALLDIR	:= 
CFLAGS		:= -g -Wall
LDFLAGS		:= -L ../../$(LIBSEARCHDIR) $(LIBSTOLINK) \
	-Wl,-rpath,$(LIBSRSEARCHPATH)
MACROS		:= -D DEBUG

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

.PHONY: all directories resources clean cleaner Application run sync install uninstall

