//
//  HomeViewController.swift
//  Instagram
//
//  Created by Aarnav Ram on 18/03/17.
//  Copyright © 2017 Aarnav Ram. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var posts:[PFObject]?
    let refreshControl = UIRefreshControl()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 236
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(getPosts), for: .valueChanged)
        getPosts()
        // Do any additional setup after loading the view.
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        getPosts()
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogoutPressed(_ sender: Any) {
        
        PFUser.logOutInBackground { (error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "logout"), object: nil)
                print("I logged out")
            }
        }
        
    }
    
    
    func getPosts() {
        let query = PFQuery(className: "Post")
        query.order(byDescending: "createdAt")
        query.includeKey("username")
        query.limit = 20
        
        // fetch data asynchronously
        
        query.findObjectsInBackground { (posts: [PFObject]?, error : Error?) in
            if let final = posts {
                self.posts = final
                self.tableView.reloadData()
                print(self.posts)
                
            } else {
                print(error?.localizedDescription)
            }
        }
        refreshControl.endRefreshing()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let posts = self.posts {
            return posts.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath) as! ImageTableViewCell
        //cell.usernameLabel.text = "Caption"
        cell.layer.borderColor = UIColor.white.cgColor
        cell.instagramPost = posts![indexPath.row]
        return cell
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
