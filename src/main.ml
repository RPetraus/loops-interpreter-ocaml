let parse (s : string) : Ast.prog =
  let lexbuf = Lexing.from_string s in
  Parser.prog Lexer.read lexbuf

let () =
  let input =
    if Array.length Sys.argv > 1 then
      let fname = Sys.argv.(1) in
      In_channel.with_open_text fname In_channel.input_all 
    else let () = print_endline "Enter a Loops expression:" in
      read_line ()
  in
  let prog = parse input in
  let result = Eval.eval prog in
  print_endline ("Evaluated expression: " ^ result)
