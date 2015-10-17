//
//  PDFUtility.swift
//  Papoose
//
//  Created by paul sohal on 8/16/15.
//  Copyright (c) 2015 Acceler Inc. All rights reserved.
//

import Foundation

class PDFUtility {
    
    func renderAsPDF(demandEntry: [Gift]) -> NSData?
    {
        // Thanks to http://www.labs.saachitech.com/2012/10/23/pdf-generation-using-uiprintpagerenderer
        
        // 1. Create a print formatter
        
        let html = "<b>Hello <i>World!</i></b>"
        
        
        let fmt = UIMarkupTextPrintFormatter(markupText: html)
        
        // 2. Assign print formatter to UIPrintPageRenderer
        
        let render = UIPrintPageRenderer()
        render.addPrintFormatter(fmt, startingAtPageAtIndex: 0)
        
        // 3. Assign paperRect and printableRect
        
        let page = CGRect(x: 0, y: 0, width: 595.2, height: 841.8) // A4, 72 dpi
        let printable = CGRectInset(page, 0, 0)
        
        render.setValue(NSValue(CGRect: page), forKey: "paperRect")
        render.setValue(NSValue(CGRect: printable), forKey: "printableRect")
        
        // 4. Create PDF context and draw
        
        let pdfData = NSMutableData()
        UIGraphicsBeginPDFContextToData(pdfData, CGRectZero, nil)
        
        for i in 1...render.numberOfPages() {
            
            UIGraphicsBeginPDFPage();
            let bounds = UIGraphicsGetPDFContextBounds()
            render.drawPageAtIndex(i - 1, inRect: bounds)
        }
        
        UIGraphicsEndPDFContext();
        
        return pdfData;
        
    }
    
    func singleViewToPDF(view: UIView) -> NSData? {
    
        let pdfData = NSMutableData()
        UIGraphicsBeginPDFContextToData(pdfData, CGRect(x: 0, y: 0, width: 612, height: 792), nil)
        
        let context = UIGraphicsGetCurrentContext()
        
        UIGraphicsBeginPDFPage()
        view.layer.renderInContext(context)
        
        UIGraphicsEndPDFContext()
        
        return pdfData
    }
    
    func viewToPDF(views: [UIView]) -> NSData? {
        
        if views.isEmpty {
            return nil
        }
        
        let pdfData = NSMutableData()
        UIGraphicsBeginPDFContextToData(pdfData, CGRect(x: 0, y: 0, width: 612, height: 792), nil)
        
        let context = UIGraphicsGetCurrentContext()
        
        for view in views {
            UIGraphicsBeginPDFPage()
            view.layer.renderInContext(context)
        }
        
        UIGraphicsEndPDFContext()
        
        return pdfData
    }
    
    func viewTest(view: UIView)
    {
     var test = "";
    }
    
}