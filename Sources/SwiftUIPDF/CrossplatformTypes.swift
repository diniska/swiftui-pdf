//
//  CrossplatformTypes.swift
//  
//
//  Created by Denis Chaschin on 18.11.2020.
//

import CoreGraphics

#if canImport(UIKit)

import UIKit
public typealias PlatformView = UIView

var currentGraphicsContext: CGContext? { UIGraphicsGetCurrentContext() }

extension CGContext {
    static var swiftui_pdf_currentContext: CGContext? {
        UIGraphicsGetCurrentContext()
    }
}

#elseif canImport(AppKit)

import AppKit
public typealias PlatformView = NSView

extension NSView {
    func setNeedsDisplay() {
        setNeedsDisplay(bounds)
    }
}

extension CGContext {
    static var swiftui_pdf_currentContext: CGContext? {
        NSGraphicsContext.current?.cgContext
    }
}

#endif
