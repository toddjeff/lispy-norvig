# frozen_string_literal: true

module Lispy
  class Eval
    class << self
      extend T::Sig

      sig { params(x: Exp, env: Env).returns(T.untyped) }
      def call(x, env = StandardEnvironment.global)
        if x.instance_of?(Symbol)
          env[x]
        elsif x.instance_of?(Number)
          x.value
        elsif x[0] == "if"
          _, test, conseq, alt = x
          exp = Eval.call(test, env) ? conseq : alt
          Eval.call(exp, env)
        elsif x[0] == "define"
          _, symbol, exp = x
          env[symbol] = Eval.call(exp, env)
        else
          proc = Eval.call(x[0], env)
          args = x[1..-1].map { |arg| Eval.call(arg, env) }
          proc.call(*args)
        end
      end
    end
  end
end
