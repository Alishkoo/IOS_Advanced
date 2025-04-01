//
//  ErrorModel.swift
//  ConcurrencyTask
//
//  Created by Alibek Baisholanov on 01.04.2025.
//

import Foundation

struct ErrorMessage: Identifiable {
    let id = UUID() // Уникальный идентификатор
    var message: String
}
