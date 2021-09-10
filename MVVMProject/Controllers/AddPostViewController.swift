//
//  AddPostViewController.swift
//  MVVMProject
//
//  Created by Yakup Demir on 17.07.2021.
//

import UIKit

class AddPostViewController: UIViewController {
    
    @IBOutlet weak var userIdTextField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userIdTextField.becomeFirstResponder()
        titleTextField.becomeFirstResponder()
        bodyTextField.becomeFirstResponder()
        userIdTextField.delegate = self
        titleTextField.delegate = self
        bodyTextField.delegate = self
        
        // Boş alana tıklandığı zaman klavyenin kapanmasını sağlar
        let tap = UITapGestureRecognizer(target: self, action: #selector(AddPostViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    @IBAction func saveClicked(_ sender: Any) {
        postData()
        titleTextField.resignFirstResponder()
        bodyTextField.resignFirstResponder()
    }
    
    private func postData() {
        var postModelParameters = PostModel()
        
        postModelParameters.userId = Int(userIdTextField.text ?? "1")
        postModelParameters.title = titleTextField.text
        postModelParameters.body = bodyTextField.text
        
        PostModelService.instance.postModelData(postModelParameters: postModelParameters) { response in
            if response.title == "" || response.body == "" || response.userId == nil {
                Utility.instance.makeAlert(title: "Hata", message: "Lütfen formu kontrol Ediniz!", uiViewController: self)
            }else{
                Utility.instance.makeAlert(title: "Başarılı", message: "Kaydetme işlemi başarılı", uiViewController: self)
            }
        }
    }
}

extension AddPostViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}
