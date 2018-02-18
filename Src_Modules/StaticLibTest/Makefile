


#The Directories, Source, Includes, Objects, Binary and Resources
SRCDIR      := src
BUILDDIR    := ../../$(BUILDDIRECTORY)
LIBDIR	    := ../../$(LIBDIRECTORY)
SRCEXT      := c
OBJEXT      := o

#write -I $(INCDIR)
INCDEP      := 

#---------------------------------------------------------------------------------
#DO NOT EDIT BELOW THIS LINE
#---------------------------------------------------------------------------------
SOURCES     := $(shell find $(SRCDIR) -type f -name *.$(SRCEXT))
OBJECTS     := $(patsubst $(SRCDIR)/%,$(BUILDDIR)/$(VERSION)/%,$(SOURCES:.$(SRCEXT)=.$(OBJEXT))) 

#---------------------------------------------------------------------------------
#DEFAULT PART
all: directories library

#DIRECTORIES PART
directories:
	@mkdir -p $(LIBDIR)/$(VERSION)
	@mkdir -p $(BUILDDIR)/$(VERSION)


#COMPILE PART
library:  $(OBJECTS) 
	$(ARCH) rcs $(LIBDIR)/$(VERSION)/lib$(MODULEB).a $?

$(BUILDDIR)/$(VERSION)/%.$(OBJEXT): $(SRCDIR)/%.$(SRCEXT)
	@mkdir -p $(dir $@) #this works for whenever we have a folder it creates it
	$(CC) $(CFLAGS) $(MACROS) -c $< $(INCDEP) -o $@  

.PHONY: all directores LIBRARY
