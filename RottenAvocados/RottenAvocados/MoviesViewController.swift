//
//  MoviesViewController.swift
//  RottenAvocados
//
//  Created by Ishmeet Singh on 9/23/14.
//  Copyright (c) 2014 iSingh. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var movies: [NSDictionary] = []
    var refreshControl: UIRefreshControl!
    @IBOutlet weak var networkErrorView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refersh")
        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl)
        
        var moviesUrl = "http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=5pv9wp8k4k7veqzfyn4dtnxf"
        var moviesRequest = NSURLRequest(URL: NSURL(string: moviesUrl))
        NSURLConnection.sendAsynchronousRequest(moviesRequest, queue: NSOperationQueue.mainQueue()) {
            (response: NSURLResponse!, data, error) -> Void in
            if error == nil {
                var moviesObject = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as NSDictionary
                self.movies = moviesObject["movies"] as [NSDictionary]
            
                self.tableView.reloadData()
            } else {
                self.throwNetworkError()
            }
        }
    }

    func refresh(sender:AnyObject)
    {
        // Code to refresh table view
        self.tableView.reloadData()
        self.refreshControl.endRefreshing()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("MovieCell") as MovieCell
        var movie = movies[indexPath.row]
        
        var posters = movie["posters"] as NSDictionary
        var posterURL = posters["thumbnail"] as String
        
        cell.titleLabel.text = movie["title"] as? String
        cell.synopsisLabel.text = movie["synopsis"] as? String
        cell.posterView.setImageWithURL(NSURL(string: posterURL))
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var movie = movies[indexPath.row]
        var movieId = movie["id"] as String
        
        performSegueWithIdentifier("movieDetails", sender: movieId)
    }
    
    func throwNetworkError() {
        self.networkErrorView.hidden = false
        self.networkErrorView.alpha = 0
        UIView.animateWithDuration(3, animations: { self.networkErrorView.alpha = 1 })
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "movieDetails" {
            let MovieDetailsVC = segue.destinationViewController as MovieDetailsViewController
            MovieDetailsVC.movieId = sender as String
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
