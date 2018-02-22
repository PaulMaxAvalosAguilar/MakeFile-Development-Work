#Library name
LIBNAME     := $(MODULEC)

#The Directories, Source, Includes, Objects, Binary and Resources
SRCDIR      := src
SRCEXT      := c
OBJEXT      := o

#write -I $(INCDIR)
INCDEP      := 

#---------------------------------------------------------------------------------
#DO NOT EDIT BELOW THIS LINE
#---------------------------------------------------------------------------------
BUILDDIR    := ../../$(BUILDDIRECTORY)/$(VERSION)
LIBDIR	    := ../../$(LIBDIRECTORY)/$(VERSION)

SOURCES     := $(shell find $(SRCDIR) -type f -name *.$(SRCEXT))
OBJECTS     := $(patsubst $(SRCDIR)/%,$(BUILDDIR)/%,$(SOURCES:.$(SRCEXT)=.$(OBJEXT))) 

#---------------------------------------------------------------------------------

#COMPILE PART
$(LIBDIR)/lib$(LIBNAME).so:  $(OBJECTS) 
	@mkdir -p $(dir $@)
	$(CC) -shared -o  $@ $?

$(BUILDDIR)/%.$(OBJEXT): $(SRCDIR)/%.$(SRCEXT)
	@mkdir -p $(dir $@) 
	$(CC) $(CFLAGS) $(MACROS) -fPIC -c $< $(INCDEP) -o $@  

