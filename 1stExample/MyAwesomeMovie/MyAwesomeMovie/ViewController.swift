//
//  ViewController.swift
//  MyAwesomeMovie
//
//  Created by mac on 7/20/19.
//  Copyright © 2019 Bui Quang Tri. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nowPlayingTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? TableViewCell else {
            fatalError()
        }
        return cell
    }
    
}

