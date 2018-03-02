CROSSCOMPILE_HOSTNAME 	:= pi
CROSSCOMPILE_SSH_HOST 	:= 192.168.1.70
CROSSCOMPILE_DIR 	:= /home/pi
#/home/paul/raspi/tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian/bin/arm-linux-gnueabihf-gcc-4.8.3

#The Directories, Version, Libraries search and install directories
SRC_MODULES_DIR	:= Src_Modules
BUILDDIRECTORY 	:= Objects
TARGETDIRECTORY	:= Release
RESDIR      	:= Resources
LIBDIRECTORY	:= Libraries
VERSION		:= Debugx64
LIBSEARCHDIR	:= $(LIBDIRECTORY)/$(VERSION)/
LIBINSTALLDIR	:= 

#Compiler and archiver 

TARGET 	:= Application
CC 	:= gcc
ARCH	:= ar rcs
CFLAGS	:= -g -Wall
LDFLAGS	:= -Wl,-rpath,$(LIBSEARCHDIR)
MACROS	:= -D DEBUG
#-D release

DLEXT	:= so
SLEXT	:= a
SRCEXT	:= c
OBJEXT	:= o
SRCDIR	:= src

#Modules Names
MODULEA := Application
MODULEB := StaticLibTest
MODULEC	:= SharedLibTest
MODULED := DataStructures

#Write main module at last for correct linking
MODULES	:= $(MODULEC) $(MODULEB) $(MODULEA)

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

	@for module in $(MODULES); do\
		mkdir -p $(SRC_MODULES_DIR)/$$module;\
	done

resources:
	rsync -r --delete $(RESDIR) $(TARGETDIRECTORY)/$(VERSION)

Application:

	@for module in $(MODULES); do\
		make -C ./$(SRC_MODULES_DIR)/$$module;\
	done

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

