//
//  NewsTableViewController.swift
//  Here is a News
//
//  Created by Igor Shelginskiy on 10/10/19.
//  Copyright © 2019 Igor Shelginskiy. All rights reserved.
//

import UIKit

class NewsTableViewController: UITableViewController {
    
    var header = Articles()

    var cellManager = CellManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var num = header.articles.count
        if header.articles.count > 20 {
            num = 20
        }
        return num
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let new = header.articles[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NewsCell
        cellManager.configure(cell, with: new)
        return cell
    }
    
    func getData() {
        let baseUrl = URL(string: "https://newsapi.org/v2/top-headlines")!
        
        let query = ["country": "us", "apiKey": "e2c238227b3f4437b4fa4dd7fb395789"]
        
        let url = baseUrl.withQueries(query)!
        
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { print("Data has not converted"); return }
            let decoder = JSONDecoder()
            //decoder.dateDecodingStrategy = .iso8601
            guard let report = try? decoder.decode(Articles.self, from: data) else { print("Data cannot be decoded as JSON"); return}
            
                print(report)
        }
        task.resume()
    }

}

extension URL {
    func withQueries (_ queries: [String: String]) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = queries.map {URLQueryItem(name: $0.key, value: $0.value)}
        return components?.url
    }
}
