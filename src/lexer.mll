{
    open Parser
}

let white = [' ' '\t' '\n' '\r']+
let digit = ['0'-'9']
let int = digit+
let letter = ['a'-'z' 'A' - 'Z']

rule read =
    parse
    | white { read lexbuf }
    | int { INT (int_of_string (Lexing.lexeme lexbuf)) }
    | "not" { NOT }
    | "+" { PLUS }
    | "-" { MINUS }
    | "*" { TIMES }
    | "==" { EQ }
    | "<=" { LEQ }
    | "and" { AND }
    | "true" { TRUE }
    | "false" { FALSE }
    | "(" { LPAREN }
    | ")" { RPAREN }
    | "return" { RETURN }
    | ";" { SEMI }
    | eof { EOF }