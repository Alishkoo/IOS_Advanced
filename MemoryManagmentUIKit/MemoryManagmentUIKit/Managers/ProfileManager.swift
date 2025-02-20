//
//  ProfileManager.swift
//  MemoryManagmentUIKit
//
//  Created by Alibek Baisholanov on 20.02.2025.
//

import Foundation

// еще struct enum, хранятся в стеке тоесть копируются
// а вот классы в куче и управляется ARC

// weak это свойство только для classов поэтому нам нужно присвоить протоколу anyobject
protocol ProfileUpdateDelegate: AnyObject {
    func profileDidUpdate(_ profile: UserProfile)
    func profileLoadingError(_ error: Error)
}


class ProfileManager {
    var activeProfiles: [String: UserProfile]
    weak var delegate: ProfileUpdateDelegate? // нужна слабая ссылка так как profileManagerу не всегда нужен делегат для существования
    var onProfileUpdate: ((UserProfile) -> Void)?
    
    init(delegate: ProfileUpdateDelegate? = nil) {
            self.delegate = delegate
        self.activeProfiles = [:]
    }
    
    func loadProfile(id: String, completion: @escaping (Result<UserProfile, Error>) -> Void){
        
        //тут тоесть задачи стоят в очереди
        //к примеру первая задача пришла она и первая выполнилась
        //и мы можем присылать задачи по разному к примеру, DispatchQueue в нем есть global и main
        //main основной поток в котором выполняются обычно там updateUI
        //global это background поток в котором выполняются второстепенные задачи к примеру api запросы
        
        DispatchQueue.global().async {
            // Симуляция задержки загрузки профиля
            sleep(1)
            
            if let profile = self.activeProfiles[id] {
                DispatchQueue.main.async {
                    completion(.success(profile))
                    self.delegate?.profileDidUpdate(profile)
                    self.onProfileUpdate?(profile)
                }
            } else {
                let error = NSError(domain: "ProfileError", code: 404, userInfo: [NSLocalizedDescriptionKey: "Profile not found"])
                DispatchQueue.main.async {
                    completion(.failure(error))
                    self.delegate?.profileLoadingError(error)
                }
            }
        }
    }
    
    func updateProfile(_ profile: UserProfile){
        activeProfiles[profile.id.uuidString] = profile
        onProfileUpdate?(profile)
        delegate?.profileDidUpdate(profile)
        
        
    }
}
