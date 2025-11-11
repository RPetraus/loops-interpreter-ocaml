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
  | Blk of stmt list
  | Prt of expr
  | Prt_el of expr
  | Prt_sp of expr

(** Program for Part 1 *)
type prog = stmt list