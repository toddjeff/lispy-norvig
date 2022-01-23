# frozen_string_literal: true

module Lispy
  class Environment
    class << self
      extend T::Sig

      sig { returns(Env) }
      def global
        @global ||= standard
      end

      sig { params(input: StringIO, output: StringIO).returns(Env) }
      def standard(input: $stdin, output: $stdout)
        ret = math_methods

        ret.update({
          "+" => proc { |x, y| x + y },
          "-" => proc { |x, y| x - y },
          "*" => proc { |x, y| x * y },
          "/" => proc { |x, y| x / y },
          "abs" => proc { |x| x.abs },
          "append" => proc { |x, *y| x.append(*y) },
          "apply" => proc { |x, *y| x.call(*y) },
          "begin" => proc { |*x| x[-1] },
          "car" => proc { |x| x[0] },
          "cdr" => proc { |x| x[1..-1] },
          "cons" => proc { |x, y| [x].append(y) },
          "eq?" => proc { |x, y| x.equal?(y) },
          "length" => proc { |x| x.length },
          "list" => proc { |*x| Array(x) },
          "list?" => proc { |x| x.instance_of?(Array) },
          "map" => proc { |fn, x| x.map { |item| fn.call(item) } },
          "max" => proc { |x| x.max },
          "min" => proc { |x| x.min },
          "not" => proc { |x| !x },
          "null?" => proc { |x| x == [] },
          "number?" => proc { |x| x.instance_of?(Number) },
          "pi" => Math::PI,
          "print" => proc { |x| output.print(x) },
          "procedure?" => proc { |x| x.respond_to?(:call) },
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
