//
//  SignInWSO.swift
//  Zan-Lab
//
//  Created by Андрей on 24.09.2023.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
}

struct SignInWSO: View {

    var body: some View {
        VStack{
            WebView(url: URL(string: "https://google.com")!)
        }
        .navigationTitle("Вход в систему")
    }
}

struct SignInWSO_Previews: PreviewProvider {
    static var previews: some View {
        SignInWSO()
    }
}
