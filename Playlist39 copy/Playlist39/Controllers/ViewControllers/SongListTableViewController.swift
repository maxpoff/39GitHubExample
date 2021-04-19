//
//  SongListTableViewController.swift
//  Playlist39
//
//  Created by Maxwell Poffenbarger on 4/19/21.
//

import UIKit

class SongListTableViewController: UITableViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var songTitleTextField: UITextField!
    @IBOutlet weak var artistTextField: UITextField!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SongController.sharedInstance.loadFromPersistenceStore()
    }
    
    //MARK: - Actions
    @IBAction func addSongButtonTapped(_ sender: Any) {
        
        guard let songTitle = songTitleTextField.text,!songTitle.isEmpty,
              let artist = artistTextField.text, !artist.isEmpty else {return}
        
        SongController.sharedInstance.createSong(songTitle: songTitle, artist: artist)
        tableView.reloadData()
        songTitleTextField.text = ""
        artistTextField.text = ""
        songTitleTextField.becomeFirstResponder()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SongController.sharedInstance.songs.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath)

        let song = SongController.sharedInstance.songs[indexPath.row]
        
        cell.textLabel?.text = song.songTitle
        cell.detailTextLabel?.text = song.artist

        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let songToDelete = SongController.sharedInstance.songs[indexPath.row]
            
            SongController.sharedInstance.deleteSong(song: songToDelete)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}//End of class
