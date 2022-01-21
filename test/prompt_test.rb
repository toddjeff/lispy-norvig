# frozen_string_literal: true

require "helper"

class PromptTest < Lispy::Test

  def setup
    @prompt = Lispy::Prompt.new
  end

  def test_one
    assert_equal ["(", ")"], @prompt.tokenize("()")
  end
end
