# frozen_string_literal: true

require "test_helper"

module Lispy
  class TypesTest < Lispy::Test
    def setup
      @tokenizer = Lispy::Tokenizer.new
    end

    def test_symbol
      x = Symbol.new("hey")

      assert x.instance_of?(Symbol)
    end

    def test_number
      x = Number.new(10)
      y = Number.new(10)

      assert_equal x, y
    end

    def test_env_outer
      env = Env.new(outer: StandardEnvironment.global)
      assert StandardEnvironment.global.equal?(env.outer)
    end

    def test_find_in_global
      env = Env.new(outer: StandardEnvironment.global)
      assert_equal StandardEnvironment.global, env.find("atan2")
    end

    def test_find_in_local
      env = Env.new(outer: StandardEnvironment.global)
      env["a"] = 10
      assert_equal env, env.find("a")
    end

    def test_env_with_params
      e = Env.new(params: ["a", "b"], args: [1, 2])
      assert_equal 1, e["a"]
    end

    def test_procedure
      params = ["a", "b"]
      body = @tokenizer.parse("(+ a b)")
      pr = Procedure.new(params, body, StandardEnvironment.global)
      assert_equal 21, pr.call(10, 11)
    end
  end
end
