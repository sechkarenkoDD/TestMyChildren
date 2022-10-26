//
//  ChildViewModel.swift
//  TestMyChildren
//
//  Created by Дмитрий Сечкаренко on 25.10.2022.
//

import Foundation

protocol ChildViewModelProtocol {
    var children: [Children] { get }
    func addChild(child: Children)
    func removeChild(index: Int)
    func removeAll()
}

final class ChildViewModelImpl: ChildViewModelProtocol {

    private(set) var children: [Children] = []

    func addChild(child: Children) {
        children.append(child)
    }

    func removeChild(index: Int) {
        children.remove(at: index)
    }

    func removeAll() {
        children.removeAll()
    }
}
