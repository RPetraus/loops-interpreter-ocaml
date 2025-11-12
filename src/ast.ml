(** Unary operators *)
type uop =
  | Neg
  | Not

(** Binary operators *)
type bop =
  | Add
  | Sub
  | Mult
  | Eq
  | Leq
  | And

(** Expressions *)
type expr =
  | Int of int
  | Bool of bool
  | Var of string
  | Unop of uop * expr
  | Binop of bop * expr * expr

(** Statements *)
type stmt =
  | Return of expr
  | Assign of string * expr
  | Blk of stmt list
  | Prt of expr
  | Prt_el of expr
  | Prt_sp of expr
  | Ite of expr * stmt * stmt
  | While of expr * stmt

(** Program *)
type prog = stmt list