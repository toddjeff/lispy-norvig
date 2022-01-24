# frozen_string_literal: true

require "readline"

module Lispy
  class Repl
    def initialize
      @tokenizer = Tokenizer.new
    end

    def call
      puts("Lispy Version #{Lispy::VERSION}")
      puts("Press Ctrl+c to Exit\n")

      begin
        while (input = Readline.readline(">", true))
          puts Eval.call(@tokenizer.parse(input))
        end
      rescue StandardError => e
        puts e
        retry
      end
    end
  end
end
