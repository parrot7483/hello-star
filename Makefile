# Directories
OBJ_DIR = obj
BUILD_DIR = build

# Name
NAME = hello

# Files
FST_FILE = code/Impl.Hello.fst
KRML_OUTPUT = $(OBJ_DIR)/$(NAME).krml
C_OUTPUT = $(BUILD_DIR)/$(NAME).c
H_OUTPUT = $(BUILD_DIR)/$(NAME).h
EXE_OUTPUT = $(BUILD_DIR)/$(NAME)

# Default target
all: $(C_OUTPUT) $(H_OUTPUT)

# Generate the .krml file from F* code
$(KRML_OUTPUT): $(FST_FILE)
	mkdir --parent $(OBJ_DIR)
	install -m 664 $(KRML_HOME)/krmllib/obj/* $(OBJ_DIR)
	fstar.exe \
	--cache_dir $(OBJ_DIR) \
	--codegen krml \
	--include $(KRML_HOME)/krmllib \
	--cache_checked_modules \
	--already_cached 'Prims FStar LowStar C TestLib' \
	--warn_error '+241@247+285' \
	--krmloutput $(KRML_OUTPUT) \
	$(FST_FILE)

# Generate C and H files from .krml
$(C_OUTPUT) $(H_OUTPUT): $(KRML_OUTPUT)
	krml -tmpdir $(BUILD_DIR) -no-prefix $(basename $(notdir $(FST_FILE))) $(KRML_OUTPUT) -o $(EXE_OUTPUT)

# Clean up generated files
clean:
	rm -rf $(OBJ_DIR) $(BUILD_DIR)

run:
	@$(EXE_OUTPUT)	

# Phony targets
.PHONY: all clean
