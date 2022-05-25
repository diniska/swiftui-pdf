//
//  PDFPageView+AppKit.swift
//  
//
//  Created by Denis Chaschin on 18.11.2020.
//

#if canImport(PDFKit) && canImport(AppKit) && canImport(SwiftUI) && canImport(Combine) && (arch(arm64) || arch(x86_64))

import AppKit
import SwiftUI
import PDFKit

/// A view that displays a single PDF page
@available(macOS 10.15, *)
extension PDFPageView: NSViewRepresentable {
    
    public typealias NSViewType = AutoresizablePDFPageView
    
    public func makeNSView(context: Context) -> NSViewType {
        let view = NSViewType(frame: .zero)
        view.layer?.backgroundColor = .clear
        view.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        view.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        view.setContentHuggingPriority(.defaultLow, for: .horizontal)
        view.setContentHuggingPriority(.defaultLow, for: .vertical)
        return view
    }
    
    public func updateNSView(_ pdfPageView: NSViewType, context: Context) {
        pdfPageView.page = page
    }
    
    public static func dismantleNSView(_ pdfPageView: NSViewType, coordinator: ()) {
        pdfPageView.page = nil
    }
    
}

#endif
