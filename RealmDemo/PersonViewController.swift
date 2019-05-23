//
//  PersonViewController.swift
//  RealmDemo
//
//  Created by David Mills on 2019-05-23.
//  Copyright © 2019 David Mills. All rights reserved.
//

import UIKit
import RealmSwift

class PersonViewController: UIViewController {

  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var dogTableView: UITableView!

  weak var person: Person?

  let realm = try! Realm()

  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.

    if let person = self.person {
      nameLabel.text = person.name
    }

    let barButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addDog))
    self.navigationItem.rightBarButtonItem = barButton
  }

  @objc func addDog() {
    self.performSegue(withIdentifier: "addDog", sender: nil)
  }



  // MARK: - Navigation

  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // Get the new view controller using segue.destination.
    // Pass the selected object to the new view controller.
    if let identifier = segue.identifier {
      if (identifier == "addDog") {
        let dvc = segue.destination as! AddDogViewController
        dvc.delegate = self
      }
    }
  }
}

extension PersonViewController: AddDogDelegate {
  func saveDog(name: String, age: Int) {
    let dog = Dog()
    dog.name = name
    dog.age = age

    if let person = self.person {
      try! realm.write {
        person.dogs.append(dog)
      }
    }

    dogTableView.reloadData()
  }
}

extension PersonViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if let person = self.person {
      return person.dogs.count
    }

    return 0;
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "dogCell", for: indexPath)

    if let person = self.person {
      let dog = person.dogs[indexPath.row]
      cell.textLabel?.text = dog.name
    }

    return cell;
  }
}
