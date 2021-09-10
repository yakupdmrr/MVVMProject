//
//  ViewController.swift
//  MVVMProject
//
//  Created by Yakup Demir on 12.07.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!{
        didSet{
            indicator.hidesWhenStopped = true
        }
    }
    @IBOutlet weak var postModelTableView: UITableView!
    private var postModelListViewModel : PostModelListViewModel!
    private lazy var chosenPostModel = PostModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.refresh, target: self, action: #selector(refreshButtonClicked))
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonClick))
        
        postModelTableView.delegate = self
        postModelTableView.dataSource = self
        
        fecthData()
        
    }
    
    @objc private func refreshButtonClicked(){
        DispatchQueue.main.async{
            self.postModelListViewModel.postModelList.removeAll(keepingCapacity: false)
            self.fecthData()
            self.indicator.stopAnimating()
            self.postModelTableView.reloadData()
        }
    }
    
    @objc private func addButtonClick(){
        performSegue(withIdentifier: "toAddVC", sender: nil)
    }
    
    private func fecthData(){
        indicator.center = self.view.center
        indicator.startAnimating()
        
        PostModelService.instance.getPostModelData { (modelList) in
            self.postModelListViewModel = PostModelListViewModel(postModelList: modelList)
            
            DispatchQueue.main.async {
                self.indicator.stopAnimating()
                self.postModelTableView.reloadData()
            }
        }
    }
}

extension ViewController : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.postModelListViewModel == nil ? 0 : self.postModelListViewModel.numberOfSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = postModelTableView.dequeueReusableCell(withIdentifier: "postModelCell", for: indexPath) as! PostModelTableViewCell
        let postModelView = self.postModelListViewModel.postModelAtIndex(indexPath.row)
        cell.titleLabel.text = postModelView.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.postModelListViewModel.postModelList.remove(at: indexPath.row)
            self.postModelTableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        chosenPostModel = self.postModelListViewModel.postModelList[indexPath.row]
        performSegue(withIdentifier: "DetailVC", sender:nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailVC" {
            let destinationVC = segue.destination as! DetailViewController
            
            destinationVC.selectedPostModel.id = chosenPostModel.id
            destinationVC.selectedPostModel.userId = chosenPostModel.userId
            destinationVC.selectedPostModel.title = chosenPostModel.title
            destinationVC.selectedPostModel.body = chosenPostModel.body
        }
    }
    
}
