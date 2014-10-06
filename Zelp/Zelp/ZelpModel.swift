//
//  ZelpModel.swift
//  Zelp
//
//  Created by Ishmeet Singh on 10/4/14.
//  Copyright (c) 2014 iSingh. All rights reserved.
//

import Foundation

class ZelpModel {
    let yelpConsumerKey = "fCIV9Uaan-cAhsg-bdy7dg"
    let yelpConsumerSecret = "GUc5rlYr-bFVfRkwsBTAlxm2WC4"
    let yelpToken = "pWradAQzSCG1x-6XSuQoLxJ-nWSnUEpi"
    let yelpTokenSecret = "4djjybQLtZH2_UKvO3C3VywkIIY"
    
    var restaurantList: [Restaurant] = [Restaurant]()
    
    struct Restaurant {
        var id: String
        var name: String
        var phone: String
        var imageURL: String
        var location: NSDictionary
        var address: [String]
        var streetAddress: String
        var city: String
        var state: String
        var zipcode: String
        var rating: Double
        var ratingImageURL: String
        var reviewCount: Int
        
        init(restaurant: NSDictionary) {
            self.id = restaurant["id"] as String
            self.name = restaurant["name"] as String
            self.phone = restaurant["display_phone"] as String
            self.imageURL = restaurant["image_url"] as String
            self.location = restaurant["location"] as NSDictionary
            println("\(location)")
            self.address = location["address"] as [String]
            self.streetAddress = address[0]
            self.city = location["city"] as String
            self.state = location["state_code"] as String
            self.zipcode = location["postal_code"] as String
            self.rating = restaurant["rating"] as Double
            self.ratingImageURL = restaurant["rating_img_url"] as String
            self.reviewCount = restaurant["review_count"] as Int
        }
    }
    

    func getRestaurantList(searchTerm: String, done: (restaurants: [Restaurant], error: NSError?) -> Void) {
        if searchTerm.isEmpty {
            println("Search Field Empty")
        } else {
            var restaurants: AnyObject?
            var yelpClient = YelpClient(consumerKey: yelpConsumerKey, consumerSecret: yelpConsumerSecret, accessToken: yelpToken, accessSecret: yelpTokenSecret)
            
            yelpClient.searchWithTerm(searchTerm as String, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                restaurants = response["businesses"] as NSArray
                for restaurant in (restaurants as NSArray) {
                    self.restaurantList.append(Restaurant(restaurant: restaurant as NSDictionary))
                }
                done(restaurants: self.restaurantList, error: nil)
                }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                    println("No response!")
            }
        }
    }
}
