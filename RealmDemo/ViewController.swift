//
//  ViewController.swift
//  RealmDemo
//
//  Created by David Mills on 2019-05-23.
//  Copyright © 2019 David Mills. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!
  var people = [Person]()
  var realm : Realm!

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.

    realm = try! Realm();

    reloadPeople()
  }

  func reloadPeople() {
    let results = realm.objects(Person.self)
    var people = [Person]()

    for person in results {
      people.append(person)
    }

    self.people = people

    tableView.reloadData()
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let identifier = segue.identifier {
      if (identifier == "addPerson") {
        let dvc = segue.destination as! AddPersonViewController
        dvc.delegate = self
      }
    }
  }
}

extension ViewController : AddPersonDelegate {
  func savePerson(name: String) {
    let person = Person()
    person.name = name

    try! realm.write {
      realm.add(person)
    }

    reloadPeople()
  }
}

extension ViewController : UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return people.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

    let person = people[indexPath.row]

    cell.textLabel?.text = person.name

    return cell
  }
}

