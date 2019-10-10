//
//  NewsTableViewController.swift
//  Here is a News
//
//  Created by Igor Shelginskiy on 10/10/19.
//  Copyright © 2019 Igor Shelginskiy. All rights reserved.
//

import UIKit

class NewsTableViewController: UITableViewController {
    
    var news = [News]()
    var cellManager = CellManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var num = news.count
        if news.count > 20 {
            num = 20
        }
        return num
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let new = news[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NewsCell
        cellManager.configure(cell, with: new)
        return cell
    }
    
    func getData() {
        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=e2c238227b3f4437b4fa4dd7fb395789")!
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { print("Data has not converted"); return }
            
            let jsonDecoder = JSONDecoder()
            
            guard let report = try? jsonDecoder.decode(News.self, from: data) else { print("Data cannot be decoded as JSON"); return}
            
                print(report)
            self.news = [report]
            }
    
        task.resume()
    }

}

//extension URL {
//    func withQueries (_ queries: [String: String]) -> URL? {
//        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
//        components?.queryItems = queries.map {URLQueryItem(name: $0.key, value: $0.value)}
//        return components?.url
//    }
//}
