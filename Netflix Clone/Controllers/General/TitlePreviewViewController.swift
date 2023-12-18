//
//  TitlePreviewViewController.swift
//  Netflix Clone
//
//  Created by Hakan Türkmen on 18.12.2023.
//

import UIKit
import WebKit


class TitlePreviewViewController: UIViewController {

    let titleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .bold)
        return label
    }()
    
    let webView : WKWebView = {
       
        let webview = WKWebView()
        webview.translatesAutoresizingMaskIntoConstraints=false
        return webview
    }()
    
    
    let overViewLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    let downloadButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red
        button.setTitle("Download", for: .normal)
        button.layer.cornerRadius  = 15
        button.layer.masksToBounds = true;
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        view.addSubview(webView)
        view.addSubview(overViewLabel)
        view.addSubview(titleLabel)
        view.addSubview(downloadButton)

        configureConstraints()
        // Do any additional setup after loading the view.
    }
    
    
    func configureConstraints() {
            let webViewConstraints = [
                webView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
                webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                webView.heightAnchor.constraint(equalToConstant: 300)
            ]
            
            let titleLabelConstraints = [
                titleLabel.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: 20),
                titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            ]
            
            let overviewLabelConstraints = [
                overViewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
                overViewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                overViewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ]
            
            let downloadButtonConstraints = [
                downloadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                downloadButton.topAnchor.constraint(equalTo: overViewLabel.bottomAnchor, constant: 25),
                downloadButton.widthAnchor.constraint(equalToConstant: 140),
                downloadButton.heightAnchor.constraint(equalToConstant: 40)
            ]
            
            NSLayoutConstraint.activate(webViewConstraints)
            NSLayoutConstraint.activate(titleLabelConstraints)
            NSLayoutConstraint.activate(overviewLabelConstraints)
            NSLayoutConstraint.activate(downloadButtonConstraints)
            
        }
    
    func configure(with model: TitlePreviewViewModel)
    {
        titleLabel.text = model.title
        overViewLabel.text = model.titleOverview
        
        guard let url = URL(string: "https://www.youtube.com/embed/\(model.youtubeVideo.id.videoId)") else { return }
        webView.load(URLRequest(url: url))

    }
    }
    

