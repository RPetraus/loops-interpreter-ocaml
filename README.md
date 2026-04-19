# Loops Interpreter in OCaml

An interpreter for a small imperative programming language implemented in OCaml. The project includes lexical analysis, parsing, abstract syntax tree construction, and runtime evaluation, with support for mutable state, scoped blocks, branching, iteration, comments, and formatted output.

## Features

- Integer and boolean expressions
- Variable assignment and lookup
- Lexically scoped block statements
- Single-line comments
- `print`, `print_space`, and `print_endline`
- `if ... then ... else` conditionals
- `while` loops
- `return` statements
- Runtime error reporting through `EvalError`

## Language Overview

The Loops language supports the following statement forms:

- Assignment
- Conditional branching
- While loops
- Scoped block statements
- Print operations
- Return statements

It also supports the following expression forms:

- Integer constants
- Boolean constants
- Variable references
- Unary negation
- Arithmetic operations
- Equality and comparison
- Boolean logic
- Parenthesized expressions

## Project Structure

### Root directory
- `_build/` — generated build artifacts from Dune
- `src/` — source code
- `test/` — test programs
- `.gitignore` — ignores generated build files
- `DevDocs.md` — developer documentation
- `dune-project` — Dune project configuration
- `README.md` — project overview and usage

### Source files
- `src/ast.ml` — abstract syntax tree definitions for Loops programs
- `src/dune` — build configuration for the source directory
- `src/eval.ml` — evaluation logic for executing Loops programs
- `src/lexer.mll` — lexer for tokenizing source code
- `src/main.ml` — entry point for reading, parsing, and evaluating programs
- `src/parser.mly` — grammar, precedence, and associativity rules for parsing

## Build and Run

This project uses Dune.

Build the project with:

```bash
dune build