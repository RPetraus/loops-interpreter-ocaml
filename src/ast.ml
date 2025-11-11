(** Unary operators for Part 1 *)
type uop =
  | Neg
  | Not

(** Binary operators for Part 1 *)
type bop =
  | Add
  | Sub
  | Mult
  | Eq
  | Leq
  | And

(** Expressions for Part 1 *)
type expr =
  | Int of int
  | Bool of bool
  | Var of string
  | Unop of uop * expr
  | Binop of bop * expr * expr

(** Statement for Part 1 *)
type stmt =
  | Return of expr
  | Assign of string * expr
  | Block of stmt list

(** Program for Part 1 *)
type prog = stmt list