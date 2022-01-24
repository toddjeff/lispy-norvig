# frozen_string_literal: true

require "test_helper"
require 'stringio'

module Lispy
  class StandardEnvironmentTest < Lispy::Test
    def setup
      @standard_env = StandardEnvironment.create
    end

    def test_atan2
      expected = -3.141592653589793
      assert_equal expected, fn("atan2").call(-0.0, -1.0)
    end

    def test_plus
      assert_equal 3, fn("+").call(1, 2)
    end

    def test_minus
      assert_equal 3, fn("-").call(5, 2)
    end

    def test_divide
      assert_equal 2, fn("/").call(4, 2)
    end

    def test_multiply
      assert_equal 6, fn("*").call(3, 2)
    end

    def test_abs
      assert_equal 10, fn("abs").call(-10)
    end

    def test_append
      assert_equal [1, 2], fn("append").call([1], 2)
      assert_equal [1, 2, 3], fn("append").call([1], 2, 3)
    end

    def test_apply
      a = proc{ |x, y| x + y }
      assert_equal 5, fn("apply").call(a, 2, 3)
    end

    def test_begin
      assert_equal 3, fn("begin").call(1, 2, 3)
    end

    def test_car
      assert_equal 1, fn("car").call([1, 2, 3])
    end

    def test_cdr
      assert_equal [2, 3], fn("cdr").call([1, 2, 3])
    end

    def test_cons
      assert_equal [2, 3], fn("cons").call(2, 3)
    end

    def test_eq?
      x = {}
      y = {}
      assert_equal true, fn("eq?").call(x, x)
      assert_equal false, fn("eq?").call(x, y)
    end

    def test_length
      assert_equal 2, fn("length").call([2, 3])
    end

    def test_list
      assert_equal [1, 2, 3], fn("list").call(1, 2, 3)
    end

    def test_list?
      assert_equal true, fn("list?").call([1, 2, 3])
      assert_equal false, fn("list?").call({})
    end

    def test_map
      fn = proc { |x| x * 2 }
      assert_equal [2, 4], fn("map").call(fn, [1, 2])
    end

    def test_max
      assert_equal 10, fn("max").call([4, 6, 8, 10])
    end

    def test_min
      assert_equal 4, fn("min").call([4, 6, 8, 10])
    end

    def test_not
      assert_equal false, fn("not").call(true)
    end

    def test_null
      assert_equal true, fn("null?").call([])
    end

    def test_number?
      assert_equal true, fn("number?").call(Number.new(1))
      assert_equal true, fn("number?").call(Number.new(1.0))
      assert_equal false, fn("number?").call("ab")
      assert_equal false, fn("number?").call([])
    end

    def test_print
      test_out  = StringIO.new
      @standard_env = StandardEnvironment.create(output: test_out)
      fn("print").call("hey")
      assert_equal "hey", test_out.string
    end

    def test_procedure
      fn = proc { |x| x * 2 }
      assert  fn("procedure?").call(fn)
      refute fn("procedure?").call([])
    end

    def test_round
      assert_equal 10, fn("round").call(10.3)
    end

    def test_symbol?
      x = Symbol.new("hey")
      assert fn("symbol?").call(x)
      refute fn("symbol?").call(10)
    end

    def test_global_env
      g1 = StandardEnvironment.global
      g2 = StandardEnvironment.global
      assert g1.equal?(g2)
    end

    private

    def fn(name)
      @standard_env[name]
    end
  end
end
