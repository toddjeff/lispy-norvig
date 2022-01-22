# frozen_string_literal: true

module Lispy
  class Tokenizer
    extend T::Sig

    sig { params(chars: String).returns(Array) }
    def tokenize(chars)
      chars.gsub("(", " ( ").gsub(")", " ) ").split
    end

    sig { params(program: String).returns(Exp) }
    def parse(program)
      read_from_tokens(tokenize(program))
    end

    sig { params(tokens: Array).returns(Exp) }
    def read_from_tokens(tokens)
      raise SyntaxError, "Unexpected EOF" if tokens.empty?
      token = tokens.shift
      if token == "("
        ast = []
        ast.push(read_from_tokens(tokens)) while tokens[0] != ")"
        tokens.shift
        ast
      elsif token == ")"
        raise SyntaxError, "Unexpected ')'"
      else
        atom(token)
      end
    end

    sig { params(token: String).returns(Atom) }
    def atom(token)
      Integer(token)
    rescue ArgumentError
      begin
        Float(token)
      rescue ArgumentError
        symbol(token)
      end
    end

    sig { params(token: String).returns(Symbol) }
    def symbol(token)
      String(token)
    end
  end
end
