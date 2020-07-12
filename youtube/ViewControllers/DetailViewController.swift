//
//  DetailViewController.swift
//  youtube
//
//  Created by Barry Flanigan on 28/06/2020.
//  Copyright © 2020 Barry Flanigan. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var textView: UITextView!
    
    var video:Video?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        // clear the fields
        titleLabel.text = ""
        dateLabel.text = ""
        textView.text = ""
        
        
        // check if there is a video
        guard video != nil else {
            return
        }
        
        // create the embed URL
        
        let embedUrl = Constants.YT_EMBED_URL + video!.videoId
        
        // load it into the webview
        let url = URL(string: embedUrl)
        let request = URLRequest(url: url!)
        webView.load(request)
        
        // set the title
        titleLabel.text = video!.title
        
        // set the date
        let df = DateFormatter()
        df.dateFormat = "EEEE, MMM d, yyyy"
        dateLabel.text = df.string(from: video!.published)
        
        // set the description
        textView.text = video!.description
        
        
        
    }
    


}
