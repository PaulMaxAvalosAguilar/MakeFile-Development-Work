#Library name
LIBNAME     := $(MODULEC)

#The Source directory
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
$(LIBDIR)/lib$(LIBNAME).$(DLEXT):  $(OBJECTS) 
	@mkdir -p $(dir $@)
	$(CC) -shared -o  $@ $?

$(BUILDDIR)/%.$(OBJEXT): $(SRCDIR)/%.$(SRCEXT)
	@mkdir -p $(dir $@) 
	$(CC) $(CFLAGS) $(MACROS) -fPIC -c $< $(INCDEP) -o $@  

