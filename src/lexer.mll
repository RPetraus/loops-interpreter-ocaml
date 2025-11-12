{
    open Parser
}

let white = [' ' '\t' '\n' '\r']+
let digit = ['0'-'9']
let int = digit+
let letter = ['a'-'z' 'A'-'Z']
let id = letter+

rule read =
    parse
    | "//" [^ '\n']* { read lexbuf }
    | white { read lexbuf }
    | "not" { NOT }
    | "+" { PLUS }
    | "-" { MINUS }
    | "*" { TIMES }
    | "=" { ASSIGN }
    | "==" { EQ }
    | "<=" { LEQ }
    | "and" { AND }
    | "true" { TRUE }
    | "false" { FALSE }
    | "if" { IF }
    | "then" { THEN }
    | "else" { ELSE }
    | "while" { WHILE }
    | "do" { DO }
    | "(" { LPAREN }
    | ")" { RPAREN }
    | "{" { LBRACKET }
    | "}" { RBRACKET }
    | "return" { RETURN }
    | "print_endline" { PRT_EL }
    | "print_space" { PRT_SP }
    | "print" { PRT }
    | ";" { SEMI }
    | id { ID (Lexing.lexeme lexbuf) }
    | int { INT (int_of_string (Lexing.lexeme lexbuf)) }
    | eof { EOF }