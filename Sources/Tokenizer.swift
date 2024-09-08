import Foundation

public class Tokenizer {
    public enum TokenType {
        case word
        case number
        case alphanumeric
        case punctuation
        case newline
        case whitespace
        case unspecified
    }

    public struct Token {
        public let type: TokenType
        public let tokenString: String
    }

    private let delimiter: String = "@"
    private let alphabet: String = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
    private let digits: String = "0123456789"
    private let punct: String = ".,;:!?'\""
    private let newline: String = "\n"
    private let whitespace: String = "\r\t\u{000B}\u{000C} "

    public func tokenize(_ input: String) -> [Token] {
        var tokens: [Token] = []
        let splitString: [String] = input.components(separatedBy: delimiter)

        for split: String in splitString {
            var type: TokenType = .unspecified
            
            if split.isEmpty {
                continue
            } else if split.rangeOfCharacter(from: CharacterSet(charactersIn: alphabet)) != nil {
                type = .word
                if split.rangeOfCharacter(from: CharacterSet(charactersIn: digits)) != nil { 
                    type = .alphanumeric 
                }
            } else if split.rangeOfCharacter(from: CharacterSet(charactersIn: digits)) != nil {
                type = .number
            } else if split.rangeOfCharacter(from: CharacterSet(charactersIn: punct)) != nil {
                type = .punctuation
            } else if split.rangeOfCharacter(from: CharacterSet(charactersIn: whitespace)) != nil {
                type = .whitespace
            } else if split.rangeOfCharacter(from: CharacterSet(charactersIn: newline)) != nil {
                type = .newline
            } 

            tokens.append(Token(type: type, tokenString: split))
        }

        return tokens
    }
}