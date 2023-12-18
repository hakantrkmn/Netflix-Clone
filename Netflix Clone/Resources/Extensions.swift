//
//  Extensions.swift
//  Netflix Clone
//
//  Created by Hakan Türkmen on 17.12.2023.
//

import Foundation


extension String {
    func capitalizeFirstLetter()-> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
