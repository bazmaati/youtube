//
//  Model.swift
//  youtube
//
//  Created by Barry Flanigan on 22/06/2020.
//  Copyright © 2020 Barry Flanigan. All rights reserved.
//

import Foundation

class Model {
    
    func getVideos () {
        
        // get a url object
        let url = URL(string: Constants.API_URL)
        
        guard url != nil else {
            return
        }
        
        // get a url session object
        
        let session = URLSession.shared
        
        // get a data task from the url session object
        
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            
            // check if there were any errors
            if error != nil || data == nil {
                return
            }
            
            // parsing the data
        }
        
        // kick off the task
        dataTask.resume()
        
        
    }
    
}
