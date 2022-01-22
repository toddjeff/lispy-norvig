# frozen_string_literal: true

module Lispy
  class Environment

    class << self
      extend T::Sig

      sig { returns(Env) }
      def standard
        ret = math_methods

        ret.update({
          "+" => proc { |x, y| x + y },
          "-" => proc { |x, y| x - y },
          "*" => proc { |x, y| x * y },
          "/" => proc { |x, y| x / y },
          "abs" => proc { |x| x.abs },
          "append" => proc { |x, y| x.append(y) }, # this is probably wrong
          "apply" => proc { |x, *y| x.call(*y) },
          "begin" => proc { |*x| x[-1] },
          "car" => proc { |x| x[0] },
          "cdr" => proc { |x| x[1..-1] },
          "cons" => proc { |x, y| x.append(y) },
          "eq?" => proc { |x, y| x.equal?(y) },
          "length" => proc { |x| x.length },
          "list" => proc { |*x| Array(*x) },
          "list?" => proc { |x| x.instance_of?(Array) },
          "map" => proc { |x| x.map }, # not right, need block
          "max" => proc { |x| x.max },
          "min" => proc { |x| x.min },
          "not" => proc { |x| not(x) },
          "null" => proc { |x| x.nil? },
          "number?" => proc { |x| x.instance_of?(Integer) || x.instance_of?(Float) },
          "print" => proc { |x| puts(x) },
          "procedure" => proc { |x| x.respond_to?(:call) },
          "round" => proc { |x| x.round },
          "symbol?" => proc { |x| x.class == Symbol },
        })
        ret
      end

      sig { returns(Env) }
      def math_methods
        keys = Math.methods - Object.methods
        ret = {}
        keys.each do |k|
          count = Math.method(k).parameters.count

          ret[k.to_s] = if count == 0
            proc { Math.method(k).call }
          elsif count == 1
            proc { |x| Math.method(k).call(x) }
          elsif count == 2
            proc { |x, y| Math.method(k).call(x, y) }
          else
            raise StandardError, "#{k} takes #{count} parameters"
          end
        end
        ret
      end
    end
  end
end
