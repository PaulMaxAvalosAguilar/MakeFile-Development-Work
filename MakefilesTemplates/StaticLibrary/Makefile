#---------------------------------------------------------------------------------
#DO NOT EDIT BELOW THIS LINE
#---------------------------------------------------------------------------------
LIBDIR	    := ../../$(LIBDIRECTORY)/$(VERSION)
BUILDDIR    := ../../$(BUILDDIRECTORY)/$(VERSION)

SOURCES     := $(shell find $(SRCDIR) -type f -name *.$(SRCEXT))
OBJECTS     := $(patsubst $(SRCDIR)/%,$(BUILDDIR)/%,$(SOURCES:.$(SRCEXT)=.$(OBJEXT))) 
#---------------------------------------------------------------------------------

include Makefile.config

#COMPILE PART
$(PACKAGINGNAME):  $(OBJECTS) 
	@mkdir -p $(dir $@)
	$(PACKAGINGINSTRUCTIONS)  $@ $?

$(BUILDDIR)/%.$(OBJEXT): $(SRCDIR)/%.$(SRCEXT)
	@mkdir -p $(dir $@) 
	$(COMPILATIONINSTURCTIONS) $< -o $@  

