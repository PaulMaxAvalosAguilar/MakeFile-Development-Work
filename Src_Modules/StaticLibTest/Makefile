#---------------------------------------------------------------------------------
#DO NOT EDIT BELOW THIS LINE
#---------------------------------------------------------------------------------
LIBDIR	    := ../../$(LIBDIRECTORY)/$(VERSION)
BUILDDIR    := ../../$(BUILDDIRECTORY)/$(VERSION)
HEADDIR	    := ../../$(HEADERSDIRECTORY)/$(VERSION)

SOURCES     := $(shell find $(SRCDIR) -type f -name *.$(SRCEXT))
OBJECTS     := $(patsubst $(SRCDIR)/%,$(BUILDDIR)/%,$(SOURCES:.$(SRCEXT)=.$(OBJEXT)))
HEADERS	    := $(shell find $(SRCDIR) -type f -name *.$(HEADEXT))

#---------------------------------------------------------------------------------

include Makefile.config

all: $(HEADDIR) $(PACKAGINGNAME)

$(HEADDIR):
	@mkdir -p $(dir $@/$(LIBNAME))
	rsync -r --delete $(HEADERS) $(HEADDIR)/$(LIBNAME)/

#COMPILE PART
$(PACKAGINGNAME):  $(OBJECTS) 
	@mkdir -p $(dir $@)
	$(PACKAGINGINSTRUCTIONS)  $@ $?

$(BUILDDIR)/%.$(OBJEXT): $(SRCDIR)/%.$(SRCEXT)
	@mkdir -p $(dir $@) 
	$(COMPILATIONINSTURCTIONS) $< -o $@  

