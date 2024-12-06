module Impl.Hello

open FStar.HyperStack.ST
open LowStar.Buffer
open LowStar.BufferOps

module ST = FStar.HyperStack.ST
module HS = FStar.HyperStack
module UInt32 = FStar.UInt32

let print_hello_n_times n =
  let body (i: UInt32.t{ UInt32.v i < UInt32.v n }): ST.Stack unit
    (requires (fun _ -> True))
    (ensures (fun _ _ _ -> True))
  =
    push_frame();
    LowStar.Printf.(printf "Hello, world!\n" done);
    pop_frame()
  in
  C.Loops.for 0ul n (fun _ _ -> True) body

noextract
let rec fib (n:nat) : nat =
  if n <= 1 then 1
  else fib (n - 1) + fib (n - 2)

open FStar.UInt
open FStar.UInt32
let rec fibonacci (num: UInt32.t { size (fib (v num)) 32 })
: Tot (res:UInt32.t { v res == fib (v num) })
      (decreases v num)
= if num <=^ 1ul then
    1ul
  else
    fibonacci (num -^ 1ul) +^ fibonacci (num -^ 2ul)

let main (): St Int32.t =
  push_frame ();
  LowStar.Printf.(printf "Hello, world!" done);
  pop_frame ();
  print_hello_n_times 5ul;
  0l
