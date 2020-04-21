//
//  AllUserVCViewController.swift
//  SignUp
//
//  Created by AshutoshD on 24/03/20.
//  Copyright © 2020 ravindraB. All rights reserved.
//

import UIKit

class AllUserVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    

    @IBOutlet var tblView : UITableView!
    
    let cellId = "UserListCell"
    var arrUserData = [[String: String]]()
    var testArrData = [User]()
    var selectedIndex : IndexPath? = IndexPath(row: 0, section: 0)
    var passSelectedTest : ((Int)->())?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print("arrUserData : \(arrUserData)")
        tblView.delegate = self
        tblView.dataSource = self
        
        
        //  tblView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        self.tblView.allowsMultipleSelectionDuringEditing = false
        
        tblView.estimatedRowHeight = 60
        
    }
    
    
    
    
    
    //
    //     func numberOfSections(in tableView: UITableView) -> Int {
    //        return
    //    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testArrData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       
            return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblView.dequeueReusableCell(withIdentifier: "AllUserCell", for: indexPath) as! AllUserCell
        cell.selectionStyle = .none
//        let data = arrUserData[indexPath.row]
        if !testArrData.isEmpty {
            let newData = testArrData[indexPath.row]
            cell.lblName.text = newData.name
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("Did select Tapped")
        passSelectedTest?(indexPath.row);
        self.navigationController?.popViewController(animated: true)
    
    }
    
 
}
