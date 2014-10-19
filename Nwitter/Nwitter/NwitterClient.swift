//
//  NwitterClient.swift
//  Nwitter
//
//  Created by Ishmeet Singh on 10/9/14.
//  Copyright (c) 2014 iSingh. All rights reserved.
//

import UIKit

let twitterConsumerKey = "5qgxqlaCNdrRtNdNlwt9KCohB"
let twitterConsumerSecret = "eAzenhX1ebIpnUL7KNhrinrlIRri96zo0Fn098OfFqkHn1pgN5"
let twitterBaseURL = NSURL(string: "https://api.twitter.com")

class NwitterClient: BDBOAuth1RequestOperationManager {
    var loginCompletion: ((user: User?, error: NSError?) -> ())?
    class var sharedInstance : NwitterClient {
        struct Static {
            static let instance = NwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
            return Static.instance
    }
    
    func homeTimelineWithParams(params: NSDictionary?, completion: (tweets: [Tweet]?, error: NSError?) -> ()) {
        GET("1.1/statuses/home_timeline.json", parameters: params
            , success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                var tweets = Tweet.tweetsWithArray(response as [NSDictionary])
                completion(tweets: tweets, error: nil)
                
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println("Error getting User timeline")
                completion(tweets: nil, error: error)
        })
    }
    
    func loginWithCompletion(completion: (user: User?, error: NSError?) -> ()) {
        loginCompletion = completion
        NwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        NwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "lunariallc://oauth"), scope: nil, success: { (requestToken: BDBOAuthToken!) -> Void in
            println("Got the request token: \(requestToken)")
            var authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
            UIApplication.sharedApplication().openURL(authURL)
        }) { (error: NSError!) -> Void in
            println("Failed to get request token")
            self.loginCompletion?(user: nil, error: error)
            
        }
    }
    
    func openURL(url: NSURL) {
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuthToken (queryString: url.query), success: { (accessToken: BDBOAuthToken!) -> Void in
            println("Got the access token")
            NwitterClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)
            
                NwitterClient.sharedInstance.GET("1.1/account/verify_credentials.json", parameters: nil, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                    var user = User(dictionary: response as NSDictionary)
                    println("User: \(user.name)")
                    User.currentUser = user
                    self.loginCompletion?(user: user, error: nil)
                    }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                        println("Error getting current user")
                        self.loginCompletion?(user: nil, error: error)
                })
            
            }) { (error: NSError!) -> Void in
                println("Failed to receive access token")
                self.loginCompletion?(user: nil, error: error)
        }

    }
    
    func postTweet(params: NSDictionary?, completion: (tweet: Tweet?, error: NSError?) -> ()) {
        POST("1.1/statuses/update.json", parameters: params, success: { (operation: AFHTTPRequestOperation!, response:AnyObject!) -> Void in
            println("Tweet posted!")
            //completion block -> pop the ComposeViewController
            var posted = Tweet(dictionary: response as NSDictionary)
            completion(tweet: posted, error: nil)
            
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println("Tweet not posted")
                //Show Error in ComposeViewController?
                completion(tweet: nil, error: error)
        })
    }
}
