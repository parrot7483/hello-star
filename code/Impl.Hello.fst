module Impl.Hello

open FStar.HyperStack.ST

module U32 = FStar.UInt32

let print_hello_n_times n =
  let body (i: U32.t{ U32.v i < U32.v n }): Stack unit
    (requires (fun _ -> True))
    (ensures (fun _ _ _ -> True))
  =
    push_frame();
    LowStar.Printf.(printf "Hello, world!\n" done);
    pop_frame()
  in
  C.Loops.for 0ul n (fun _ _ -> True) body

noextract
let rec fib (n: nat) : nat =
  if n <= 1 then n
  else fib (n - 1) + fib (n - 2)

let rec fibonacci (num: U32.t { FStar.UInt.size (fib (U32.v num)) 32 })
: Tot (res: U32.t { U32.v res == fib (U32.v num) })
      (decreases U32.v num)
= let open U32 in 
  if num <=^ 1ul then
    num
  else
    fibonacci (num -^ 1ul) +^ fibonacci (num -^ 2ul)

let main (): St Int32.t =
  push_frame ();
  LowStar.Printf.(printf "Hello, world!" done);
  pop_frame ();
  print_hello_n_times 5ul;
  0l
