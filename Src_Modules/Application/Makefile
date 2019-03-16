include Makefile.config

#---------------------------------------------------------------------------------
#DO NOT EDIT BELOW THIS LINE
#---------------------------------------------------------------------------------
BUILDDIR    := ../../$(BUILDDIRECTORY)/$(VERSION)
TARGETDIR   := ../../$(TARGETDIRECTORY)/$(VERSION)

SOURCES     := $(shell find $(SRCDIR) -type f -name *.$(SRCEXT))
OBJECTS     := $(patsubst $(SRCDIR)/%,$(BUILDDIR)/%,$(SOURCES:.$(SRCEXT)=.$(OBJEXT)))
DEPENDS     := $(patsubst $(SRCDIR)/%,$(BUILDDIR)/%,$(SOURCES:.$(SRCEXT)=.d))

#---------------------------------------------------------------------------------

#COMPILE PART
$(TARGETDIR)/$(TARGET):  $(OBJECTS)
	@mkdir -p $(dir $@)
	$(CC) -o $@ $(OBJECTS)  $(LDFLAGS)

-include $(DEPENDS)

$(BUILDDIR)/%.$(OBJEXT): $(SRCDIR)/%.$(SRCEXT)
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS)  $(MACROS) -MMD -MP -c $< $(INCDEP) -o $@  

