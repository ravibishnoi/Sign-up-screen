//
//  UserListVC.swift
//  SignUp
//
//  Created by AshutoshD on 20/03/20.
//  Copyright © 2020 ravindraB. All rights reserved.
//

import UIKit

protocol UpdateSelectionDelegate {
    
    func didTapUpdate(flag : Bool ,id : Int, name : String, phone : String,  email : String,  about : String)
}
class UserListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var tblView: UITableView!
    
    let cellId = "UserListCell"
    var arrUserData = [[String:String]]()
    var testArray = [User]()
    var selectedIndex : IndexPath? = IndexPath(row: 0, section: 0)
    var indexSel : Int? = nil
    var updateDelegate : UpdateSelectionDelegate?
    var sendVal : Int? = nil
    var indexpath : Int? = nil
    var passSelectedVal : ((Bool)->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        print("arrUserData : \(arrUserData)")
        print("testArray : \(testArray)")
        tblView.delegate = self
        tblView.dataSource = self
        tblView.separatorStyle = .none
        
        
      //  tblView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        self.tblView.allowsMultipleSelectionDuringEditing = false
        
        tblView.estimatedRowHeight = 60
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tblView.reloadData()
    }
   
    
   
    @IBAction func addMoreTapped (_ sender : UIButton){
        passSelectedVal?(true)
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func rearrangeTapped (_ sender : UIButton){
        
        tblView.reloadData()
    }
    
    
//    
//     func numberOfSections(in tableView: UITableView) -> Int {
//        return
//    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 60
        }
        else {
            if selectedIndex == indexPath {
                return 214
            }
            else{
                return 60
            }
        }
        
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
         
                let cellSecond = tblView.dequeueReusableCell(withIdentifier: "AllUserNameCell", for: indexPath) as! AllUserNameCell
                cellSecond.selectionStyle = .none
                cellSecond.lblAllUser.text = "User List"
                return cellSecond
          
        }
        else if indexPath.row == 1 {
            
                let cell = tblView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! UserListCell
                cell.viewMain.isHidden = false
                print("indexSel \(indexSel)")
//                let data = arrUserData[indexSel ?? 0]
                if !testArray.isEmpty {
                    let newData = testArray[indexSel ?? 0]
                    cell.lblName.text = newData.name
                    cell.lblMob.text = newData.phone
                    cell.lblEmail.text = newData.email
                    cell.lblDescription.text = newData.about
                    sendVal = newData.id
                    indexpath = indexPath.row
                    cell.animate()
                }
            return cell
        }
        else {
             let cell = tblView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! UserListCell
            cell.viewMain.isHidden = true
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "AllUserVC") as? AllUserVC
   //         vc?.arrUserData = arrUserData
            vc?.testArrData = testArray
            vc?.passSelectedTest = {(gotValue)in
                self.indexSel = gotValue
                print(gotValue)
            }
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        else {
            print("Did select Tapped")
            selectedIndex = indexPath
            tblView.beginUpdates()
            tblView.reloadRows(at: [selectedIndex!], with: .none)
            tblView.endUpdates()
        }
       
    }
    
    private func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    private func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCell.EditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCell.EditingStyle.delete) {
            
            arrUserData.remove(at: indexPath.row)
            tblView.deleteRows(at: [indexPath as IndexPath], with: .fade)
        }
    }
    
     func tableView(_ tableView: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .normal, title: "Delete") { action, index in
            print("more button tapped")
            self.testArray.remove(at: self.indexpath!)
            tableView.reloadData()
        }
        delete.backgroundColor = .red

        let update = UITableViewRowAction(style: .normal, title: "Update") { action, index in
            print("favorite button tapped")
            
            let newData = self.testArray[self.sendVal!]
            self.updateDelegate?.didTapUpdate(flag: false, id: newData.id, name: newData.name, phone: newData.phone
                , email: newData.email, about: newData.about)
            self.navigationController?.popViewController(animated: true)
        }
        update.backgroundColor = .orange

        return [update,delete]
    }
    
}
