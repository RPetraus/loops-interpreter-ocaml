open Ast
open Eval

let rec get_lines ic acc =
  try
    let line = input_line ic in
    get_lines ic (line :: acc)
  with End_of_file -> List.rev acc

let parse (s : string) : prog =
  let lexbuf = Lexing.from_string s in
  let ast = Parser.prog Lexer.read lexbuf in
  ast

let () =
  let prog_string = 
    if Array.length Sys.argv > 1 then
      let fname = Sys.argv.(1) in
      let ic = open_in fname in
      let lines = get_lines ic [] in
      close_in ic;
      String.concat "" lines 
    else
      let () = print_endline "Enter a Loops expression:" in
      read_line ()
  in
  if prog_string <> "" then
    let prog = parse prog_string in
    let result = eval prog in 
    print_endline ("Evaluated expression: " ^ result)