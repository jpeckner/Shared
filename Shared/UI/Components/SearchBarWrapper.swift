//
//  SearchBarWrapper.swift
//  Shared
//
//  Copyright (c) 2020 Justin Peckner
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

import UIKit

// MARK: SearchBarEditEvent

public enum SearchBarEditEvent: CaseIterable {
    case beganEditing
    case clearedInput
    case endedEditing
}

// MARK: SearchBarConfig

public struct SearchBarConfig {
    let autocorrectionType: UITextAutocorrectionType
    let keyboardType: UIKeyboardType
    let returnKeyType: UIReturnKeyType
    let enablesReturnKeyAutomatically: Bool
}

// MARK: SearchBarWrapper

public protocol SearchBarWrapperDelegate: AnyObject {
    func searchBarWrapper(_ searchBarWrapper: SearchBarWrapper, didPerformEvent event: SearchBarEditEvent)

    func searchBarWrapper(_ searchBarWrapper: SearchBarWrapper, didClickSearch text: String?)
}

public class SearchBarWrapper: NSObject {

    public weak var delegate: SearchBarWrapperDelegate?

    public var isFirstResponder = false {
        didSet {
            if isFirstResponder {
                if !searchBar.isFirstResponder {
                    searchBar.becomeFirstResponder()
                }
            } else {
                if searchBar.isFirstResponder {
                    searchBar.resignFirstResponder()
                }
            }
        }
    }

    public var view: UIView {
        return searchBar
    }

    private let searchBar: UISearchBar
    private var didTapDeleteKey = false

    public init(config: SearchBarConfig) {
        self.searchBar = UISearchBar()
        searchBar.autocorrectionType = config.autocorrectionType
        searchBar.keyboardType = config.keyboardType
        searchBar.returnKeyType = config.returnKeyType
        searchBar.enablesReturnKeyAutomatically = config.enablesReturnKeyAutomatically

        super.init()

        searchBar.delegate = self
    }

    override public convenience init() {
        let config = SearchBarConfig(autocorrectionType: .yes,
                                     keyboardType: .default,
                                     returnKeyType: .go,
                                     enablesReturnKeyAutomatically: true)
        self.init(config: config)
    }

}

public extension SearchBarWrapper {

    func configureText(_ text: String?) {
        searchBar.text = text
    }

    func configurePlaceholder(_ placeholder: String?) {
        searchBar.placeholder = placeholder
    }

}

extension SearchBarWrapper: UISearchBarDelegate {

    public func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        delegate?.searchBarWrapper(self, didPerformEvent: .beganEditing)
    }

    public func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        delegate?.searchBarWrapper(self, didPerformEvent: .endedEditing)
    }

    // Hacky way to detect that the circled-X button was tapped; unfortunately Apple doesn't provide a real API for it.
    // Source: https://stackoverflow.com/a/52620389/1342984
    public func searchBar(_ searchBar: UISearchBar,
                          shouldChangeTextIn range: NSRange,
                          replacementText text: String) -> Bool {
        didTapDeleteKey = text.isEmpty
        return true
    }

    public func searchBar(_ searchBar: UISearchBar,
                          textDidChange searchText: String) {
        if !didTapDeleteKey && searchText.isEmpty {
            delegate?.searchBarWrapper(self, didPerformEvent: .clearedInput)
        }

        didTapDeleteKey = false
    }

    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        delegate?.searchBarWrapper(self, didClickSearch: searchBar.text)
    }

}
