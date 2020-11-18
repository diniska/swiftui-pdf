//
//  PDFPageView+UIKit.swift
//  
//
//  Created by Denis Chaschin on 17.10.2020.
//

#if canImport(PDFKit) && canImport(UIKit)

import PDFKit
import UIKit

#if canImport(SwiftUI) && canImport(Combine)

import SwiftUI

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

@available(iOS 13.0, *)
struct PDFPageView_Previews: PreviewProvider {
    static var previews: some View {
        PDFPageView()
    }
}

#endif // SwiftUI & Combine

#endif // PDFKit & UIView
