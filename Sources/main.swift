import Foundation

enum TokenType {
    case unspecified
}

struct Token {
    let type: TokenType
    let tokenString: String
}

func tokenize(_ input: String) -> [Token] {
    let delimiter: String = "@"

    var tokens: [Token] = []
    let splitString: [String] = input.components(separatedBy: delimiter)

    for split: String in splitString {
        var type: TokenType = .unspecified
        
        // if empty
        if split == " " || split == "" {
            type = .unspecified
        }

        tokens.append(Token(type: type, tokenString: split))
    }

    return tokens
}

let tokens: [Token] = tokenize("Hello@World!")

// Print all tokens
for token in tokens {
    print("Type: \(token.type) - Token: \(token.tokenString)")
}