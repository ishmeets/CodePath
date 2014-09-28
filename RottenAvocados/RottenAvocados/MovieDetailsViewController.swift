//
//  MovieDetailsViewController.swift
//  RottenAvocados
//
//  Created by Ishmeet Singh on 9/24/14.
//  Copyright (c) 2014 iSingh. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var movieDetailsScrollView: UIScrollView!
    @IBOutlet weak var movieDetailsView: UIView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieScoreLabel: UILabel!
    @IBOutlet weak var movieRatingLabel: UILabel!
    @IBOutlet weak var movieDetailsLabel: UILabel!
    @IBOutlet weak var networkErrorView: UIView!
    var movieId: String!
    var moviePosters = [String: UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        var hud = MBProgressHUD.showHUDAddedTo(moviePosterImageView, animated: true)
        hud.labelText = "Loading"
        
        var movieDetailsUrl = "http://api.rottentomatoes.com/api/public/v1.0/movies/" + movieId + ".json?apikey=5pv9wp8k4k7veqzfyn4dtnxf"
        var movieDetailsRequest = NSURLRequest(URL: NSURL(string: movieDetailsUrl))
        NSURLConnection.sendAsynchronousRequest(movieDetailsRequest, queue: NSOperationQueue.mainQueue()) {
            (response: NSURLResponse!, data, error) -> Void in
            if error == nil {
                var movieDetailsObject = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as NSDictionary
                var movieTitle = movieDetailsObject["title"] as String
                var movieRatings = movieDetailsObject["ratings"] as NSDictionary
                var movieCriticsScore = movieRatings["critics_score"] as Int
                var movieAudienceScore = movieRatings["audience_score"] as Int
                var movieRating = movieDetailsObject["mpaa_rating"] as String
                var movieSynopsis = movieDetailsObject["synopsis"] as String
                var moviePosters = movieDetailsObject["posters"] as NSDictionary
                var movieThumbnailPoster = moviePosters["original"] as String
                var movieOriginalPoster = movieThumbnailPoster.stringByReplacingOccurrencesOfString("_tmb.jpg", withString: "_org.jpg", options: NSStringCompareOptions.LiteralSearch, range: nil)
                
                if moviePosters[movieOriginalPoster] == nil {
                    var posterRequest = NSURLRequest(URL: NSURL(string: movieOriginalPoster))
                    NSURLConnection.sendAsynchronousRequest(posterRequest, queue: NSOperationQueue.mainQueue()) {
                        (response: NSURLResponse!, data, error) -> Void in
                        var moviePosterImage = UIImage(data: data)
                        self.moviePosters[movieOriginalPoster] = moviePosterImage
                    }
                    self.moviePosterImageView.setImageWithURL(NSURL(string: movieOriginalPoster))
                } else {
                    self.moviePosterImageView.image = self.moviePosters[movieOriginalPoster]
                }
                self.movieTitleLabel.text = movieTitle
                self.movieScoreLabel.text = "Critics Score: " + String(movieCriticsScore) + ", Audience Score: " + String(movieAudienceScore)
                self.movieRatingLabel.text = movieRating
                self.movieDetailsLabel.text = movieSynopsis
                self.movieDetailsLabel.sizeToFit()
                self.movieDetailsView.frame.size.height  = CGRectGetMaxY(self.movieDetailsView.frame)
                self.movieDetailsScrollView.contentSize = CGSizeMake(self.movieDetailsScrollView.frame.width, CGRectGetMaxY(self.movieDetailsView.frame))
            } else {
                self.throwNetworkError()
            }
        }
        MBProgressHUD.hideAllHUDsForView(moviePosterImageView, animated: true)
    }
    
    func throwNetworkError() {
        self.networkErrorView.hidden = false
        self.networkErrorView.alpha = 0
        UIView.animateWithDuration(3, animations: { self.networkErrorView.alpha = 1 })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
