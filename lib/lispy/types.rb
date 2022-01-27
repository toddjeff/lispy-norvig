# frozen_string_literal: true
require 'pry-byebug'

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

    def initialize(params: [], args: [], outer: nil)
      super()
      merge!(**params.zip(args).to_h)
      @outer = outer
    end

    def find(var)
      if key?(var)
        self
      elsif outer
        outer.find(var)
      else
        binding.pry
        raise StandardError, "#{var} is not defined"
      end
    end
  end

  class Procedure
    def initialize(params, body, env)
      @params = params
      @body = body
      @env = env
    end

    def call(*args)
      Eval.call(@body, Env.new(params: @params, args: args, outer: @env))
    end
  end
end
