//
//  VideoTableViewCell.swift
//  youtube
//
//  Created by Barry Flanigan on 25/06/2020.
//  Copyright © 2020 Barry Flanigan. All rights reserved.
//

import UIKit

class VideoTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    var video:Video?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(_ v:Video) {
        
        self.video = v
        
        // set the title
        self.titleLabel.text = video?.title
        
        // set the date and format
        guard self.video != nil else {
            return
        }
        
        
        // nsdateformatter.com and change the format
        let df = DateFormatter()
        df.dateFormat = "EEEE, MMM d, yyyy"
        self.dateLabel.text = df.string(from: video!.published)
        
        // set the thumbnail
        guard self.video?.thumbnail != "" else {
            return
            
        }
        
        // check the cache before downloading new data
        
        if let cachedData = CacheManager.getVideoCache(self.video!.thumbnail) {
            
            // set the thumbnail image view
            self.thumbnailImageView.image = UIImage(data: cachedData)
            
            
        }
        
        // download the thumbnail over the network
        let url = URL(string: self.video!.thumbnail)
        
        // get the shared URL session object
        let session = URLSession.shared
        
        // create a data task
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            if error == nil && data != nil {
                
                // save the data in the cache
                CacheManager.setVideoCache(url!.absoluteString, data)
                
                // check that the data url matches the video thumbnail
                if url!.absoluteString != self.video?.thumbnail {
                    // video cell has been recycled
                    return
                }
                
                // create the image object
                let image = UIImage(data: data!)
                
                // set the image view
                DispatchQueue.main.async {
                    self.thumbnailImageView.image = image
                }
            }
        }
        
        // start the data task
        dataTask.resume()
        
    }


}
