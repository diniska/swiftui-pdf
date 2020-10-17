//
//  PDFPageViewAdditions.swift
//  
//
//  Created by Denis Chaschin on 17.10.2020.
//

import Foundation

#if canImport(PDFKit)
import PDFKit

@available(iOS 13.0, *)
extension PDFPageView {
    /// Creates PDF page view that displays a page with specified index from a document with specified URL
    /// - Parameter url: An URL of a pdf document
    /// - Parameter pageIndex: An zero based index of a page to display. Displays the first page if not specified
    /// - Parameter password: A password to unlock the document if it is encripted and locked
    /// - Note:An empty page is displayed when a document or the specified page is unavailable
    public init(url: URL, pageIndex: Int = 0, password: String? = nil) {
        guard
            let document = PDFDocument(url: url)
        else {
            self.init();
            return
        }
        
        if let password = password, document.isLocked {
            document.unlock(withPassword: password)
        }
        
        let page = pageIndex < document.pageCount ? document.page(at: pageIndex) : nil
        self.init(page: page)
    }
}

#endif
