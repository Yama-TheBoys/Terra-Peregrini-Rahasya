//
//  String.swift
//  Terra-Peregrini-Rahasya
//
//  Created by Daffashiddiq on 09/07/24.
//

import Foundation

extension String {
    func randomString(length: Int) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
}
