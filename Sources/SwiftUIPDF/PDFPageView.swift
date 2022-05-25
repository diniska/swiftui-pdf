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

#if canImport(SwiftUI) && canImport(Combine) && (arch(arm64) || arch(x86_64))

import SwiftUI

@available(iOS 13.0, macOS 10.15, *)
struct PDFPageView_Previews: PreviewProvider {
    static var previews: some View {
        PDFPageView()
    }
}

#endif // SwiftUI & Combine

#endif // PDFKit
