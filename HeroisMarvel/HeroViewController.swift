//
//  HeroViewController.swift
//  HeroisMarvel
//
//  Created by Bruno Alves da Silva on 07/07/20.
//  Copyright © 2020 Bruno Alves da Silva. All rights reserved.
//

import UIKit
import WebKit

class HeroViewController: UIViewController {
    
    var hero: Hero!

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Fazendo a requisicao
        let url = URL(string: hero.urls.first!.url)
        let request = URLRequest(url: url!)
        title = hero.name
        
        //Usuario consegue navegar pra cima e pra baixo (sem precisa de botoes)
        webView.allowsBackForwardNavigationGestures = true
        
        webView.navigationDelegate = self
        
        //Pedindo para a webView carregar a requisicao
        webView.load(request)
    }

}

extension HeroViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loading.stopAnimating()
    }
}
