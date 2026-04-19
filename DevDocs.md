# Developer Documentation

## Implementation Status

The implementation is complete, and all features of the Loops language are supported soundly. The interpreter uses an `EvalError` exception with descriptive messages to report runtime issues in Loops programs. It also supports comments, all required statements and expressions, and the scoping behavior of blocks under different execution contexts.

## Project Structure

### Root directory

- `_build/` — generated build artifacts produced by Dune during compilation
- `src/` — source code for the interpreter
- `test/` — test programs used to validate language behavior
- `.gitignore` — configured to ignore generated build artifacts
- `DevDocs.md` — developer documentation for the project
- `dune-project` — project-level Dune configuration
- `README.md` — public project overview and usage documentation

### Source directory

- `ast.ml` — defines the types used for the abstract syntax tree representing Loops programs
- `dune` — configures how Dune builds the source files
- `eval.ml` — evaluates parsed Loops programs and implements runtime semantics
- `lexer.mll` — defines the lexical rules used to tokenize input source code
- `main.ml` — reads Loops programs from files, parses and evaluates them, and prints output
- `parser.mly` — defines the grammar, precedence, and associativity rules for the Loops language

## High-Level Design

The interpreter is organized as a standard language-processing pipeline:

1. The lexer tokenizes the input source code.
2. The parser consumes those tokens and constructs an abstract syntax tree.
3. The evaluator executes the resulting syntax tree according to the semantics of the Loops language.
4. The main module handles file input, connects parsing and evaluation, and displays output.

This separation keeps the implementation modular and makes the code easier to understand, debug, and extend.

## Semantics and Behavior

The interpreter supports:

- Integer and boolean expressions
- Variable assignment and lookup
- Lexically scoped block statements
- Conditional execution with `if ... then ... else`
- Iteration with `while`
- Formatted output with `print`, `print_space`, and `print_endline`
- Early termination through `return`
- Single-line comments beginning with `//`

Special attention was given to block scoping behavior under different execution contexts so that state is handled correctly in ordinary blocks, conditional branches, and loop bodies.

## Error Handling

Runtime errors are reported using the `EvalError` exception with descriptive messages. This is used to notify the user of invalid behavior in a Loops program, such as evaluation-time issues involving program state or expression handling.

Syntax-related issues are left to the lexer and parser infrastructure.

## Testing

The `test/` directory contains programs used to validate the behavior of the interpreter across multiple language features, including arithmetic, branching, loops, printing, comments, and scope-related behavior.

## Notes

One of the most interesting parts of this project was using an existing programming language to implement a new one. It raises interesting questions about how earlier languages were developed and how similar bootstrapping ideas apply across different programming paradigms, including functional languages.
