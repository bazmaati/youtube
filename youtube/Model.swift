//
//  Model.swift
//  youtube
//
//  Created by Barry Flanigan on 22/06/2020.
//  Copyright © 2020 Barry Flanigan. All rights reserved.
//

import Foundation

protocol ModelDelegate {
    
    func videosFetched(_ videos:[Video])
}

class Model {
    
    var delegate:ModelDelegate?
    
    func getVideos () {
   
        // get a url object
        let url = URL(string: Constants.API_URL)
        
        guard url != nil else {
            return
        }
        
        // get a url session object
        
        let session = URLSession.shared
        
        // get a data task from the url session object
        
        let dataTask = session.dataTask(with: url!) { (data, response, error)
            in
            
            // check if there were any errors
            if error != nil || data == nil {
                return
            }
            
            
            do {
                
                // parsing the data into video objects
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601 // this data is for teh date time format so it will know
                
                // already checked it's not nil, so can unwrap
                let response = try decoder.decode(Response.self, from: data!)
                
                if response.items != nil {
                    
                    // throw the data from background threading to the front
                    DispatchQueue.main.async {
                        // call the "videosReturnedDelegate" method of the delegate
                        self.delegate?.videosFetched(response.items!)
                    }
                    
                
                }
                
                dump(response)
                
            }
            
            catch {
                
            }
        
        }
        
        // kick off the task
        dataTask.resume()
        
        
    }
    
}
