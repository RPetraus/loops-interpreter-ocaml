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
  | Unop of uop * expr
  | Binop of bop * expr * expr

(** Statement for Part 1 *)
type stmt =
  | Return of expr

(** Program for Part 1 *)
type prog = stmt list