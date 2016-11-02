//
//  TweetViewController.swift
//  Twitter
//
//  Created by Claudiu Andrei on 11/1/16.
//  Copyright © 2016 Claudiu Andrei. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController {
    
    weak var delegate: TweetsViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension TweetViewController: TweetsViewControllerDelegate {
    
    func newTweet(_ tweet: Tweet) {
        delegate?.newTweet(tweet)
    }
    
}
