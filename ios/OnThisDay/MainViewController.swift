//
//  MainViewController.swift
//  OnThisDay
//
//  Created by Aditya Keerthi on 2015-12-29.
//  Copyright © 2015 Aditya Keerthi. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tableView: UITableView?
    var apiManager: APIManager?
    
    var historyType: Int = 0
    
    init() {
        super.init(nibName:nil, bundle:nil)
        
        self.tableView = UITableView()
        self.apiManager = APIManager()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.whiteColor()
        self.title = "On This Day"
        
        self.tableView?.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
        self.tableView?.dataSource = self
        self.tableView?.delegate = self
        self.tableView?.estimatedRowHeight = 44.0
        self.tableView?.rowHeight = UITableViewAutomaticDimension
        self.view.addSubview(self.tableView!)
        
        let swipeRight: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "handleSwipe:")
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "handleSwipe:")
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
        self.view.addGestureRecognizer(swipeLeft)
        
        apiManager!.makeRequest()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // UISwipeGestureRecognizer
    
    func handleSwipe(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            switch swipeGesture.direction {
                case UISwipeGestureRecognizerDirection.Right:
                    historyType = (historyType != 0) ? historyType-1 : 2
                case UISwipeGestureRecognizerDirection.Left:
                    historyType = (historyType != 2) ? historyType+1 : 0
                default:
                    break
            }
        }
        
        self.tableView?.reloadData()
    }
    
    // UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return apiManager!.getHistory(historyType).count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return String(apiManager!.getHistory(historyType)[section].year)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    // UITableViewDelegate
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let row = indexPath.section
        
        cell.textLabel!.text = apiManager!.getHistory(historyType)[row].information
        cell.textLabel!.numberOfLines = 0
        
        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }


}