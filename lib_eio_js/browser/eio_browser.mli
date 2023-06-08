module Timeout : sig
  val sleep : ms:int -> unit
  (** Non-blocking timeout that waits for [ms] millseconds. *)
end

val await : 'a Fut.t -> 'a
(** [await fut] blocks on the promise [fut] and allows other fibers to do work. *)

val next_event : 'a Brr.Ev.type' -> Brr.Ev.target -> 'a Brr.Ev.t
(** [next_event typ target] blocks until an event of type [typ] arrives
    on the [target]. *)

(** {1 Callbacks} *)

val listen :
    ?opts:Brr.Ev.listen_opts ->
    'a Brr.Ev.type' -> ('a Brr.Ev.t -> unit) -> Brr.Ev.target -> Brr.Ev.listener
(** Identical to {! Brr.Ev.listen} except the callback for the event listener
    can perform asynchronous actions (i.e. perform effects) and they will be
    handled properly. *)

val async : (unit -> unit) -> unit
(** [async f] runs [f ()] asynchronously using Eio.
    All functions using Eio must be wraped with [async].
*)
