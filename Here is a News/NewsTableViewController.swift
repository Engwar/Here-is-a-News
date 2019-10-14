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
    var outInternet = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadFile()
        getData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sleep(1)
        guard header.articles.count > 0 else { outInternet = "Check your internet connection"; return 0 }
        return header.articles.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let new = header.articles[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NewsCell
        cell.header.text = new.author ?? "none author"
        cell.date.text = "\(String(describing: new.publishedAt))"
        cell.descript.text = new.title ?? ""
        cell.descript.isSelectable = false
        cell.img.image = downloader(url: new.urlToImage)
        saveFile()
        return cell
    }
    
    func downloader(url: String?) -> UIImage? {
        guard let url = url,
            let imageUrl = URL(string: url),
            let data = NSData(contentsOf: imageUrl)
            else { return nil }

        return UIImage(data: data as Data)
    }
    
    func getData() {
        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=e2c238227b3f4437b4fa4dd7fb395789")!
        _ = URLSession.shared.dataTask(with: url) { data, response, error in
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                let report = try decoder.decode(Articles.self, from: data!)
                self.header = report
            } catch let error {
                print (error)
            }
        }.resume()
    }
    
    func saveFile() {
        let documentDir = FileManager.default.urls(for: .documentationDirectory, in: .userDomainMask).first!
        let archURL = documentDir.appendingPathComponent("data").appendingPathExtension("plist")
        let propListEncoder = PropertyListEncoder()
        let encodedNews = try? propListEncoder.encode(header)
        try? encodedNews?.write(to: archURL, options: .noFileProtection)
    }
    
    func loadFile() {
        let documentDir = FileManager.default.urls(for: .documentationDirectory, in: .userDomainMask).first!
        let archURL = documentDir.appendingPathComponent("data").appendingPathExtension("plist")
        guard let data = try? Data(contentsOf: archURL) else {return}
        let propListDecoder = PropertyListDecoder()
        guard let header = try? propListDecoder.decode(Articles.self, from: data) else { return }
        self.header = header
    }
}
//
//extension URL {
//    func withQueries (_ queries: [String: String]) -> URL? {
//        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
//        components?.queryItems = queries.map {URLQueryItem(name: $0.key, value: $0.value)}
//        return components?.url
//    }
//}
