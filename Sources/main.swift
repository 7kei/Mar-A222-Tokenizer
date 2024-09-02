import Foundation

enum TokenType {
    case word
    case number
    case alphanumeric
    case punctuation
    case newline
    case unspecified
}

struct Token {
    let type: TokenType
    let tokenString: String
}

func tokenize(_ input: String) -> [Token] {
    let delimiter: String = "@"

    let alphabet: String = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ "
    let digits: String = "0123456789"
    let punct: String = ".,;:!?'\""
    let newline: String = "\r\n"

    var tokens: [Token] = []
    let splitString: [String] = input.components(separatedBy: delimiter)

    for split: String in splitString {
        var type: TokenType = .unspecified
        
        // if empty
        if split == "" {
            type = .unspecified
        } else if split.rangeOfCharacter(from: CharacterSet(charactersIn: alphabet)) != nil {
            type = .word
            if split.rangeOfCharacter(from: CharacterSet(charactersIn: digits)) != nil { 
                type = .alphanumeric 
            }
        } else if split.rangeOfCharacter(from: CharacterSet(charactersIn: newline)) != nil {
            type = .newline
        } else if split.rangeOfCharacter(from: CharacterSet(charactersIn: digits)) != nil {
            type = .number
        } else if split.rangeOfCharacter(from: CharacterSet(charactersIn: punct)) != nil {
            type = .punctuation
        }

        tokens.append(Token(type: type, tokenString: split))
    }

    return tokens
}

let tokens: [Token] = tokenize("Hello1@World!@1@ 2@@@")

// Phase 1
print("===================================================\nPhase 1 Output:")
for token in tokens {
    print("Token: \(token.tokenString) - Type: \(token.type)")
}

// Phase 2
print("===================================================\nPhase 2 Output (Granular Breakdown):")
for token in tokens {
    print("Token: \(token.tokenString) -> \(Array(token.tokenString))")
}