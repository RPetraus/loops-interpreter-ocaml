/* A header is an optional segment of OCaml code*/
%{
    open Ast
%}

/* Declarations */
%token<string> ID
%token<int> INT
%token TRUE
%token FALSE
%token NOT
%token AND
%token ASSIGN
%token EQ
%token LEQ
%token PLUS MINUS TIMES
%token LPAREN RPAREN
%token LBRACKET RBRACKET
%token RETURN
%token SEMI
%token EOF

/* Precedence and associativity */
%left AND
%nonassoc EQ LEQ
%left PLUS MINUS
%left TIMES
%right NOT UMINUS

%start <Ast.prog> prog

/* End the declaration section*/
%%

/* Parsing/grammar rules */
prog:
    | s = stmts; EOF { s }
    ;
stmts:
    | s = stmt { [s] }
    | s = stmt; t = stmts { s :: t }
    ;
stmt:
    | RETURN; e = expr; SEMI { Return e}
    | x = ID; ASSIGN; e = expr; SEMI { Assign (x, e) }
    | LBRACKET; ss = stmts; RBRACKET { Block ss }
    ;
expr:
    | i = INT { Int i }
    | TRUE { Bool true }
    | FALSE { Bool false }
    | x = ID { Var x }
    | NOT; e = expr { Unop (Not, e) }
    | MINUS; e = expr %prec UMINUS { Unop (Neg, e) }
    | e1 = expr; AND; e2 = expr { Binop (And, e1, e2) }
    | e1 = expr; EQ; e2 = expr { Binop (Eq, e1, e2) }
    | e1 = expr; LEQ; e2 = expr { Binop (Leq, e1, e2) }
    | e1 = expr; PLUS; e2 = expr { Binop (Add, e1, e2) }
    | e1 = expr; MINUS; e2 = expr { Binop (Sub, e1, e2) }
    | e1 = expr; TIMES; e2 = expr { Binop (Mult, e1, e2)}
    | LPAREN; e = expr; RPAREN { e }
    ;