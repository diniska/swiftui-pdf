//
//  PDFPageView+UIKit.swift
//  
//
//  Created by Denis Chaschin on 17.10.2020.
//

#if canImport(PDFKit) && canImport(UIKit) && canImport(SwiftUI) && canImport(Combine)

import SwiftUI
import PDFKit
import UIKit

/// A view that displays a single PDF page
@available(iOS 13.0, *)
extension PDFPageView: UIViewRepresentable {
    public typealias UIViewType = AutoresizablePDFPageView
    
    public func makeUIView(context: Context) -> UIViewType {
        let view = UIViewType(frame: .zero)
        view.backgroundColor = .clear
        view.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        view.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        view.setContentHuggingPriority(.defaultLow, for: .horizontal)
        view.setContentHuggingPriority(.defaultLow, for: .vertical)
        return view
    }
    
    public func updateUIView(_ pdfPageView: UIViewType, context: Context) {
        pdfPageView.page = page
    }
    
    public static func dismantleUIView(_ pdfPageView: UIViewType, coordinator: ()) {
        pdfPageView.page = nil
    }
    
}

#endif
