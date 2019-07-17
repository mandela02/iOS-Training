//
//  ViewController.swift
//  TableAndCollection
//
//  Created by mac on 7/11/19.
//  Copyright © 2019 WayneEnterprise. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var name = [HeroName("Batman", "Bruce Wayne"), HeroName("Superman", "Clark Kent"), HeroName("Wonder Woman", "Diana Prince")]

    @IBOutlet weak var mTableView: UITableView!
    @IBOutlet weak var mCollectionView: UICollectionView!
    
    var isGrid = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        mCollectionView.isHidden = true
        mTableView.delegate = self
        mTableView.dataSource = self
        mCollectionView.delegate = self
        mCollectionView.dataSource = self
    }
    
    
    @IBAction func changTypeButton(_ sender: UIBarButtonItem) {
        if isGrid == false
        {
            mCollectionView.isHidden = false
            mTableView.isHidden = true
        }
        else if isGrid == true
        {
            mCollectionView.isHidden = true
            mTableView.isHidden = false
        }
        isGrid = !isGrid
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return name.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        cell.mRedLabel.text = name[indexPath.row].heroName
        cell.mBlueLabel.text = name[indexPath.row].realName
        return cell
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return name.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = mCollectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        cell.redLayout.text = name[indexPath.item].heroName
        cell.blueLayout.text = name[indexPath.item].realName
        return cell
    }
}


