module Impl.Hello

open FStar.HyperStack.ST
open LowStar.BufferOps

let main (): St Int32.t =
  push_frame ();
  LowStar.Printf.(printf "Hello, World!" done);
  pop_frame ();
  0l
