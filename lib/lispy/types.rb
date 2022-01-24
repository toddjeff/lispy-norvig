# frozen_string_literal: true

module Lispy
  # Symbol  = T.type_alias { String }
  class Symbol < String; end

  # Number  = T.type_alias { T.any(Integer, Float) }
  class Number
    extend T::Sig

    attr_reader :value

    def initialize(value)
      @value = value
    end

    sig { params(other: Number).returns(T::Boolean) }
    def ==(other)
      value == other.value
    end
  end

  Atom    = T.type_alias { T.any(Symbol, Number) }
  List    = T.type_alias { Array }
  Exp     = T.type_alias { T.any(Atom, List) }

  class Env < Hash
    attr_reader :outer

    def initialize(outer: nil)
      super
      @outer = outer
    end
  end
end
