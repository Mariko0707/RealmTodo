//
//  ViewController.swift
//  RealmTodo
//
//  Created by Suzuki Mariko on 30/07/2019.
//  Copyright © 2019 Mariko. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var todos:[Todo] = []
    
    fileprivate func reloadTableView() {
        // Realmに接続
        let realm = try! Realm()
        // Todoの一覧を取得する
        todos = realm.objects(Todo.self).reversed()
        
        // Tableデータの更新
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self

    }
    
    // 画面が表示されるたびに実行
    override func viewWillAppear(_ animated: Bool) {
        reloadTableView()
    }

    @IBAction func didClickAddBtn(_ sender: UIButton) {
        performSegue(withIdentifier: "toNext", sender: nil)
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let todo = todos[indexPath.row]
        cell.textLabel?.text = todo.title
        
        // この下記のコード表記でセルに矢印がつくようになる
        cell.accessoryType = .disclosureIndicator
        // チェックや詳細ボタンもあるじょ
        
        return cell
    }
    
    // セルがクリックされた時の処理（次の画面へ移動）
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // クリックされたTODOを取得する
        let todo = todos[indexPath.row]
        
        performSegue(withIdentifier: "toNext", sender: todo)
    }
    
    // 次の画面に情報を引き継ぐ
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toNext" {
        // 次の画面のCOntrollerを取得
        let inputVC = segue.destination as! InputViewController
        // 次の画面に選択されたTodoを設定
        inputVC.todo = sender as? Todo
     }
    }
    
}

