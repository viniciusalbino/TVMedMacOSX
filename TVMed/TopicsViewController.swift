//
//  TopicsViewController.swift
//  TVMed
//
//  Created by Vinicius Albino on 10/06/17.
//  Copyright © 2017 Vinicius Albino. All rights reserved.
//

import Foundation
import Cocoa

class TopicsViewController: NSViewController, TopicsDelegate {
    
    @IBOutlet weak var collectionView: NSCollectionView!
    @IBOutlet weak var loadingView: NSProgressIndicator!
    lazy var viewModel: TopicsViewModel = TopicsViewModel(delegate: self)
    var currentMidia: MidiaPromotion?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        tableView.doubleAction = #selector(tableViewDoubleClick(_:))
    }
    
    override func startLoading() {
        loadingView.isHidden = false
        loadingView.startAnimation(self)
    }
    
    override func stopLoading() {
        loadingView.isHidden = true
        loadingView.stopAnimation(self)
    }
    
    func loadContent(midia: MidiaPromotion) {
        self.currentMidia = midia
        DispatchQueue.main.async {
            self.viewModel.loadTopics(midia: midia)
        }
    }
    
    func contentDidFinishedLoading(success: Bool) {
        stopLoading()
        guard success else {
            return
        }
        self.title = viewModel.getTitle()
        self.collectionView.reloadData()
    }
    
    func downloadVideo(url: String) {
        
    }
    
}
