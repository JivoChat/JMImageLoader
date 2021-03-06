//
//  ViewController.swift
//  JMImageLoaderTestApp
//
//  Created by Anton Karpushko on 02.08.2021.
//

import UIKit
@testable import JMImageLoader

// File global image loader singleton

fileprivate var imageLoadingDefaultStrategy: JMImageLoading = {
    let IMAGE_CACHE_MEMORY_LIMIT = 1024 * 1024 * 50
    
    let imageLoadingDefaultStrategy = ImageLoadingStrategyFactory.default(withImageCacheMemoryLimit: IMAGE_CACHE_MEMORY_LIMIT).build()
    
    return imageLoadingDefaultStrategy
}()

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private var imageLoadingDefaultStrategy: JMImageLoading?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension ViewController: UITableViewDataSource {
    private var TABLE_VIEW_CELL_HEIGHT: CGFloat { 300 }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        TABLE_VIEW_CELL_HEIGHT
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "TableViewCell")
        guard
            indexPath.row < data.count,
            let url = data[indexPath.row]
        else {
            cell.textLabel?.text = "Invalid URL"
            return cell
        }
        
        cell.imageView?.jmLoadImage(with: url) { result in
            switch result {
            case .failure: cell.textLabel?.text = "Image was not loaded :((("
            default: break
            }
            cell.setNeedsLayout()
        }
        
        return cell
    }
    
    private var data: [URL?] {
        let urls: [URL?] = [
            URL(string: "https://www.domashniy-comfort.ru/images/stes/picture/00000korgi/korg_014.jpg"),
            URL(string: "https://cat4you.ru/wp-content/uploads/d/8/8/d88b23aa446cf2279cf4f354acdb40e1.jpeg"),
            URL(string: "https://krasivosti.pro/uploads/posts/2021-04/1618083573_1-p-korgi-vzroslii-sobaki-krasivo-foto-1.jpg"),
            URL(string: "https://www.tinydog.ru/wp-content/uploads/2016/05/Korgi.jpg"),
            URL(string: "https://klkfavorit.ru/wp-content/uploads/0/b/7/0b72f9e0503c1f6ec5f076941846f75b.jpe"),
            URL(string: "https://www.domashniy-comfort.ru/images/stories/picture/00000korgi/korg_001.jpg"),
            URL(string: "https://avatars.mds.yandex.net/get-zen_gallery/4001064/pub_5f97db6c1772f52b504f12b7_5f97db7b1772f52b504f2b2a/scale_1200"),
            URL(string: "https://www.domashniy-comfort.ru/images/stories/picture/00000korgi/korg_002.jpg"),
            URL(string: "https://cdn0.youla.io/files/images/780_780/5f/3e/5f3e67c87eab053c4d56898d-1.jpg"),
            URL(string: "https://avatars.mds.yandex.net/get-zen_doc/1900266/pub_5cd868c5c5fa2a00b42680c5_5cd86c2ea27d9900b324e624/scale_1200"),
        ]
        return urls
    }
}

extension ViewController: UITableViewDelegate {
    
}
