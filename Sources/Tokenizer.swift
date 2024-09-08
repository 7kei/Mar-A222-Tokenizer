import Foundation

public class Tokenizer {
    public enum TokenType {
        case word
        case alphanumeric
        case number
        case punctuation
        case endofline
        case tab
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
    private let newline: String = "\r\n"
    private let tab: String = "\t"
    private let whitespace: String = "\u{000B}\u{000C} "

    public func tokenize(_ input: String) -> [Token] {
        var tokens: [Token] = []
        let splitString: [String] = input.components(separatedBy: delimiter)

        for split: String in splitString {
            var type: TokenType = .unspecified
            
            if split.isEmpty {
                continue // Skip if token is empty
            } else if split.rangeOfCharacter(from: CharacterSet(charactersIn: alphabet)) != nil {
                type = .word
                if split.rangeOfCharacter(from: CharacterSet(charactersIn: digits)) != nil { 
                    type = .alphanumeric 
                }
            } else if split.rangeOfCharacter(from: CharacterSet(charactersIn: digits)) != nil {
                type = .number
                if split.rangeOfCharacter(from: CharacterSet(charactersIn: alphabet)) != nil { 
                    type = .alphanumeric 
                }
            } else if split.rangeOfCharacter(from: CharacterSet(charactersIn: punct)) != nil {
                type = .punctuation
            } else if split.rangeOfCharacter(from: CharacterSet(charactersIn: newline)) != nil {
                type = .endofline
            } else if split.rangeOfCharacter(from: CharacterSet(charactersIn: tab)) != nil {
                type = .tab
            } else if split.rangeOfCharacter(from: CharacterSet(charactersIn: whitespace)) != nil {
                type = .whitespace
            } 

            tokens.append(Token(type: type, tokenString: split))
        }

        return tokens
    }
}
