//
//  DetailViewController.swift
//  PryanikiTestTask
//
//  Created by Valeriy Trusov on 26.05.2022.
//

import Foundation
import UIKit


class DetailViewController: UIViewController {
    
    var viewModel: DataDetailViewModel!
    var logoImageView: UIImageView!
    
    var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.navigationItem.title = "Description"
        self.navigationController?.navigationBar.tintColor = .black
        view.backgroundColor = .tintColor
        
        setupView()
        loadImageIfNeeded()
        
    }
    
    func setupView() {
        
        let nameLabel = UILabel.createCustomLabel()
        nameLabel.text = viewModel.name
        nameLabel.textAlignment = .center
        
        let descriptionLabel = UILabel.createCustomLabel()
        descriptionLabel.text = viewModel.description
        descriptionLabel.font = descriptionLabel.font.withSize(15)
        descriptionLabel.textAlignment = .center
        
        self.view.addSubview(nameLabel)
        self.view.addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            
            nameLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            nameLabel.widthAnchor.constraint(equalToConstant: self.view.frame.width / 2),
            nameLabel.heightAnchor.constraint(equalToConstant: 50),
            
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 15),
            descriptionLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            descriptionLabel.widthAnchor.constraint(equalToConstant: self.view.frame.width / 2),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func loadImageIfNeeded() {
        
        guard viewModel.imageURL != nil else { return }
        
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.color = .white
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.startAnimating()
        self.activityIndicator = activityIndicator
        
        
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        self.logoImageView = iv
        
        self.view.addSubview(iv)
        iv.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            
            self.logoImageView.bottomAnchor.constraint(equalTo: self.view.topAnchor, constant: self.view.frame.height / 2 - 50),
            self.logoImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.logoImageView.widthAnchor.constraint(equalToConstant: 200),
            self.logoImageView.heightAnchor.constraint(equalToConstant: 200),
            
            self.activityIndicator.centerXAnchor.constraint(equalTo: iv.centerXAnchor),
            self.activityIndicator.centerYAnchor.constraint(equalTo: iv.centerYAnchor),
            self.activityIndicator.widthAnchor.constraint(equalToConstant: 50),
            self.activityIndicator.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        DispatchQueue.global().async {
            
            self.viewModel.image?.bind(listener: { [weak self] image in
                
                DispatchQueue.main.async {
                    
                    self?.activityIndicator.stopAnimating()
                    
                    if let image = image {
                        
                        self?.logoImageView.image = image
                    }
                }
                
            })
            
            self.viewModel.loadImage()
        }
    }
}
