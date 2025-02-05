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
    private let tokenizer = Tokenizer()

    /// A required initializer for the application.
    public required init() {
        super.init()
        unhandledException.addHandler { (_, args:UnhandledExceptionEventArgs!) in
            print("Unhandled exception: \(args.message)")
        }
    }

    /// Main entry point of the application
    override public func onLaunched(_ args: WinUI.LaunchActivatedEventArgs) {
        // Main window
        let window = Window()
        window.title = "Swift Tokenizer"
        window.systemBackdrop = MicaBackdrop()
        window.extendsContentIntoTitleBar = true
        try! window.activate()

        // Title text
        let titleTextBlock = TextBlock()
        titleTextBlock.text = "🐦‍🔥 Swift Tokenizer"
        titleTextBlock.fontSize = 25.0
        titleTextBlock.isTextSelectionEnabled = false

        // Start of input section
        inputTextBox.header = "Input to be tokenized:"
        inputTextBox.placeholderText = "Enter here"
        inputTextBox.minWidth = 300.0
        inputTextBox.maxWidth = 300.0

        let inputButton = Button()
        inputButton.content = "Tokenize"
        inputButton.minHeight = 60.0
        inputButton.minWidth = 60.0
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

        // Start of test buttons section
        let testButton1 = Button()
        testButton1.content = "Test 1"
        testButton1.click.addHandler { [weak self] in
            guard let self else { return }
            self.onTest1(sender: $0, args: $1)
        }

        let testButton2 = Button()
        testButton2.content = "Test 2"
        testButton2.click.addHandler { [weak self] in
            guard let self else { return }
            self.onTest2(sender: $0, args: $1)
        }

        let testButton3 = Button()
        testButton3.content = "Test 3"
        testButton3.click.addHandler { [weak self] in
            guard let self else { return }
            self.onTest3(sender: $0, args: $1)
        }

        let testButton4 = Button()
        testButton4.content = "Test 4"
        testButton4.click.addHandler { [weak self] in
            guard let self else { return }
            self.onTest4(sender: $0, args: $1)
        }

        let testButton5 = Button()
        testButton5.content = "Test 5"
        testButton5.click.addHandler { [weak self] in
            guard let self else { return }
            self.onTest5(sender: $0, args: $1)
        }

        let testStackPanel = StackPanel()
        testStackPanel.orientation = .horizontal
        testStackPanel.spacing = 10
        testStackPanel.verticalAlignment = .bottom
        testStackPanel.children.append(testButton1)
        testStackPanel.children.append(testButton2)
        testStackPanel.children.append(testButton3)
        testStackPanel.children.append(testButton4)
        testStackPanel.children.append(testButton5)

        // Output text blocks section
        phase1TextBlock.width = 400.0
        phase1TextBlock.textWrapping = .wrap
        phase1TextBlock.text = "Phase 1"

        let phase1ScrollView = ScrollViewer()
        phase1ScrollView.height = 370.0
        phase1ScrollView.verticalScrollBarVisibility = .auto
        phase1ScrollView.content = phase1TextBlock

        phase2TextBlock.width = 400.0
        phase2TextBlock.textWrapping = .wrap
        phase2TextBlock.text = "Phase 2"

        let phase2ScrollView = ScrollViewer()
        phase2ScrollView.height = 370.0
        phase2ScrollView.verticalScrollBarVisibility = .auto
        phase2ScrollView.content = phase2TextBlock

        let outputStackPanel = StackPanel()
        outputStackPanel.orientation = .horizontal
        outputStackPanel.spacing = 10
        outputStackPanel.verticalAlignment = .top
        outputStackPanel.children.append(phase1ScrollView)
        outputStackPanel.children.append(phase2ScrollView)

        // Author section
        let authorTextBlock = TextBlock()
        authorTextBlock.text = "Created with 🧡 by Keian Mar"
        authorTextBlock.fontSize = 15.0
        authorTextBlock.isTextSelectionEnabled = false

        // Main panel where everything is contained
        let mainPanel = StackPanel()
        mainPanel.orientation = .vertical
        mainPanel.spacing = 15
        mainPanel.padding = Thickness(left: 25, top: 25, right: 25, bottom: 25)
        mainPanel.horizontalAlignment = .left
        mainPanel.verticalAlignment = .top
        mainPanel.children.append(titleTextBlock)
        mainPanel.children.append(inputStackPanel)
        mainPanel.children.append(testStackPanel)
        mainPanel.children.append(outputStackPanel)
        mainPanel.children.append(authorTextBlock)
        window.content = mainPanel
    }

    private func outputToTextBlocks(_ tokens: [Tokenizer.Token]) {
        var phase1Text = "Phase 1 Output: \n\n"
        var phase2Text = "Phase 2 Output: \n\n"
        
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

    private func onTokenize(sender: Any!, args: RoutedEventArgs!) {
        outputToTextBlocks(tokenizer.tokenize(inputTextBox.text))
    }

    private func onTest1(sender: Any!, args: RoutedEventArgs!) {
        let text = """
AA@.@123@AB123@CD EFG@
@	@ @
"""
        inputTextBox.text = text
        outputToTextBlocks(tokenizer.tokenize(text))
    }

    private func onTest2(sender: Any!, args: RoutedEventArgs!) {
        let text = "Hello@World@!"
        inputTextBox.text = text
        outputToTextBlocks(tokenizer.tokenize(text))
    }

    private func onTest3(sender: Any!, args: RoutedEventArgs!) {
        let text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer et lectus eleifend, faucibus est at, commodo neque. Sed leo quam, dignissim quis elit ut, auctor facilisis neque. Cras tempus magna vitae consectetur aliquam. Sed et viverra odio, in interdum ligula. Nulla bibendum sodales nibh, faucibus dictum tortor fermentum non. Praesent ac nisi nec diam consequat dignissim. Quisque finibus pretium aliquet. Vivamus iaculis dolor et dui aliquet, eu pretium dui porttitor. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras nec ex id tellus euismod pharetra. Cras tempus libero sapien, at accumsan ante fringilla eget. Proin massa diam, fringilla sit amet tortor eget, pulvinar scelerisque felis. Praesent porta, risus eget hendrerit facilisis, neque diam consectetur erat, a dignissim urna arcu vel nisl. Morbi a purus sit amet turpis dictum suscipit. Interdum et malesuada fames ac ante ipsum primis in faucibus. Aenean in lorem pellentesque, congue mauris eu, imperdiet nunc."
        inputTextBox.text = text
        outputToTextBlocks(tokenizer.tokenize(text))
    }

    private func onTest4(sender: Any!, args: RoutedEventArgs!) {
        let text = """
Zany@	@Xylophone@	@Creates@	@Vibrant@	@Beats@!@98765@43210@13579@24680@
"""
        inputTextBox.text = text
        outputToTextBlocks(tokenizer.tokenize(text))
    }

    private func onTest5(sender: Any!, args: RoutedEventArgs!) {
        let text = "KEIAN MAR@A222@UNTAPASAKO1"
        inputTextBox.text = text
        outputToTextBlocks(tokenizer.tokenize(text))
    }
}
