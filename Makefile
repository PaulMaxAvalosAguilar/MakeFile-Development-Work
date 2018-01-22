#compiler and linker
CC = gcc
#/home/paul/raspi/tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian/bin/arm-linux-gnueabihf-gcc-4.8.3
VERSION= Debugx64
#Raspberry
CROSSCOMPILE_HOSTNAME = pi
CROSSCOMPILE_SSH_HOST = 192.168.1.70
CROSSCOMPILE_DIR = 	/home/pi

#The target binary program
TARGET = project

#The Directories, Source, Includes, Objects, Binary and Resources
SRCDIR      := src
INCDIR      := src/Fold
BUILDDIR    := Objects
TARGETDIR   := Release
RESDIR      := Resources
SRCEXT      := c
DEPEXT      := 
OBJEXT      := o

#Flags, Libraries and Includes
CFLAGS      := -g -Wall
LIB         := -lm 
INC         := -I/usr/local/include
INCDEP      := -I$(INCDIR)
	
#---------------------------------------------------------------------------------
#DO NOT EDIT BELOW THIS LINE
#---------------------------------------------------------------------------------
SOURCES     := $(shell find $(SRCDIR) -type f -name *.$(SRCEXT))
OBJECTS     := $(patsubst $(SRCDIR)/%,$(BUILDDIR)/$(VERSION)/%,$(SOURCES:.$(SRCEXT)=.$(OBJEXT))) 

#---------------------------------------------------------------------------------
#DEFAULT PART
all: resources $(TARGET)

#DIRECTORIES PART
directories: 
	@mkdir -p $(TARGETDIR)/$(VERSION)
	@mkdir -p $(BUILDDIR)/$(VERSION)
	@mkdir -p $(RESDIR)
	@mkdir -p $(SRCDIR)
	
resources: directories
	rsync -r --delete $(RESDIR) $(TARGETDIR)/$(VERSION)

#COMPILE & RUN PART
$(TARGET):  $(OBJECTS) 
	$(CC) -o $(TARGETDIR)/$(VERSION)/$(TARGET) $? $(LIB)

$(BUILDDIR)/$(VERSION)/%.$(OBJEXT): $(SRCDIR)/%.$(SRCEXT)
	@mkdir -p $(dir $@) #this works for whenever we have a folder it creates it
	$(CC) $(CFLAGS) -c $< $(INCDEP) -o $@  

run:	resources 
	./$(TARGETDIR)/$(VERSION)/$(TARGET)
	
sync: 
	rsync -r --delete ./$(TARGETDIR)/$(VERSION) $(CROSSCOMPILE_HOSTNAME)@$(CROSSCOMPILE_SSH_HOST):$(CROSSCOMPILE_DIR)

#Clean PART
clean:
	@$(RM) -rf $(BUILDDIR)

cleaner: clean
	@$(RM) -rf $(TARGETDIR)

.PHONY: all clean cleaner resources

