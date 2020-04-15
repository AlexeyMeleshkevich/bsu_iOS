//
//  StartViewController.swift
//  tableSettigins
//
//  Created by Li on 1/6/20.
//  Copyright © 2020 Li. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    var token = Token() {
        didSet {
            DispatchQueue.main.async {
                self.loginTextField.text = ""
                self.passwordTextField.text = ""
                self.loadProfileView()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard(sender:)))
        view.addGestureRecognizer(tap)
    }
    
    @objc func hideKeyboard(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    func loadProfileView() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "tabBarController")
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        let login = Login(login: loginTextField.text ?? "", pass: passwordTextField.text ?? "")
        let api = ApiRequest(endpoint: "api/token/generate-token")
        api.login(login) { (result) in
            switch result {
            case.failure(let error) : print(error)
            case.success(let token) : self.token = token
            }
        }
    }
}
