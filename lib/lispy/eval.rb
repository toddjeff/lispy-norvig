# frozen_string_literal: true

module Lispy
  class Eval
    class << self
      extend T::Sig

      sig { params(x: Exp, env: Env).returns(T.untyped) }
      def call(x, env = StandardEnvironment.global)
        if x.instance_of?(Symbol)
          return env.find(x)[x]
        elsif !x.instance_of?(Array)
          return x.value if x.respond_to?(:value)
          return x
        end

        op, *args = x
        if op == "quote"
          args[0]
        elsif op == "if"
          test, conseq, alt = args
          exp = Eval.call(test, env) ? conseq : alt
          Eval.call(exp, env)
        elsif op == "define"
          symbol, exp = args
          env[symbol] = Eval.call(exp, env)
        elsif op == "set!"
          symbol, exp = args
          env.find(symbol)[symbol] = Eval.call(exp, env)
        elsif op == "lambda"
          params, body = args
          Procedure.new(params, body, env)
        else
          proc_ = Eval.call(op, env)
          vals = args.map { |arg| Eval.call(arg, env) }
          proc_.call(*vals)
        end
      end
    end
  end
end
