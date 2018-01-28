
#The Directories, Source, Includes, Objects, Binary and Resources
SRCDIR      := src
BUILDDIR    := ../../Objects
TARGETDIR   := ../../Release
SRCEXT      := c
OBJEXT      := o


#write -l library
LIB         := 
#write -I $(INCDIR)
INCDEP      := -I src/Fold\
	-I src/Functions
	
#---------------------------------------------------------------------------------
#DO NOT EDIT BELOW THIS LINE
#---------------------------------------------------------------------------------
SOURCES     := $(shell find $(SRCDIR) -type f -name *.$(SRCEXT))
OBJECTS     := $(patsubst $(SRCDIR)/%,$(BUILDDIR)/$(VERSION)/%,$(SOURCES:.$(SRCEXT)=.$(OBJEXT))) 

#---------------------------------------------------------------------------------
#DEFAULT PART
all: directories $(TARGET)

#DIRECTORIES PART
directories:
	@mkdir -p $(TARGETDIR)/$(VERSION)
	@mkdir -p $(BUILDDIR)/$(VERSION)
	

#COMPILE & RUN PART
$(TARGET):  $(OBJECTS) 
	$(CC) -o $(TARGETDIR)/$(VERSION)/$(TARGET) $? $(LIB)

$(BUILDDIR)/$(VERSION)/%.$(OBJEXT): $(SRCDIR)/%.$(SRCEXT)
	@mkdir -p $(dir $@) #this works for whenever we have a folder it creates it
	$(CC) $(CFLAGS) $(MACROS) -c $< $(INCDEP) -o $@  


#Clean PART
clean:
	@$(RM) -rf $(BUILDDIR)

cleaner: clean
	@$(RM) -rf $(TARGETDIR)

.PHONY: all directores clean cleaner

