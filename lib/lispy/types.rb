# frozen_string_literal: true

module Lispy
  Symbol = T.type_alias { String }
  Number  = T.type_alias { T.any(Integer, Float) }
  Atom    = T.type_alias { T.any(Symbol, Number) }
  List    = T.type_alias { Array }
  Exp     = T.type_alias { T.any(Atom, List) }
  Env     = T.type_alias { Hash }
end
