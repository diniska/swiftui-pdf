//
//  PDFPageView+UIKit.swift
//  
//
//  Created by Denis Chaschin on 17.10.2020.
//

#if canImport(PDFKit) && canImport(UIKit)

import PDFKit
import UIKit

/// A view that displays PDF page inside its bounds.
/// The PDF page automatically scales to fit the view
@available(iOS 11.0, *)
public final class AutoresizablePDFPageView: UIView {
    
    private var pageSize: CGSize? {
        didSet {
            guard pageSize != oldValue else { return }
            invalidateIntrinsicContentSize()
        }
    }
    
    public var page: PDFPage? {
        didSet {
            pageSize = page?.bounds(for: .trimBox).size
            setNeedsDisplay()
        }
    }
    
    public override var frame: CGRect {
        didSet {
            setNeedsDisplay()
        }
    }
    
    public override func draw(_ rect: CGRect) {
        guard
            let page = page,
            let size = pageSize,
            let context = UIGraphicsGetCurrentContext()
        else { return }
        let scale = bounds.size.width / size.width
        
        context.scaleBy(x: scale, y: scale)
        context.translateBy(x: 0, y: size.height)
        context.scaleBy(x: 1, y: -1)
        page.draw(with: .trimBox, to: context)
    }
    
    public override var intrinsicContentSize: CGSize {
        pageSize ?? .zero
    }
}

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
