//
//  SongController.swift
//  Playlist39
//
//  Created by Maxwell Poffenbarger on 4/19/21.
//

import Foundation

class SongController {
    
    //MARK: - Properties
    //A sharedInstance lets you access the same songController in memory, every time (read and write)
    //Global access to your functions on the controller
    static let sharedInstance = SongController()

    var songs: [Song] = []
    
    //MARK: - CRUD Functions
    //Create, Read, Update, Delete
    
    func createSong(songTitle: String, artist: String) {
        
        let newSong = Song(songTitle: songTitle, artist: artist)
        
        songs.append(newSong)
        
        saveToPersistenceStore()
    }
    
    func deleteSong(song: Song) {
        
        guard let index = songs.firstIndex(of: song) else {return}
        
        songs.remove(at: index)
        
        //GavinC is the coolest person I know
        saveToPersistenceStore()
    }
    
    //MARK: - Persistence
    func createPersistenceStore() -> URL {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = url[0].appendingPathComponent("Playlist.json")
        return fileURL
    }
    
    func saveToPersistenceStore() {
        do {
            let data = try JSONEncoder().encode(songs)
            try data.write(to: createPersistenceStore())
        } catch {
            print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
        }
    }
    
    func loadFromPersistenceStore() {
        do {
            let data = try Data(contentsOf: createPersistenceStore())
            songs = try JSONDecoder().decode([Song].self, from: data)
        } catch {
            print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
        }
    }
}//End of class
