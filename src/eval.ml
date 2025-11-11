open Ast

(** Exception raised for evaluation errors *)
exception EvalError of string

(** Types of values resulting from evaluating an expression *)
type value =
  | VInt of int
  | VBool of bool

(** [env] represents string to value dictionaries *)
type env = (string * value) list

(** [find x e] finds the value bound to [x] in [e]; returns None if not found *)
let rec find (x : string) (e : env) : value option = 
  match e with
  | [] -> None
  | (s, v) :: t -> if s = x then Some v else find x t

(** [add x v e] adds a binding of [x] to [v] in [e] *)
let rec add (x : string) (v : value) (e : env) : env =
  match e with
  | [] -> [(x, v)]
  | (s, vl) :: t -> if s = x then (s, v) :: t else (s, vl) :: add x v t

(** [eval_expr env e] evaluates [e] to a value using [env] *)
let rec eval_expr (env : env) (e : expr) : value = 
  match e with
  | Int i -> VInt i
  | Bool b -> VBool b
  | Var x -> eval_var env x
  | Unop (uop, e) -> eval_uop env uop e
  | Binop (bop, e1, e2) -> eval_bop env bop e1 e2

and eval_var (env : env) (x : string) : value =
  match find x env with
  | Some v -> v
  | None -> raise (EvalError "Unbound variable")

(** [eval_uop env u e] evaluates [u] applied to [e] using [env] *)
and eval_uop (env : env) (u : uop) (e : expr) : value =
  match (u, eval_expr env e) with
  | Neg, VInt i -> VInt (-i)
  | Not, VBool b -> VBool (not b)
  | _ -> raise (EvalError "Operator and operand type mismatch")

(** [eval_bop env b e1 e2] evaluates [b] applied to [e1] and [e2] using [env] *)
and eval_bop (env : env) (b : bop) (e1: expr) (e2 : expr) : value =
  match (b, eval_expr env e1, eval_expr env e2) with
  | And, VBool b1, VBool b2 -> VBool (b1 && b2)
  | Eq, VInt i1, VInt i2 -> VBool (i1 = i2)
  | Leq, VInt i1, VInt i2 -> VBool (i1 <= i2)
  | Add, VInt i1, VInt i2 -> VInt (i1 + i2)
  | Sub, VInt i1, VInt i2 -> VInt (i1 - i2)
  | Mult, VInt i1, VInt i2 -> VInt (i1 * i2)
  | _ -> raise (EvalError "Operator and operand type mismatch")

(** [eval_blk env ss] evaluates [ss] in an isolated [env] *)
and eval_blk (env : env) (ss : stmt list) : env * value option =
  let rec aux (lcl_env : env) (ss : stmt list) : env * value option =
    match ss with
    | [] -> (env, None)
    | s :: t -> let env', res = eval_stmt lcl_env s in
                match res with
                | Some v -> (env', Some v)
                | None -> aux env' t
  in aux env ss

(** [eval_stmt env s] evaluates [s] in [env] *)
and eval_stmt (env : env) (s : stmt) : env * value option =
  match s with
  | Return e -> let v = eval_expr env e in 
                (env, Some v)
  | Assign (x, e) -> let v = eval_expr env e in
                      (add x v env, None)
  | Blk ss -> eval_blk env ss
  | Prt e -> let v = eval_expr env e in
              print_value v;
              (env, None)
  | Prt_el e -> let v = eval_expr env e in
                print_value v; print_newline ();
                (env, None)
  | Prt_sp e -> let v = eval_expr env e in
                print_value v; print_string " ";
                (env, None)

(** [print_value v] prints [v] onto the screen *)
and print_value (v : value) =
  match v with
  | VInt i -> print_int i
  | VBool b -> print_string (string_of_bool b)

(** [eval_prog env p] evaluates [p] to a value using [env] *)
and eval_prog (env : env) (p : prog) : value =
  match p with
  | [] -> raise (EvalError "Program is empty")
  | s :: t -> 
      let env', res = eval_stmt env s in
      match res with
      | Some v -> v
      | None -> eval_prog env' t

(** [eval p] evaluates [p] into a string result *)
let eval (p : prog) : string =
  match eval_prog [] p with
  | VInt i -> string_of_int i
  | VBool b -> string_of_bool b
