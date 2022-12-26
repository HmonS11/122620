//
//  MainTableViewController.swift
//  BookFinderWithAlamoFire
//
//  Created by runnysun on 2022/11/03.
//

import UIKit
import Alamofire
import Kingfisher
import ProgressHUD

//

//  MainTableViewController.swift

//  BookFinderWithAlamoFire

//

//  Created by wizard on 2022/11/03.

//



import UIKit

import Alamofire

import Kingfisher

import ProgressHUD

import Toast



class MainTableViewController: UITableViewController {

    let apiKey = "e981ca0637e8ac98f0b0ee695b0597aa"

    var page = 1

    var books:[Book] = []

    

    override func viewDidLoad() {

        super.viewDidLoad()

        tableView.rowHeight = 120

    }

    

    func search(with query:String?, page:Int){

        guard let query = query else { return }

        ProgressHUD.show("Loding...")

        let str = "https://dapi.kakao.com/v3/search/book"

        

        let params:Parameters = ["query":query, "page":page]

        let headers:HTTPHeaders  = ["Authorization":"KakaoAK \(apiKey)"]

        let alamo = AF.request(str, method: .get, parameters: params, headers: headers)

        

        alamo.responseDecodable(of: Result.self) { response in

            guard let root = response.value else { return }

            self.books = root.documents

            self.tableView.reloadData()

            ProgressHUD.showSucceed()

        }



    }

    



    // MARK: - Table view data source

    

    override func numberOfSections(in tableView: UITableView) -> Int {

        // #warning Incomplete implementation, return the number of sections

        return 1

    }

    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        // #warning Incomplete implementation, return the number of rows

        return books.count

    }

    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "bookcell", for: indexPath) as? BookCell else { fatalError() }

        let book = self.books[indexPath.row]

        cell.thumbnailView.kf.setImage(with: URL(string: book.thumbnail))

        cell.lblTitle.text = book.title

        cell.button.tag = indexPath.row

        cell.button.addTarget(self, action: #selector(buttonClicked(sender:)), for: .touchUpInside)

        cell.sw.tag = indexPath.row

        cell.sw.addTarget(self, action: #selector(swValueChanged(sender: )), for: .valueChanged)

        return cell

    }

    

    @objc func buttonClicked(sender:UIButton){

        let index = sender.tag

        let book = self.books[index]

        print(book.title)

    }

    

    @objc func swValueChanged(sender:UISwitch){

        let index = sender.tag

        let book = self.books[index]

//        book.isComplete = sender.isOn

    }

    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let book = self.books[indexPath.row]

        print(book.title)

    }

    

   

}



extension MainTableViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        page = 1

        search(with:searchBar.text, page: page)

        searchBar.resignFirstResponder()

    }

}
