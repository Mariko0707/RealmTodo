//
//  Todo.swift
//  RealmTodo
//
//  Created by Suzuki Mariko on 30/07/2019.
//  Copyright © 2019 Mariko. All rights reserved.
//

import RealmSwift

class Todo: Object {
    
    // ID (連番)
    @objc dynamic var id: Int = 0
    
    // タイトル
    @objc dynamic var title: String = ""
    
    // 登録日時
    @objc dynamic var date: Date = Date()
}
