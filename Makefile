#Compiler and linker
#Version
#The target binary program
#Flags -g -Wall
#Remote crosscompiling sync
#Write Macros -D

CC 	:= gcc
VERSION	:= Debugx64
TARGET 	:= project
CFLAGS	:= -g -Wall
MACROS	:= -D DEBUG

CROSSCOMPILE_HOSTNAME 	:= pi
CROSSCOMPILE_SSH_HOST 	:= 192.168.1.70
CROSSCOMPILE_DIR 	:= /home/pi
#/home/paul/raspi/tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian/bin/arm-linux-gnueabihf-gcc-4.8.3
#Raspberry

#------------------------------------------------------------------------------------------------------------

#The Directories, Source, Includes, Objects, Binary and Resources
SRC_MODULES_DIR	:= Src_Modules
BUILDDIR    	:= Objects
TARGETDIR   	:= Release
RESDIR      	:= Resources
	
#Modules Names
MODULEA := Application
MODULEB := ModuleB

export

#DEFAULT PART
all: resources Application

#DIRECTORIES PART
directories: 
	@mkdir -p $(TARGETDIR)
	@mkdir -p $(BUILDDIR)
	@mkdir -p $(RESDIR)
	@mkdir -p $(SRC_MODULES_DIR)
	
#ModuleA
	@mkdir -p $(SRC_MODULES_DIR)/$(MODULEA)/src
	
#ModuleB
	@mkdir -p $(SRC_MODULES_DIR)/$(MODULEB)/src
	
resources: directories
	rsync -r --delete $(RESDIR) $(TARGETDIR)/$(VERSION)
	
#CompilePart
Application: 
	make -C ./$(SRC_MODULES_DIR)/$(MODULEA)
	
	
run:	resources 
	./$(TARGETDIR)/$(VERSION)/$(TARGET)
	
sync: 
	rsync -r --delete ./$(TARGETDIR)/$(VERSION) $(CROSSCOMPILE_HOSTNAME)@$(CROSSCOMPILE_SSH_HOST):$(CROSSCOMPILE_DIR)

#Clean PART
clean:
	@$(RM) -rf $(BUILDDIR)

cleaner: clean
	@$(RM) -rf $(TARGETDIR)

.PHONY: all directories resources clean cleaner

