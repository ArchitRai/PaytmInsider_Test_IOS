//
//  MusicItemCellViewModel.swift
//  InsiderDemoApp
//
//  Created by Archit Rai Saxena on 25/08/20.
//  Copyright © 2020 Archit. All rights reserved.
//

import Foundation

protocol MusicItemRepresentable {
    var artistName :String {get}
    var trackName  :String  {get}
    var previewUrl :URL?   {get}
    var artworkUrl :URL?   {get}
    var trackID    :Int  {get}
    var price:String  {get}
   var  collectionName:String {get}
   var kind:String {get}
   var duration:String {get}
   var releaseDate:String {get}
   var country:String {get}

}


class MusicItemCellViewModel: MusicItemRepresentable {
   
    private var musicItem:MusicItem
    
    init(_ musicItem:MusicItem) {
        
        self.musicItem = musicItem
    }
    
    var artistName: String {
        return self.musicItem.artistName
    }
    
    var trackName: String {
        return self.musicItem.trackName
    }
    
    var previewUrl: URL? {
        return self.musicItem.previewURL
    }
    
    var artworkUrl: URL?{
        return self.musicItem.artworkUrl100
    }
    
    var trackID: Int {
        return self.musicItem.trackID
    }
    
    var  collectionName:String {
     return self.musicItem.collectionName
        
    }
    var kind:String {
    return self.musicItem.kind
        
    }
    var duration:String {
        let sec = self.musicItem.trackTimeMillis/1000
               let min = sec/60
        return "\(min)"
    }
   
    var releaseDate:String {
     return self.musicItem.releaseDate
    }
    var country:String {
     return self.musicItem.country
    }
    
    var price: String{
        
        return "\(self.musicItem.currency )\(self.musicItem.collectionPrice)"
    }
    
    
    
}
