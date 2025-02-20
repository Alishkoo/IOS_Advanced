//
//  UserProfileViewController.swift
//  MemoryManagmentUIKit
//
//  Created by Alibek Baisholanov on 20.02.2025.
//

import Foundation
import UIKit

class UserProfileViewController: UIViewController, ProfileUpdateDelegate {
    
    var profileManager: ProfileManager?
    //тут должен профайл менеджера держать сильной ссылкой потому что если они оба будут со слабой то профайл менеджер исчезнет сразу после инициализации
    //тоесть вью контроллер должен держать менеджера сильной ссылкой потому что без него вью контроллер не будет работать
    // а вот менеджер держит слабой ссылкой вью контроллер ибо если он удалится то он больше не нужен в памяти
    // получается если исчезнет вью контроллер просто делегат у менеджера станет nil и все
    // чисто для себя менеджер робот, вью контроллер пульт который работает с ним
    
    var imageLoader: ImageLoader?
    
    var profileImageView: UIImageView!
    var usernameLabel: UILabel!
    var bioLabel: UILabel!
    var followersLabel: UILabel!
    var updateButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupProfileManager()
    }
    
    func setupUI() {
        view.backgroundColor = .white
        
        profileImageView = UIImageView()
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(profileImageView)
        
        usernameLabel = UILabel()
        usernameLabel.font = .systemFont(ofSize: 24, weight: .bold)
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(usernameLabel)
        
        bioLabel = UILabel()
        bioLabel.font = .systemFont(ofSize: 16)
        bioLabel.numberOfLines = 0
        bioLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bioLabel)
        
        followersLabel = UILabel()
        followersLabel.font = .systemFont(ofSize: 14)
        followersLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(followersLabel)
        
        updateButton = UIButton(type: .system)
        updateButton.setTitle("Update Profile", for: .normal)
        updateButton.addTarget(self, action: #selector(updateProfile), for: .touchUpInside)
        updateButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(updateButton)
        
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 100),
            profileImageView.heightAnchor.constraint(equalToConstant: 100),
            
            usernameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 20),
            usernameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            bioLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 10),
            bioLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            followersLabel.topAnchor.constraint(equalTo: bioLabel.bottomAnchor, constant: 10),
            followersLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            updateButton.topAnchor.constraint(equalTo: followersLabel.bottomAnchor, constant: 20),
            updateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func setupProfileManager() {
        profileManager = ProfileManager(delegate: self)
        profileManager?.activeProfiles["1"] = UserProfile(id: UUID(), username: "Alibek", bio: "iOS Developer", followers: 100)
        profileManager?.activeProfiles["2"] = UserProfile(id: UUID(), username: "Nurken", bio: "Swift Enthusiast", followers: 200)
        profileManager?.activeProfiles["3"] = UserProfile(id: UUID(), username: "Kamila", bio: "SwiftUI Enthusiast", followers: 300)
        profileManager?.loadProfile(id: "1") { [weak self] result in
            switch result {
            case .success(let profile):
                self?.updateUI(with: profile)
            case .failure(let error):
                print("Error loading profile: \(error.localizedDescription)")
            }
        }
    }
    
    func updateUI(with profile: UserProfile) {
           usernameLabel.text = profile.username
           bioLabel.text = profile.bio
           followersLabel.text = "Followers: \(profile.followers)"
           loadImage()
    }
    
    @objc func updateProfile() {
        loadImage()
       
        profileManager?.loadProfile(id: String(Int.random(in: 1...3))) { [weak self] result in
            switch result {
            case .success(let profile):
                self?.updateUI(with: profile)
            case .failure(let error):
                print("Error loading profile: \(error.localizedDescription)")
            }
        }
        
    }
    
    func loadImage() {
        imageLoader = ImageLoader()
        imageLoader?.delegate = self
        imageLoader?.loadImage(url: URL(string: "https://via.assets.so/game.png?id=1&q=95&w=360&h=360&fit=fill")!)
    }
    
    
    
    
    func profileDidUpdate(_ profile: UserProfile) {
        updateUI(with: profile)
    }
    
    func profileLoadingError(_ error: Error) {
        print("Error loading profile: \(error.localizedDescription)")
    }
}


extension UserProfileViewController: ImageLoaderDelegate {
    func imageLoader(_ loader: ImageLoader, didLoad image: UIImage) {
        profileImageView.image = image
    }

    func imageLoader(_ loader: ImageLoader, didFailWith error: Error) {
        print("Error loading image: \(error.localizedDescription)")
    }
}
