//
//  DetailViewController.swift
//  MVVMProject
//
//  Created by Yakup Demir on 17.07.2021.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var userIdLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    
    var selectedPostModel = PostModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        idLabel.text = String(selectedPostModel.id ?? 0)
        titleLabel.text = selectedPostModel.title
        bodyLabel.text = selectedPostModel.body
        userIdLabel.text = String(selectedPostModel.userId ?? 0)
    }     
}
