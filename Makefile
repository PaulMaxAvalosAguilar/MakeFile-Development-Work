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

#Write main module at last for correct linking
MODULES	:= $(MODULEB) $(MODULEA)

#---------------------------------------------------------------------------------
#DO NOT EDIT BELOW THIS LINE (JUST APPLICATION CALL ORDER)
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

	for module in $(MODULES); do\
		mkdir -p $(SRC_MODULES_DIR)/$$module;\
	done

resources:
	rsync -r --delete $(RESDIR) $(TARGETDIRECTORY)/$(VERSION)

Application:

	for module in $(MODULES); do\
		make -C ./$(SRC_MODULES_DIR)/$$module;\
	done

run:	
	./$(TARGETDIRECTORY)/$(VERSION)/$(TARGET)

sync: 
	@rsync -r --delete ./$(TARGETDIRECTORY)/$(VERSION) $(CROSSCOMPILE_HOSTNAME)@$(CROSSCOMPILE_SSH_HOST):$(CROSSCOMPILE_DIR)

#Clean PART
clean:
	@$(RM) -rf $(BUILDDIRECTORY)

cleaner: clean
	@$(RM) -rf $(TARGETDIRECTORY)
	@$(RM) -rf $(LIBDIRECTORY)

.PHONY: all directories resources clean cleaner Application

