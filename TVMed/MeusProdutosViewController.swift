//
//  MeusProdutosViewController.swift
//  TVMed
//
//  Created by Vinicius Albino on 10/06/17.
//  Copyright © 2017 Vinicius Albino. All rights reserved.
//

import Foundation
import Cocoa

class MeusProdutosViewController: NSViewController, HomeDelegate, NSTableViewDelegate, NSTableViewDataSource {
    
    lazy var viewModel: HomeViewModel = HomeViewModel(delegate:self)
    @IBOutlet weak var loadingView: NSProgressIndicator!
    @IBOutlet weak var tableView: NSTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.target = self
        tableView.doubleAction = #selector(tableViewDoubleClick(_:))
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        loadContent()
    }
    
    override func startLoading() {
        loadingView.isHidden = false
        loadingView.startAnimation(self)
    }
    
    override func stopLoading() {
        loadingView.isHidden = true
        loadingView.stopAnimation(self)
    }
    
    func loadContent() {
        let tokenPersister = TokenPersister()
        tokenPersister.query { token in
            guard let userToken = token, !userToken.token.isEmpty else {
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "presentLogin", sender: nil)
                }
                return
            }
            
            self.viewModel.checkValiToken { success in
                guard !success else {
                    self.startLoading()
                    self.viewModel.loadMeusProdutos()
                    return
                }
                self.performSegue(withIdentifier: "presentLogin", sender: nil)
            }
        }
    }
    
    func contentDidFinishedLoading(success: Bool) {
        stopLoading()
        tableView.reloadData()
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return viewModel.getMidias().count
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
         var cellIdentifier = ""
            cellIdentifier = "CustomCell"
        if let cell = tableView.make(withIdentifier: cellIdentifier, owner: nil) as? NSTableCellView {
            cell.textField?.stringValue = viewModel.getMidias().object(index: row)?.nomeCongresso ?? ""
//            cell.imageView?.image = image ?? nil
            
            return cell
        }
        return nil
    }
    
    func tableViewDoubleClick(_ sender:AnyObject) {
        guard tableView.selectedRow >= 0 else {
                return
        }
        guard let viewController = parent?.childViewControllers[1] as? TopicsViewController, let currentMidia = viewModel.getMidias().object(index: tableView.selectedRow) else {
            return
        }
        viewController.loadContent(midia: currentMidia)
    }
}
