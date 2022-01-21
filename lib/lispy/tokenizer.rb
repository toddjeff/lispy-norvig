# frozen_string_literal: true

module Lispy
  class Tokenizer
    extend T::Sig

    sig { params(chars: String).returns(Array) }
    def tokenize(chars)
      chars.sub("(", " ( ").sub(")", " ) ").split
    end

    sig { params(program: String).returns(Exp) }
    def parse(program)
      read_from_tokens(tokenize(program))
    end

    sig { params(tokens: Array).returns(Exp) }
    def read_from_tokens(tokens)
      raise SyntaxError, "Unexpected EOF" if tokens.empty?
    end
  end
end
