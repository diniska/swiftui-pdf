//
//  AutoresizablePDFPageView.swift
//  
//
//  Created by Denis Chaschin on 18.11.2020.
//

#if canImport(PDFKit)

import PDFKit

/// A view that displays PDF page inside its bounds.
/// The PDF page automatically scales to fit the view
@available(iOS 11.0, macOS 10.4, *)
public final class AutoresizablePDFPageView: PlatformView {
    
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
            let context = CGContext.swiftui_pdf_currentContext
        else { return }
        let scale = bounds.size.width / size.width
        
        context.scaleBy(x: scale, y: scale)
        #if canImport(UIKit)
        context.translateBy(x: 0, y: size.height)
        context.scaleBy(x: 1, y: -1)
        #endif
        page.draw(with: .trimBox, to: context)
    }
    
    public override var intrinsicContentSize: CGSize {
        pageSize ?? .zero
    }
}

#endif
