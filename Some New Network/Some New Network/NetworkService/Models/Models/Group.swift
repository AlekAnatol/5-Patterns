//
//  Group.swift
//  Some New Network
//
//  Created by Екатерина Алексеева on 14.01.2022.
//

import UIKit

struct Group: ViewModelProtocol {
    let id:Int
    let name: String
    let isMember: Bool
    let photo: UIImage?
}
