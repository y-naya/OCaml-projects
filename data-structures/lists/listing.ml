let from0to n = List.init (n + 1) (fun x -> x);;

let to0from n = List.init (n + 1) (fun x -> n - x);;

let pair obj list = List.map (fun x -> obj, x) list;;

let remove_first obj list = 
  let rec aux checked = function
    [] -> List.rev checked
  | h::t -> if h = obj
      then List.rev_append checked t
      else aux (h::checked) t
  in aux [] list;;

let remove_all obj list = 
  let _, res = List.partition (fun x -> obj = x) list
  in res;;

let rec ldif l1 = function
    [] -> l1
  | h::t -> ldif (remove_all h l1) t;;
  
