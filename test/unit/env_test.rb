# frozen_string_literal: true

require "test_helper"

module Lispy
  class EnvTest < Lispy::Test
    def setup
      @standard_env = Environment.standard
    end

    def test_math_methods_count
      assert_equal 26, Environment.math_methods.keys.length
    end

    def test_math_methods
      expected = -3.141592653589793
      assert_equal expected, @standard_env["atan2"].call(-0.0, -1.0)
    end
  end
end
