//
//  AddDogViewController.swift
//  RealmDemo
//
//  Created by David Mills on 2019-05-23.
//  Copyright © 2019 David Mills. All rights reserved.
//

import UIKit

protocol AddDogDelegate {
  func saveDog(name: String, age: Int)
}

class AddDogViewController: UIViewController {

  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var ageLabel: UILabel!
  @IBOutlet weak var ageStepper: UIStepper!

  var delegate: AddDogDelegate?

  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.

    self.ageLabel.text = "\(Int(ageStepper.value))"
  }

  @IBAction func stepperChanged(_ sender: Any) {
    self.ageLabel.text = "\(Int(ageStepper.value))"
  }

  @IBAction func save(_ sender: Any) {
    if let name = nameTextField.text,
      let delegate = self.delegate,
      name != "" {
      delegate.saveDog(name: name, age: Int(ageStepper.value))
      self.dismiss(animated: true, completion: nil)
    } else {
      let alert = UIAlertController(title: "Invalid Dog", message: "Please add a name for the dog to add", preferredStyle: .alert)
      let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
      alert.addAction(action)
      self.present(alert, animated: true, completion: nil)
    }
  }

  @IBAction func cancel(_ sender: Any) {
    self.dismiss(animated: true, completion: nil)
  }


  /*
  // MARK: - Navigation

  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      // Get the new view controller using segue.destination.
      // Pass the selected object to the new view controller.
  }
  */

}
