//
//  SearchBarEventPublisher.swift
//  Shared
//
//  Copyright (c) 2023 Justin Peckner
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

import Combine

public class SearchBarEventPublisher: NSObject {

    public var eventPublisher: AnyPublisher<SearchBarEditEvent, Never> {
        AnyPublisher(eventSubject)
    }

    public var searchBarSubmitPublisher: AnyPublisher<String?, Never> {
        AnyPublisher(searchTappedSubject)
    }

    private let eventSubject = PassthroughSubject<SearchBarEditEvent, Never>()
    private let searchTappedSubject = PassthroughSubject<String?, Never>()

    private var didTapDeleteKey = false

}

extension SearchBarEventPublisher: UISearchBarDelegate {

    public func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        eventSubject.send(.beganEditing)
    }

    public func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        eventSubject.send(.endedEditing)
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
            eventSubject.send(.clearedInput)
        }

        didTapDeleteKey = false
    }

    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchTappedSubject.send(searchBar.text)
    }

}
