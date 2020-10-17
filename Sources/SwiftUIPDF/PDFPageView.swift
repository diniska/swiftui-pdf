//
//  PDFPageView.swift
//  
//
//  Created by Denis Chaschin on 17.10.2020.
//

import UIKit

#if canImport(PDFKit)
import PDFKit

#if canImport(SwiftUI) && canImport(Combine)
import SwiftUI
#endif

@available(iOS 11.0, *)
public final class AutoresizablePDFPageView: UIView {
    
    private var aspectRatioConsrtaint: NSLayoutConstraint? {
        willSet { aspectRatioConsrtaint?.isActive = false }
        didSet { aspectRatioConsrtaint?.isActive = true }
    }
    
    private var pageSize: CGSize? {
        didSet {
            aspectRatioConsrtaint = pageSize.map {
                widthAnchor.constraint(equalTo: heightAnchor, multiplier: $0.width / $0.height)
            }
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

@available(iOS 13.0, *)
public struct PDFPageView: UIViewRepresentable {
    public typealias UIViewType = AutoresizablePDFPageView
    
    public var page: PDFPage?
    
    public init(page: PDFPage? = nil) {
        self.page = page
    }
    
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

#endif
#endif
