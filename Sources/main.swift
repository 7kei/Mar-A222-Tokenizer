enum TokenType {
    case unspecified
}

struct Token {
    let type: TokenType
    let token: String
}

func tokenize(_ input: String) -> () {

}

let tokens: [Token] = tokenize("Hello@World!")