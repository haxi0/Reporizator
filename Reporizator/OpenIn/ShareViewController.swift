//
//  ShareViewController.swift
//  OpenIn
//
//  Created by Анохин Юрий on 06.11.2022.
//

import UIKit
import SwiftUI

class ShareViewController: UIViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        for item in extensionContext!.inputItems as! [NSExtensionItem] {
            if let attachments = item.attachments {
                for itemProvider in attachments {
                    if itemProvider.hasItemConformingToTypeIdentifier("public.url") {
                        itemProvider.loadItem(forTypeIdentifier: "public.url", options: nil, completionHandler: { (item, error) in
                            let url = (item as! NSURL).absoluteURL!
                            let urlscheme = URL(string: "sileo://source/\(url)")
                            
                            self.open(url: urlscheme!)
                            self.extensionContext!.completeRequest(returningItems: nil, completionHandler: nil)
                        })
                    }
                }
            }
        }
    }
    
    private func open(url: URL) {
        var responder: UIResponder? = self as UIResponder
        let selector = #selector(openURL(_:))
        
        while responder != nil {
            if responder!.responds(to: selector) && responder != self {
                responder!.perform(selector, with: url)
                
                return
            }
            
            responder = responder?.next
        }
    }
    
    @objc
    private func openURL(_ url: URL) {
        return
    }
}
