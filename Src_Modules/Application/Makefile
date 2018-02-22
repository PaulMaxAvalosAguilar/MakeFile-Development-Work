#The Directories, Source, Includes, Objects, Binary and Resources
SRCDIR      := src
SRCEXT      := c
OBJEXT      := o

#write -l library
LIB         :=  -l$(MODULEB)\
	-l$(MODULEC)
#write -I $(INCDIR)
INCDEP      := -I src/Fold\
	-I src/Functions\
	-I ../StaticLibTest/src/\
	-I ../SharedLibTest/src/

#---------------------------------------------------------------------------------
#DO NOT EDIT BELOW THIS LINE
#---------------------------------------------------------------------------------
BUILDDIR    := ../../$(BUILDDIRECTORY)/$(VERSION)
TARGETDIR   := ../../$(TARGETDIRECTORY)/$(VERSION)
LIBRARYPATH := -L ../../$(LIBDIRECTORY)/$(VERSION)

SOURCES     := $(shell find $(SRCDIR) -type f -name *.$(SRCEXT))
OBJECTS     := $(patsubst $(SRCDIR)/%,$(BUILDDIR)/%,$(SOURCES:.$(SRCEXT)=.$(OBJEXT))) 

#---------------------------------------------------------------------------------

#COMPILE PART
$(TARGETDIR)/$(TARGET):  $(OBJECTS)
	@mkdir -p $(dir $@)
	$(CC) -o $@ $? $(LIBRARYPATH) $(LIB)

$(BUILDDIR)/%.$(OBJEXT): $(SRCDIR)/%.$(SRCEXT)
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) $(MACROS) -c $< $(INCDEP) -o $@  

