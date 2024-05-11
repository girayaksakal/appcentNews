//
//  WebView.swift
//  appcentNews
//
//  Created by Giray Aksakal on 11.05.2024.
//

import SwiftUI
import SafariServices

struct WebView: UIViewControllerRepresentable {
    let url: URL
    
    func makeUIViewController(context: Context) -> some UIViewController {
        SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}
