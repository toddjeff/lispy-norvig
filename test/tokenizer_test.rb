# frozen_string_literal: true

require "helper"

class TokenizerTest < Lispy::Test

  def setup
    @tokenizer = Lispy::Tokenizer.new
  end

  def test_one
    assert_equal ["(", ")"], @tokenizer.tokenize("()")
  end
end
