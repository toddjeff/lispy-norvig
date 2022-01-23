# frozen_string_literal: true

require "test_helper"

module Lispy
  class EvalTest < Lispy::Test
    def setup
      @tokenizer = Tokenizer.new
    end

    def test_plus
      program = "(+ 1 2)"
      assert_equal 3, eval_(program)
    end

    def test_plus_more
      program = "( + 1 (+ 1 2))"
      assert_equal 4, eval_(program)
    end

    def test_simple
      program = "(begin (define r 10) (* pi (* r r)))"
      expected = 314.1592653589793
      assert_equal expected, eval_(program)
    end

    private

    def eval_(program)
      Eval.call(@tokenizer.parse(program))
    end
  end
end
