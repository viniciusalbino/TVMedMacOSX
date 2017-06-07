//
//  String+Extensions.swift
//  TVMed
//
//  Created by Vinicius Albino on 21/02/17.
//  Copyright © 2017 tvMed. All rights reserved.
//

import Foundation

extension String {
    func urlEncodedString() -> String {
        let urlEncodedString = self.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)
        return urlEncodedString ?? self
    }
}

extension String {
    
    /// Percent escapes values to be added to a URL query as specified in RFC 3986
    ///
    /// This percent-escapes all characters besides the alphanumeric character set and "-", ".", "_", and "~".
    ///
    /// http://www.ietf.org/rfc/rfc3986.txt
    ///
    /// :returns: Returns percent-escaped string.
    
    func addingPercentEncodingForURLQueryValue() -> String? {
        let allowedCharacters = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-._~")
        
        return self.addingPercentEncoding(withAllowedCharacters: allowedCharacters)
    }
    
    func insertImageBaseURL() -> URL {
        if let url = URL(string: domain + "\(self)") {
            return url
        } else {
            return URL(string: domain)!
        }
    }
    
    func length() -> Int {
        return Array(self.characters).count
    }
    
    func substringToIndex(index: Int) -> String {
        let index1 = self.index(self.startIndex, offsetBy: index)
        return self.substring(to: index1)
    }
    
    func hasOnlyCharacters(characters: String) -> Bool {
        return hasOnlyCharactersInSet(charSet: CharacterSet(charactersIn: characters))
    }
    
    func hasOnlyCharactersInSet(charSet: CharacterSet) -> Bool {
        return self.rangeOfCharacter(from: charSet.inverted) == nil
    }
    
    func trimWhiteSpaces() -> String {
        return self.replacingOccurrences(of: " ", with: "")
    }
    
    func maskCardNumber() -> String {
        let masked = self.substring(from: self.length() - 4)
        return "xxxx xxxx xxxx \(masked)"
    }
    
    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return substring(from: fromIndex)
    }
    
    // swiftlint:disable:next variable_name
    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return substring(to: toIndex)
    }
    // swiftlint:enable:next variable_name
    
    func substring(with range: Range<Int>) -> String {
        let startIndex = index(from: range.lowerBound)
        let endIndex = index(from: range.upperBound)
        return substring(with: startIndex..<endIndex)
    }
    
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }
}
