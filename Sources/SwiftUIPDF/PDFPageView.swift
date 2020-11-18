//
//  PDFPageView.swift
//  
//
//  Created by Denis Chaschin on 18.11.2020.
//

#if canImport(PDFKit)

import PDFKit

/// A view that displays a single PDF page
@available(iOS 11.0, macOS 10.4, *)
public struct PDFPageView {
    public var page: PDFPage?
    
    public init(page: PDFPage? = nil) {
        self.page = page
    }
}

#endif
