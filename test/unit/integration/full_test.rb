# frozen_string_literal: true

require "test_helper"

module Lispy
  class FullTest < Lispy::Test
    def setup
      @tokenizer = Lispy::Tokenizer.new
    end

    def test_define
      make_account = <<~PRG
        (define make-account
           (lambda (balance)
              (lambda (amt)
                  (begin (set! balance (+ balance amt))
                   balance))))
      PRG

      account1 = "(define account1 (make-account 100.00))"
      call_account = "(account1 -20.00)"

      Eval.call(@tokenizer.parse(make_account))
      Eval.call(@tokenizer.parse(account1))
      assert_equal 80.0, Eval.call(@tokenizer.parse(call_account))

    end
  end
end
