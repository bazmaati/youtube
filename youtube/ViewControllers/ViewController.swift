//
//  ViewController.swift
//  youtube
//
//  Created by Barry Flanigan on 21/06/2020.
//  Copyright © 2020 Barry Flanigan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ModelDelegate {
        
    @IBOutlet weak var tableView: UITableView!
    
    var model = Model()
    var videos = [Video]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // set itself as the datasource
        tableView.dataSource = self
        tableView.delegate = self
        
        // set itself as the delegate
        model.delegate = self
        
        model.getVideos()

    }
    
    // MARK: - Model delegates
    
    func videosFetched(_ videos: [Video]) {
        
        // set the returned videos to the video property
        self.videos = videos
        
        // refresh the tableview
        tableView.reloadData()
    }
    
    // MARK: - TableView Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.VIDEOCELL_ID, for: indexPath) as! VideoTableViewCell
        
        // configure the cell with the data
        let video = self.videos[indexPath.row]
        
        cell.setCell(video)
        
        // return the cell back to the data for displaying
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

}

