//
//  DataViewController.swift
//  PryanikiTestTask
//
//  Created by Valeriy Trusov on 26.05.2022.
//

import UIKit

class DataViewController: UIViewController {

    var viewModel: DataViewModelType?
    var cellId = "cellId"
    var tableview: UITableView!
    
    let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.color = .white
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Objects"
        
        setupView()
        activityIndicator.startAnimating()
        loadDataForView()
    }
    
    func setupView() {
        
        let tableview = UITableView()
        tableview.delegate = self
        tableview.dataSource = self
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.register(DataCell.self, forCellReuseIdentifier: cellId)
        tableview.backgroundColor = .tintColor
        
        self.view.addSubview(tableview)
        self.view.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
        
            tableview.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableview.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableview.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableview.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            activityIndicator.widthAnchor.constraint(equalToConstant: 50),
            activityIndicator.heightAnchor.constraint(equalToConstant: 50)
        ])
        self.tableview = tableview
    }

    func loadDataForView() {
        
        DispatchQueue.global().async {
            
            DataViewModel.loadJSONData { [weak self] dataViewModel in
                
                if let dataViewModel = dataViewModel {
                    self?.viewModel = dataViewModel
                    
                    DispatchQueue.main.async {
                        self?.activityIndicator.stopAnimating()
                        self?.tableview.reloadData()
                    }
                }
            }
        }
    }
}


extension DataViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let detailViewModel = viewModel?.createDataDetailModelFrom(index: indexPath.row) {
            let vc = DetailViewController()
            vc.viewModel = detailViewModel
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension DataViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! DataCell
        
        if let dataModel = viewModel?.dataModelFrom(index: indexPath.row) {
            
            cell.configure(dataModel: dataModel)
        }
        
        return cell
    }
}
