# Define the name of the output binary
OUTPUT_BINARY = stack

# Define the name of your assembly source file
ASM_SOURCE = stack.s

# Define the assembler and linker options
ASM_OPTIONS = -f elf64 -g -F dwarf
LINKER_OPTIONS = -o $(OUTPUT_BINARY)

# Define the default target (the debug target)
.DEFAULT_GOAL := run

# Debug target - assemble and link with debugging information
compile: $(ASM_SOURCE)
	nasm $(ASM_OPTIONS) $(ASM_SOURCE) -o $(OUTPUT_BINARY).o
	ld $(LINKER_OPTIONS) $(OUTPUT_BINARY).o

# Run target - execute the program with gdb
run: compile
	./$(OUTPUT_BINARY)

debug: compile
	gdb ./$(OUTPUT_BINARY)

# Clean target - remove the output files
clean:
	rm -f $(OUTPUT_BINARY) $(OUTPUT_BINARY).o
