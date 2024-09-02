import Foundation

enum TokenType {
    case word
    case number
    case unspecified
}

struct Token {
    let type: TokenType
    let tokenString: String
}

func tokenize(_ input: String) -> [Token] {
    let delimiter: String = "@"

    let alphabet: String = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
    let digits: String = "0123456789"

    var tokens: [Token] = []
    let splitString: [String] = input.components(separatedBy: delimiter)

    for split: String in splitString {
        var type: TokenType = .unspecified
        
        // if empty
        if split == " " || split == "" {
            type = .unspecified
        } else if split.rangeOfCharacter(from: CharacterSet(charactersIn: alphabet)) != nil {
            type = .word
        } else if split.rangeOfCharacter(from: CharacterSet(charactersIn: digits)) != nil {
            type = .number
        }

        tokens.append(Token(type: type, tokenString: split))
    }

    return tokens
}

let tokens: [Token] = tokenize("Hello@World!@1")

// Print all tokens
for token in tokens {
    print("Type: \(token.type) - Token: \(token.tokenString)")
}