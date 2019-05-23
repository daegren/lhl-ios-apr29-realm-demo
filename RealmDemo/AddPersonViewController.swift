//
//  AddPersonViewController.swift
//  RealmDemo
//
//  Created by David Mills on 2019-05-23.
//  Copyright © 2019 David Mills. All rights reserved.
//

import UIKit

protocol AddPersonDelegate {
  func savePerson(name: String)
}

class AddPersonViewController: UIViewController {

  @IBOutlet weak var textField: UITextField!
  var delegate : AddPersonDelegate?

  override func viewDidLoad() {
      super.viewDidLoad()
      // Do any additional setup after loading the view.
  }

  @IBAction func cancel(_ sender: Any) {
    self.dismiss(animated: true, completion: nil)
  }

  @IBAction func save(_ sender: Any) {
    if let name = textField.text,
      let delegate = self.delegate,
      name != "" {
      delegate.savePerson(name: name)
      self.dismiss(animated: true, completion: nil)
    } else {
      let alert = UIAlertController(title: "Invalid Person", message: "Please add a name for the person to add", preferredStyle: .alert)
      let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
      alert.addAction(action)
      self.present(alert, animated: true, completion: nil)
    }
  }
}
