# frozen_string_literal: true

require "test_helper"

class TokenizerTest < Lispy::Test
  def setup
    @tokenizer = Lispy::Tokenizer.new
  end

  def test_tokenizer
    assert_equal ["(", ")"], @tokenizer.tokenize("()")
  end

  def test_tokenizer_2
    assert_equal ["(", "*", "1", "2", ")"], @tokenizer.tokenize("(* 1 2)")
  end

  def test_parse_simple
    program = "(+ 1 2)"
    tokens = @tokenizer.parse(program)
    assert_equal tokens.class, Array
  end

  def test_parse_program
    program = "(begin (define r 10) (* pi (* r r)))"
    expected = ["begin", ["define", "r", 10], ["*", "pi", ["*", "r", "r"]]]
    assert_equal expected, @tokenizer.parse(program)
  end

  def test_atom
    assert_equal Integer, @tokenizer.atom("1").class
  end

  def test_symbol
    assert_equal String, @tokenizer.symbol("aaaa").class
  end
end
