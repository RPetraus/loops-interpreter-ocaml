open Ast

(** Exception raised for evaluation errors *)
exception EvalError of string

(** Types of values resulting from evaluating an expression *)
type value =
  | VInt of int
  | VBool of bool

(** [eval_expr e] evaluates [e] to a value *)
let rec eval_expr (e : expr) : value = 
  match e with
  | Int i -> VInt i
  | Bool b -> VBool b
  | Unop (uop, e) -> eval_uop uop e
  | Binop (bop, e1, e2) -> eval_bop bop e1 e2

(** [eval_uop u e] evaluates [e] with [u] *)
and eval_uop (u : uop) (e : expr) : value =
  match (u, eval_expr e) with
  | Neg, VInt i -> VInt (-i)
  | Not, VBool b -> VBool (not b)
  | _ -> raise (EvalError "Operator and operand type mismatch")

(** [eval_bop b e1 e2] evaluates [e1] and [e2] with [b] *)
and eval_bop (b : bop) (e1: expr) (e2 : expr) : value =
  match (b, eval_expr e1, eval_expr e2) with
  | And, VBool b1, VBool b2 -> VBool (b1 && b2)
  | Eq, VInt i1, VInt i2 -> VBool (i1 = i2)
  | Leq, VInt i1, VInt i2 -> VBool (i1 <= i2)
  | Add, VInt i1, VInt i2 -> VInt (i1 + i2)
  | Sub, VInt i1, VInt i2 -> VInt (i1 - i2)
  | Mult, VInt i1, VInt i2 -> VInt (i1 * i2)
  | _ -> raise (EvalError "Operator and operand type mismatch")

(** [eval_prog p] evaluates [p] to a value *)
and eval_prog (p : prog) : value =
  match p with
  | (Return e) :: _ -> eval_expr e
  | [] -> raise (EvalError "Program is empty")

(** [eval p] evaluates [p] to a string *)
let eval (p : prog) : string =
  match eval_prog p with
  | VInt i -> string_of_int i
  | VBool b -> string_of_bool b
