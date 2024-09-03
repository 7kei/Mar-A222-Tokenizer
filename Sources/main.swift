import Foundation

enum TokenType {
    case word
    case number
    case alphanumeric
    case punctuation
    case newline
    case whitespace
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
    let punct: String = ".,;:!?'\""
    let newline: String = "\n"
    let whitespace: String = "\r\t\u{000B}\u{000C} "

    var tokens: [Token] = []
    let splitString: [String] = input.components(separatedBy: delimiter)

    for split: String in splitString {
        var type: TokenType = .unspecified
        
        // if empty
        if split == "" {
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


func main() -> () {
    print("Enter string to tokenize: ", terminator: "")
    let stringToTokenize = readLine()
    let tokens: [Token] = tokenize(stringToTokenize!)

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
}

main()