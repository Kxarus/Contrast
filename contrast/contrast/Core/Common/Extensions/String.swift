//
//  StringExtension.swift
//  contrast
//
//  Created by Roman Kiruxin on 28.06.2023.
//

import Foundation

enum DateFormat: String, CaseIterable {
    case dateTimeFromServer = "yyyy-MM-dd HH:mm"
    case dateTimeFromServerV2 = "yyyy-MM-dd HH:mm:ss"
    case dateFromServer4 = "yyyy-MM-dd'T'HH:mm:ss"
    case dateFromServer = "yyyy-MM-dd"
    case dateFromServer2 = "YYYY/MM/DD"
    case dateFromServer3 = "dd.MM.yyyy"
    case dateFromServer5 = "dd'/'MM'/'yyyy"
    case timeFromServer1 = "HH:mm"
}

extension String {
    // MARK: - Network Error
    static let errorWTF = "Something went wrong"
    // MARK: - 4xx
    static let error400 = "Bad Request"
    static let error401 = "Unauthorized"
    static let error402 = "Payment Required"
    static let error403 = "Forbidden"
    static let error404 = "Not Found"
    static let error405 = "Method Not Allowed"
    static let error406 = "Not Acceptable"
    static let error407 = "Proxy Authentication Required"
    static let error408 = "Request Timeout"
    static let error409 = "Conflict"
    static let error410 = "Gone"
    static let error411 = "Length Required"
    static let error412 = "Precondition Failed"
    static let error413 = "Payload Too Large"
    static let error414 = "URI Too Long"
    static let error415 = "Unsupported Media Type"
    static let error416 = "Range Not Satisfiable"
    static let error417 = "Expectation Failed"
    static let error418 = "I’m a teapot"
    static let error419 = "Authentication Timeout"
    static let error421 = "Misdirected Request"
    static let error422 = "Unprocessable Entity"
    static let error423 = "Locked"
    static let error424 = "Failed Dependency"
    static let error425 = "Too Early"
    static let error426 = "Upgrade Required"
    static let error428 = "Precondition Required"
    static let error429 = "Too Many Requests"
    static let error431 = "Request Header Fields Too Large"
    static let error434 = "Requested host unavailable"
    static let error449 = "Retry With"
    static let error451 = "Unavailable For Legal Reasons"
    static let error499 = "Client Closed Request"
    // MARK: - 5xx
    static let error500 = "Internal Server Error"
    static let error501 = "Not Implemented"
    static let error502 = "Bad Gateway"
    static let error503 = "Service Unavailable"
    static let error504 = "Gateway Timeout"
    static let error505 = "HTTP Version Not Supported"
    static let error506 = "Variant Also Negotiates"
    static let error507 = "Insufficient Storage"
    static let error508 = "Loop Detected"
    static let error509 = "Bandwidth Limit Exceeded"
    static let error510 = "Not Extended"
    static let error511 = "Network Authentication Required"
    static let error520 = "Unknown Error"
    static let error521 = "Web Server Is Down"
    static let error522 = "Connection Timed Out"
    static let error523 = "Origin Is Unreachable"
    static let error524 = "A Timeout Occurred"
    static let error525 = "SSL Handshake Failed"
    static let error526 = "Invalid SSL Certificate"
}

extension String {
    
    func convertToDateWithFormats(
        withFormats: [DateFormat] = DateFormat.allCases
    ) -> Date? {
        let dateFormatter = DateFormatter().do {
            $0.timeZone = TimeZone(abbreviation: "UTC+3")
        }

        var date: Date?

        withFormats.forEach {
            dateFormatter.dateFormat = $0.rawValue
            if let parsedDate = dateFormatter.date(from: self) {
                date = parsedDate
                return
            }
        }

        return date
    }
    
    var isNumeric : Bool {
        return CharacterSet(charactersIn: self).isSubset(of: CharacterSet.decimalDigits)
    }
    
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data,
                                          options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}

extension String {
    func firstCharacterUpperCase() -> String? {
        guard !isEmpty else { return nil }
        let lowerCasedString = self.lowercased()
        return lowerCasedString.replacingCharacters(in: lowerCasedString.startIndex...lowerCasedString.startIndex, with: String(lowerCasedString[lowerCasedString.startIndex]).uppercased())
    }
}

// MARK: - URL Encode/Decode
extension String {
    var encodeUrl: String {
        return self.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) ?? ""
    }

    var decodeUrl: String {
        return self.removingPercentEncoding ?? ""
    }
}
