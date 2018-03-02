#Library name
LIBNAME     := $(MODULEB)

#The Directories, Source, Includes, Objects, Binary and Resources
SRCDIR      := src

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
$(LIBDIR)/lib$(LIBNAME).$(SLEXT):  $(OBJECTS) 
	@mkdir -p $(dir $@)
	$(ARCH)  $@ $?

$(BUILDDIR)/%.$(OBJEXT): $(SRCDIR)/%.$(SRCEXT)
	@mkdir -p $(dir $@) 
	$(CC) $(CFLAGS) $(MACROS) -c $< $(INCDEP) -o $@  

