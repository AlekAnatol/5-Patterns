//
//  ServiceVKProxy.swift
//  Some New Network
//
//  Created by Екатерина Алексеева on 12.07.2022.
//

import Foundation

protocol ServiceVKProtocol {
    func loadData(method: ApiMethods) -> ()
    func loadPhotos() -> ()
}

class ServiceVKProxy: ServiceVKProtocol {
    let serviceVK = ServiceVK()
//    init(calculator: CalculatorInterface) {
//    self.calculator = calculator }
    
    func loadData(method: ApiMethods) {
        serviceVK.loadData(method: method)
        switch method {
        case .myGroupsGet:
            print("Загружаем: Мои группы")
        case .cookingGroupsGet:
            print("Загружаем: Остальные группы")
        case .friendsGet:
            print("Загружаем: Мои друзья")
        default:
            print("Другой запрос")
        }
    }
    
    func loadPhotos() -> () {
        serviceVK.loadPhotos()
        print("Загружаем: Фотогафии")
    }
}
