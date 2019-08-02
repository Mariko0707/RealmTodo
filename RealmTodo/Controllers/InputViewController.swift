//
//  InputViewController.swift
//  RealmTodo
//
//  Created by Suzuki Mariko on 30/07/2019.
//  Copyright © 2019 Mariko. All rights reserved.
//

import UIKit
import RealmSwift

class InputViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var button: UIButton!
    // 前の画面から渡されてきたTODOを受け取る変数
    var todo: Todo? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        if todo == nil {
        button.setTitle("追加", for: .normal)
        } else {
            // 編集の場合
        button.setTitle("更新", for: .normal)
        textField.text = todo?.title
        }
    }
    
    fileprivate func createNewTodo(_ text: String) {
        // Realmに接続
        let realm = try! Realm()
        
        // データを登録する
        let todo = Todo()
        
        // 最大のIDを取得
        let id = getMaxId()
        
        todo.id = id
        todo.title = text
        todo.date = Date()
        
        // 作成したTODOを登録する
        // tryはそのまま、一度挑戦的な感じ
        try! realm.write {
            realm.add(todo)
        }
    }
    
    fileprivate func updateTodo(_ text: String) {
        // 更新
        let realm = try! Realm()
        try! realm.write {
            todo?.title = text
        }
    }
    
    @IBAction func didClicjButton(_ sender: UIButton) {
    
        // 空文字かチェックする
//        if textField.text == "" {
//        if let title = textField.text {
            // textField.textがnilかチェックする
            // nilではない場合
//        }
//        if title.isEmpty {
            // isEmpty を入れても””と同じ要領でifを形成できる
            // 空文字ではない場合
//        }
        // 空文字でなければデータを登録する
        
        // nilかチェックする
        guard let text = textField.text else {
            // textFirld.textがnilの場合
            // ボタンがクリックされた時の処理を中断
            return
        }
        if text.isEmpty {
            // textFirldが空文字の場合
            // ボタンがクリックされた時の処理を中断
            return
        }
        if todo == nil{
        // 新規タスクを追加
        createNewTodo(text)
        } else {
            updateTodo(text)
        }
        
        // 前の画面に戻る
        // NavigationCOntrollerの持っている履歴から１つ前の画面に戻る
        navigationController?.popViewController(animated: true)
    }
    
        //この下のはハードなのでその下に簡易版を書き直します
//        let id = (realm.objects(Todo.self).max(ofProperty: "id") as Int? ?? 0) + 1
        
        // ここから下↓
        
        // 最大IDを取得するメソッド
        func getMaxId() -> Int {
        // Realmに接続
            let realm = try! Realm()
        // Todoのシートから最大のIDを取得する
        // この下のコードはnilも許容する
            let id = realm.objects(Todo.self).max(ofProperty: "id") as Int?
            if id == nil {
                // 最大IDがnil（存在しない）場合、１を返す
                return 1
            } else {
                // 最大IDが存在する場合、最大ID + 1 を返す
                return id! + 1
            }
            
        }

}
