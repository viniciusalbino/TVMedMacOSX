//
//  TopicsViewController.swift
//  TVMed
//
//  Created by Vinicius Albino on 10/06/17.
//  Copyright © 2017 Vinicius Albino. All rights reserved.
//

import Foundation
import Cocoa
import CoreGraphics

class TopicsViewController: NSViewController, TopicsDelegate, NSCollectionViewDataSource, NSCollectionViewDelegate, NSCollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: NSCollectionView!
    @IBOutlet weak var loadingView: NSProgressIndicator!
    lazy var viewModel: TopicsViewModel = TopicsViewModel(delegate: self)
    var currentMidia: MidiaPromotion?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        collectionView.delegate = self
        collectionView.dataSource = self
//        tableView.doubleAction = #selector(tableViewDoubleClick(_:))
    }
    
    private func configureCollectionView() {
        // 1
        let flowLayout = NSCollectionViewFlowLayout()
        flowLayout.itemSize = NSSize(width: 700, height: 80.0)
        flowLayout.sectionInset = EdgeInsets(top: 30.0, left: 5.0, bottom: 30.0, right: 5.0)
        flowLayout.minimumInteritemSpacing = 10.0
        flowLayout.minimumLineSpacing = 10.0
        collectionView.collectionViewLayout = flowLayout
        // 2
        view.wantsLayer = true
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
    
    // MARK: COLLECTION VIEW DELEGATE
    func numberOfSections(in collectionView: NSCollectionView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItensInSection(section: section)
    }
    
    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> NSSize {
        return NSSize(width: collectionView.frame.size.width, height: 40)
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let item = collectionView.makeItem(withIdentifier: "CollectionViewItem", for: indexPath)
        guard let collectionViewItem = item as? CollectionViewItem else {return item}
        
        let itemDetail = viewModel.itemForSection(section: indexPath.section, row: indexPath.item)
        // 5
        collectionViewItem.fill(title: itemDetail.titulo, isDowwloaded: viewModel.isMovietDownloaded(subTopic: itemDetail))
        return item
    }
    
    func collectionView(_ collectionView: NSCollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> NSView {
        let view  = collectionView.makeSupplementaryView(ofKind: NSCollectionElementKindSectionHeader, withIdentifier: "HeaderView", for: indexPath) as! HeaderView
        view.fill(title: viewModel.titleForHeaderInSection(section: indexPath.section))
        return view
    }
    
    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
        collectionView.deselectItems(at: indexPaths)
        let subTopic = viewModel.itemForSection(section: indexPaths.first!.section, row: indexPaths.first!.item)
        if !viewModel.isMovietDownloaded(subTopic: subTopic) {
            viewModel.validatesUserToken(subTopicID: subTopic.subtopicoId)
        }
    }
    
    func playVideo(url: String, subTopicID: String) {
        print(url)
        viewModel.downloadMovie(topicID: subTopicID, url: URL(string: url)!) { progress, error in
            
        }
    }
    
    func errorOnPlayingVideo() {
        stopLoading()
    }
    
}
