#Compiler and linker
#Archiver
#Version
#The target binary program
#Flags -g -Wall
#Remote crosscompiling sync
#Write Macros -D

CC 	:= gcc
ARCH	:= ar
VERSION	:= Debugx64
TARGET 	:= Application
CFLAGS	:= -g -Wall
MACROS	:= -D DEBUG\
#-D release

CROSSCOMPILE_HOSTNAME 	:= pi
CROSSCOMPILE_SSH_HOST 	:= 192.168.1.70
CROSSCOMPILE_DIR 	:= /home/pi
#/home/paul/raspi/tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian/bin/arm-linux-gnueabihf-gcc-4.8.3
#Raspberry

#------------------------------------------------------------------------------------------------------------

#The Directories, Source, Includes, Objects, Binary and Resources
SRC_MODULES_DIR	:= Src_Modules
BUILDDIRECTORY 	:= Objects
TARGETDIRECTORY	:= Release
RESDIR      	:= Resources
LIBDIRECTORY	:= Libraries

#Modules Names
MODULEA := Application
MODULEB := StaticLibTest
MODULEC := Namesapces_Struct_CompositionTest
MODULED := DataStructures

export

#DEFAULT PART
all: resources Application

#DIRECTORIES PART
directories: 
	@mkdir -p $(TARGETDIRECTORY)
	@mkdir -p $(BUILDDIRECTORY)
	@mkdir -p $(RESDIR)
	@mkdir -p $(LIBDIRECTORY)
	@mkdir -p $(SRC_MODULES_DIR)

	@mkdir -p $(SRC_MODULES_DIR)/$(MODULEA)/
	@mkdir -p $(SRC_MODULES_DIR)/$(MODULEB)/
	@mkdir -p $(SRC_MODULES_DIR)/$(MODULEC)/
	@mkdir -p $(SRC_MODULES_DIR)/$(MODULED)/

resources: directories
	rsync -r --delete $(RESDIR) $(TARGETDIRECTORY)/$(VERSION)

Application:
#Execute first Dependencies(Aka Libraries) Modules
	make -C ./$(SRC_MODULES_DIR)/$(MODULEB)
#Execute at last Main Module
	make -C ./$(SRC_MODULES_DIR)/$(MODULEA)

run:	resources 
	./$(TARGETDIRECTORY)/$(VERSION)/$(TARGET)

sync: 
	@rsync -r --delete ./$(TARGETDIRECTORY)/$(VERSION) $(CROSSCOMPILE_HOSTNAME)@$(CROSSCOMPILE_SSH_HOST):$(CROSSCOMPILE_DIR)

#Clean PART
clean:
	@$(RM) -rf $(BUILDDIRECTORY)

cleaner: clean
	@$(RM) -rf $(TARGETDIRECTORY)
	@$(RM) -rf $(LIBDIRECTORY)

.PHONY: all directories resources clean cleaner

