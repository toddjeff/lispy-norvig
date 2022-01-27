# frozen_string_literal: true

require "lispy"
require "minitest"
require "minitest/autorun"
require "minitest/focus"
require "pry-byebug"


module Lispy
  class Test < Minitest::Test
    def teardown
      Lispy::StandardEnvironment.class_variable_set(:@@global, nil)
    end
  end
end
