import Foundation
import UWP
import WinAppSDK
import WindowsFoundation
import WinUI

@main
public class UIApp: SwiftApplication {
    private let phase1TextBlock = TextBlock()
    private let phase2TextBlock = TextBlock()
    private let inputTextBox = TextBox()

    /// A required initializer for the application.
    public required init() {
        super.init()
        unhandledException.addHandler { (_, args:UnhandledExceptionEventArgs!) in
            print("Unhandled exception: \(args.message)")
        }
    }

    /// Main entry point of the application
    override public func onLaunched(_ args: WinUI.LaunchActivatedEventArgs) {
        let window = Window()
        window.title = "Swift Tokenizer"
        window.systemBackdrop = MicaBackdrop()
        window.extendsContentIntoTitleBar = true

        try! window.activate()

        let titleTextBlock = TextBlock()
        titleTextBlock.text = "🐦‍🔥 Swift Tokenizer"
        titleTextBlock.fontSize = 25.0
        titleTextBlock.isTextSelectionEnabled = false

        inputTextBox.header = "Input to be tokenized:"
        inputTextBox.placeholderText = "Enter here"
        inputTextBox.minWidth = 300.0
        inputTextBox.maxWidth = 300.0

        let inputButton = Button()
        inputButton.content = "Tokenize"
        inputButton.minHeight = 60.0
        inputButton.click.addHandler { [weak self] in
            guard let self else { return }
            self.onTokenize(sender: $0, args: $1)
        }

        let inputStackPanel = StackPanel()
        inputStackPanel.orientation = .horizontal
        inputStackPanel.spacing = 10
        inputStackPanel.verticalAlignment = .bottom
        inputStackPanel.children.append(inputTextBox)
        inputStackPanel.children.append(inputButton)

        phase1TextBlock.width = 500.0
        phase1TextBlock.textWrapping = .wrap
        phase1TextBlock.text = "Phase 1"

        let phase1ScrollView = ScrollViewer()
        phase1ScrollView.height = 385.0
        phase1ScrollView.verticalScrollBarVisibility = .auto
        phase1ScrollView.content = phase1TextBlock

        phase2TextBlock.width = 500.0
        phase2TextBlock.textWrapping = .wrap
        phase2TextBlock.text = "Phase 2"

        let phase2ScrollView = ScrollViewer()
        phase2ScrollView.height = 385.0
        phase2ScrollView.verticalScrollBarVisibility = .auto
        phase2ScrollView.content = phase2TextBlock

        let outputStackPanel = StackPanel()
        outputStackPanel.orientation = .horizontal
        outputStackPanel.spacing = 10
        outputStackPanel.verticalAlignment = .top
        outputStackPanel.children.append(phase1ScrollView)
        outputStackPanel.children.append(phase2ScrollView)

        let authorTextBlock = TextBlock()
        authorTextBlock.text = "Created with 🧡 by Keian Mar"
        authorTextBlock.fontSize = 15.0
        authorTextBlock.isTextSelectionEnabled = false

        let mainPanel = StackPanel()
        mainPanel.orientation = .vertical
        mainPanel.spacing = 25
        mainPanel.padding = Thickness(left: 25, top: 25, right: 25, bottom: 25)
        mainPanel.horizontalAlignment = .left
        mainPanel.verticalAlignment = .top
        mainPanel.children.append(titleTextBlock)
        mainPanel.children.append(inputStackPanel)
        mainPanel.children.append(outputStackPanel)
        mainPanel.children.append(authorTextBlock)
        window.content = mainPanel
    }

    private func onTokenize(sender: Any!, args: RoutedEventArgs!) {
        var phase1Text = "Phase 1 Output: \n\n"
        var phase2Text = "Phase 2 Output: \n\n"

        let tokenizer = Tokenizer()
        let tokens = tokenizer.tokenize(inputTextBox.text)

        // Phase 1
        for token in tokens {
            phase1Text += "Token: \(token.tokenString) - Type: \(token.type)\n"
        }

        // Phase 2
        for token in tokens {
            phase2Text += "Token: \(token.tokenString) -> \(Array(token.tokenString))\n"
        } 

        phase1TextBlock.text = phase1Text
        phase2TextBlock.text = phase2Text
    }
}
