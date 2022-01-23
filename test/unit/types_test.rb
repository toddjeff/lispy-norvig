# frozen_string_literal: true

require "test_helper"

module Lispy
  class TypesTest < Lispy::Test
    def test_symbol
      x = Symbol.new("hey")

      assert x.instance_of?(Symbol)
    end

    def test_number
      x = Number.new(10)
      y = Number.new(10)

      assert_equal x, y
    end
  end
end
