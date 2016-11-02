//
//  ViewController.swift
//  Twitter
//
//  Created by Claudiu Andrei on 11/1/16.
//  Copyright © 2016 Claudiu Andrei. All rights reserved.
//

import UIKit

protocol TweetsViewControllerDelegate {
    func newTweet(_ tweet: Tweet)
}

class TweetsViewController: UIViewController {
    
    var tweets = [Tweet]()
    var isLoading = false
    let refreshControl = UIRefreshControl()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 128
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // Load the tweets
        refreshControl.addTarget(self, action: #selector(loadTweets), for: .valueChanged)
        loadTweets()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @objc func loadTweets() {
        isLoading = true
        TwitterAPI.instance?.homeTimeline(maxId: nil, success: {
            (tweets: [Tweet]) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
            self.isLoading = false
        }, failure: {
            (error: Error) -> () in
            self.refreshControl.endRefreshing()
            self.isLoading = false
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as? UINavigationController
        if let navigationViewController = navigationController {
            let tweetViewController = navigationViewController.topViewController as? TweetViewController
            if let viewController = tweetViewController {
                viewController.delegate = self
            }
        }
    }
    
    func newTweet(_ tweet: Tweet) {
        self.tweets.insert(tweet, at: 0)
        tableView.reloadData()
    }
    
    @IBAction func onLogout(_ sender: AnyObject) {
        TwitterAPI.instance?.logout()
    }
}

extension TweetsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetViewCell
        cell.delegate = self
        cell.tweet = tweets[indexPath.row]
        return cell
    }
}

extension TweetsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

