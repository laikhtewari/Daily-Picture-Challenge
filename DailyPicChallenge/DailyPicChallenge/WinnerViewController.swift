//
//  WinnerViewController.swift
//  DailyPicChallenge
//
//  Created by Laikh Tewari on 8/4/15.
//  Copyright (c) 2015 Laikh Tewari. All rights reserved.
//

import UIKit
import Parse

class WinnerViewController: UIViewController {

    @IBOutlet weak var winnerTableView: UITableView!
    
    var winners: [Winner] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.winnerTableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        
        let winnersQuery = Winner.query()
        
        winnersQuery!.findObjectsInBackgroundWithBlock {
            (results: [AnyObject]?, error: NSError?) -> Void in
            
            self.winners = results as? [Winner] ?? []
            
            for winner in self.winners
            {
                let data = winner.post.imageFile?.getData()
                
                winner.post.image = UIImage(data: data!, scale: 1.0)
            }
        }
        winnersQuery?.orderByAscending("createdAt")
        
        self.winnerTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension WinnerViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 1
        return winners.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // 2
        let cell = tableView.dequeueReusableCellWithIdentifier("WinnerCell") as! WinnerTableViewCell
        
        cell.winnerImageView.image = winners[indexPath.row].post.image
        cell.winner = winners[indexPath.row]
        
        return cell
    }
}

