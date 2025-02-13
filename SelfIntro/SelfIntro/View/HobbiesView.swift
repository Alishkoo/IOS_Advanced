//
//  HobbiesView.swift
//  SelfIntro
//
//  Created by Alibek Baisholanov on 12.02.2025.
//
import SwiftUI
import AVFoundation

struct HobbiesView: View {
    let books = ["1984", "Brave New World", "Fahrenheit 451", "The Hobbit"]
    let songs = [
        ("Chihiro", "Chihiro.mp3"),
        ("Sweater Weather", "Sweater Weather.mp3"),
        ("Am I Dreaming?", "Metro Boomin, A$AP Rocky, Roisee - Am I Dreaming.mp3")
    ]
    
    @State private var audioPlayer: AVPlayer?
    @State private var currentlyPlaying: String?

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Books")) {
                    ForEach(books, id: \.self) { book in
                        Text(book)
                    }
                }
                
                Section(header: Text("Songs")) {
                    ForEach(songs, id: \.1) { song in
                        HStack {
                            Text(song.0)
                            Spacer()
                            Button(action: {
                                playSong(named: song.1)
                            }) {
                                Image(systemName: currentlyPlaying == song.1 ? "stop.circle.fill" : "play.circle.fill")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Hobbies")
        }
    }
    
    func playSong(named songName: String) {
        if currentlyPlaying == songName {
            audioPlayer?.pause()
            currentlyPlaying = nil
        } else {
            if let url = Bundle.main.url(forResource: songName, withExtension: nil) {
                audioPlayer = AVPlayer(url: url)
                audioPlayer?.play()
                currentlyPlaying = songName
            } else {
                print("Ошибка: не найден файл \(songName)")
            }
        }
    }
}


#Preview {
    HobbiesView()
}
