//
//  Song.swift
//  Playlist39
//
//  Created by Maxwell Poffenbarger on 4/19/21.
//

import Foundation

class Song: Codable {
    
    let songTitle: String
    let artist: String
    let uuid: String
    
    init(songTitle: String, artist: String, uuid: String = UUID().uuidString) {
        self.songTitle = songTitle
        self.artist = artist
        self.uuid = uuid
    }
}//End of class

//MARK: - Extensions
extension Song: Equatable {
    static func == (lhs: Song, rhs: Song) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}//End of extension
