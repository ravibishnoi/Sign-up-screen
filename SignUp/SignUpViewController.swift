//
//  ViewController.swift
//  SignUp
//
//  Created by AshutoshD on 18/03/20.
//  Copyright © 2020 ravindraB. All rights reserved.
//

import UIKit
import DropDown
//import CropViewController


class SignUpViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate,UITextViewDelegate {
   
    @IBOutlet weak var txtMobile: UITextField!
    @IBOutlet weak var txtViewTopSpacing: NSLayoutConstraint!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var btnMale: UIButton!
    @IBOutlet weak var btnFemale: UIButton!
    @IBOutlet weak  var btnOther: UIButton!
    @IBOutlet weak var imgPicker: UIImageView!
    @IBOutlet weak var txtDOB: UITextField!
    @IBOutlet weak var txtOccupation: UITextField!
    @IBOutlet weak var txtOtherOccu: UITextField!
    @IBOutlet weak var btnCropImage: UIButton!
    @IBOutlet weak var viewOccupation: UIView!
    @IBOutlet weak var btnCheckTerm : UIButton!
    @IBOutlet weak var txtView: UITextView!

    
    let datePicker = UIDatePicker()
    var imagePicker = UIImagePickerController()
    var genderVal = false
    var btnCheck = false
    var myArray = [[String: String]]()
    var testArr = [User]()
    var id : Int = 0
    var idMathch : Int? = nil
    var addUser = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtOtherOccu.isHidden = true
        setDatePicker()
        self.title = "Sign Up"
        self.navigationController?.navigationBar.isHidden = false
        imagePicker.delegate = self
      
        DataUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        testArr.removeAll(
    }
    
    
    func DataUI(){
        txtView.delegate = self
        txtView.text = "Description"
        txtView.textColor = UIColor.lightGray
        
        imgPicker.layer.cornerRadius = imgPicker.bounds.size.width/2
        imgPicker.clipsToBounds = true
        btnCropImage.layer.cornerRadius = btnCropImage.bounds.size.width/2
        btnCropImage.clipsToBounds = true
        
        
        addPaddingAndBorder(to: txtName)
        addPaddingAndBorder(to: txtMobile)
        addPaddingAndBorder(to: txtDOB)
        addPaddingAndBorder(to: txtOtherOccu)
//        addPaddingAndBorder(to: txtOccupation)
        addPaddingAndBorder(to: txtEmail)
        self.txtView.contentInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 5);
        
        txtName.delegate = self
        txtName.tag = 0
        txtMobile.delegate = self
        txtMobile.tag = 1
        txtDOB.delegate = self
        txtDOB.tag = 2
        txtEmail.delegate = self
        txtEmail.tag = 3
        txtOtherOccu.delegate = self
        
        txtEmail.dropShadow(scale: true)
        txtName.dropShadow(scale: true)
        txtDOB.dropShadow(scale: true)
        txtMobile.dropShadow(scale: true)
//        txtOccupation.dropShadow(scale: true)
        txtOtherOccu.dropShadow(scale: true)
        viewOccupation.dropShadow(scale: true)
        txtView.dropShadow(scale: true)
        
        
        
        txtViewTopSpacing.constant = -40
        self.view.layoutIfNeeded()
    }

    @IBAction func CropImageBtnTapped(_ sender: UIButton) {
//        presentCropViewController()
    }
    
    
    @IBAction func BtnOccupationTapped(_ sender: UIButton) {
        
        let OccupationArray = ["Unemployed","Bussiness","Job","Other"]
        let dropDown = DropDown()
        
        // The view to which the drop down will appear on
        dropDown.anchorView = sender
        
        // The list of items to display. Can be changed dynamically
        dropDown.dataSource = OccupationArray
        //    dropDown.bottomOffset = CGPoint(x: 0, y: (sender.frame?.size.height)!)
        dropDown.backgroundColor = UIColor .white
        
        //dropDown.direction = .top
        // dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        
        // Action triggered on selection
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.txtOccupation.text = item
            print("Selected item: \(item) at index: \(index)")
            
            if(index == 3)
            {
                self.txtViewTopSpacing.constant = 20
                
                self.txtOtherOccu.isHidden = false
                
            }
            else
            {
                self.txtViewTopSpacing.constant = -40
                self.txtOtherOccu.isHidden = true
            }
        }
        dropDown.show()
        
    }
    
    
    @IBAction func btnTermServiceTappe (_ sender: UIButton){
        UIApplication.shared.openURL(NSURL(string: "http://www.google.com")! as URL)
    }
    @IBAction func btnCheckTermTapped (_ sender: UIButton){
    
        if btnCheck {
            btnCheckTerm.setImage(UIImage.init(named: "checkbox-blank-outline"), for: .normal)
            
        }
        else {
            btnCheckTerm.setImage(UIImage.init(named: "checkbox-marked"), for: .normal)
        }
        
        btnCheck = !btnCheck
    }
    
    
    
    @IBAction func BtnGenderTapped(_ sender: UIButton) {
        
        if sender.tag == 0 {
//            btnMale.setBackgroundImage(UIImage.init(named: "radiobox-marked"), for: .normal)
            genderVal = true
            btnMale.setImage(UIImage.init(named: "radiobox-marked"), for: .normal)
            btnFemale.setImage(UIImage.init(named: "radiobox-blank"), for: .normal)
            btnOther.setImage(UIImage.init(named: "radiobox-blank"), for: .normal)
            
        }
        else if sender.tag == 1 {
            genderVal = true
            btnFemale.setImage(UIImage.init(named: "radiobox-marked"), for: .normal)
            btnMale.setImage(UIImage.init(named: "radiobox-blank"), for: .normal)
            btnOther.setImage(UIImage.init(named: "radiobox-blank"), for: .normal)
        }
        else if sender.tag == 2 {
            genderVal = true
            btnOther.setImage(UIImage.init(named: "radiobox-marked"), for: .normal)
            btnFemale.setImage(UIImage.init(named: "radiobox-blank"), for: .normal)
            btnMale.setImage(UIImage.init(named: "radiobox-blank"), for: .normal)
        }
        
    }
    
    
    
    @IBAction func btnSelectImageTapped(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallery()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    func openGallery()
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self as UIImagePickerControllerDelegate & UINavigationControllerDelegate
            imagePicker.allowsEditing = true
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have permission to access gallery.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    func openCamera()
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self as UIImagePickerControllerDelegate & UINavigationControllerDelegate
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    //MARK:-- ImagePicker delegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
             imgPicker.contentMode = .scaleToFill
            imgPicker.image = pickedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func BtnSubmitTapped(_ sender: UIButton) {
        
        if txtName.text == "" {
            showToast(message: "Please Enter the Name", font: mySystemFont(ofSize: 13))
        }
        else if txtEmail.text == "" {
            showToast(message: "Please Enter Email Address", font: mySystemFont(ofSize: 13))
        }
        else if !isValidEmail(txtEmail.text ?? ""){
            showToast(message: "Please enter valid email address", font: mySystemFont(ofSize: 13))
        }
            
        else if txtDOB.text == "" {
            showToast(message: "Please select DOB", font: mySystemFont(ofSize: 13))
        }
        else if genderVal == false {
            showToast(message: "Please Select Gender", font: mySystemFont(ofSize: 13))
        }
        else if txtMobile.text == "" {
            showToast(message: "Please Enter the Mobile Number", font: mySystemFont(ofSize: 13))
        }
//        else if txtMobile.text!.isValidContact {
//            showToast(message: "Please enter minimum 10 Digit Phone number", font: mySystemFont(ofSize: 13))
//        }
        else if txtOccupation.text == "" {
            showToast(message: "Please Select Occupation", font: mySystemFont(ofSize: 13))
            
        }
        else if txtView.text == "" {
            showToast(message: "Please Enter Description", font: mySystemFont(ofSize: 13))
            
        }
//        else if txtOccupation.text != nil {
//            if txtOccupation.text == "Other" {
//                if txtOtherOccu.text == "" {
//                    showToast(message: "Please Enter about occupation", font: mySystemFont(ofSize: 13))
//                }
//            }
//        }
        else if !btnCheck {
            let dict = ["name" : txtName.text! , "mobile" : txtMobile.text!, "email" : txtEmail.text!, "description" : txtView.text!]
            
//            let dict = ["name" : "Ravi" , "mobile" : "9460204", "email" : "ravi@gmail.com", "description" : "Hello world! Here we testing our work through this app"]
            
             showToast(message: "Please check term & Conditons", font: mySystemFont(ofSize: 13))
        }
        else  {
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "UserListVC") as? UserListVC
           
            if addUser {
                testArr.append(User(id: id, name: txtName.text!, email: txtEmail.text!, phone: txtMobile.text!, about: txtView.text!))
                id+=1
            }
           
//            myArray.append(dict as [String : String])
//            //            ExpandableNames.init(names: myArray)
//            print("dict : \(dict)")
//            print("myArray : \(myArray)")
//                testArr.append(User(id: idMathch, name: txtName.text!, email: txtEmail.text!, phone: txtMobile.text!, about: txtView.text!))
            if idMathch != nil {
                testArr.remove(at: (idMathch!))
                testArr.insert(User(id: idMathch!, name: txtName.text!, email: txtEmail.text!, phone: txtMobile.text!, about: txtView.text!), at: idMathch!)
            }
            vc?.arrUserData = myArray
            vc?.testArray = testArr
            vc?.updateDelegate = self
            vc?.passSelectedVal = {(gotValue)in
                self.addUser = gotValue
                print(gotValue)
            }
            self.navigationController?.pushViewController(vc!, animated: true)
            showToast(message: "Sign up succesfully", font: mySystemFont(ofSize: 13))
        }
    }
    
    
    
    
    
    func setDatePicker() {
        //Format Date
        datePicker.datePickerMode = .date
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneDatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        txtDOB.inputAccessoryView = toolbar
        txtDOB.inputView = datePicker
    }
    
    @objc func doneDatePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        txtDOB.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
//    func presentCropViewController() {
//        let image: UIImage = imgPicker.image!
//        let cropViewController = CropViewController(image: image)
//        cropViewController.delegate = self
//        present(cropViewController, animated: true, completion: nil)
//    }
    
    
//    func presentCropViewController() {
//        var image: UIImage = imgPicker.image!
//        var imageView = UIImageView(image: image)
//        var frame: CGRect = view.convert(imageView.frame, to: view)
//
//        let cropViewController = CropViewController(image: image)
//        cropViewController.delegate = self as! CropViewControllerDelegate
//        self.present(cropViewController, animated: true, completion: nil)
////        cropViewController.presentAnimated(fromParentViewController: self, fromFrame: frame, completion: nil)
//    }
    
//    func cropViewController(_ cropViewController: CropViewController, didCropToImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
//        // 'image' is the newly cropped version of the original image
//        cropViewController.dismiss(animated: true) { () -> Void in
//            self.imgPicker.image = image
//        }
//    }
    
    
//    private func cropViewController(_ cropViewController: TOCropViewController, didFinishCancelled cancelled: Bool)
//    {
//        cropViewController.dismiss(animated: true) { () -> Void in  }
//    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Try to find next responder
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard.
            textField.resignFirstResponder()
        }
        // Do not add a line break
        return false
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Description"
            textView.textColor = UIColor.lightGray
        }
    }
}


extension UIViewController {
    
    func showToast(message : String, font: UIFont) {
        
        let toastLabel = UILabel(frame: CGRect(x: 30 , y: self.view.frame.size.height-100, width: self.view.frame.size.width - 60, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func mySystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size)
    }
    
    func validatePhone(value: String) -> Bool {
        let PHONE_REGEX = "^\\d{3}-\\d{3}-\\d{4}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result = phoneTest.evaluate(with: value)
        return result
    }
    
    func addPaddingAndBorder(to textfield: UITextField) {
//        textfield.layer.cornerRadius =  5
//        textfield.layer.borderColor = UIColor.gray.cgColor
//        textfield.layer.borderWidth = 1
        let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 2.0))
        textfield.leftView = leftView
        textfield.leftViewMode = .always
    }
}

extension UIView {
    
    func dropShadow(scale: Bool = true) {
        self.layer.cornerRadius =  5
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.gray.cgColor
//        self.layer.shadowColor = UIColor.gray.cgColor
//        self.layer.shadowOpacity = 0.5
//        self.layer.shadowOffset = CGSize.zero
//        self.layer.shadowRadius = 5
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.4
        self.layer.shadowOffset = CGSize(width: -1, height: 1)
        self.layer.shadowRadius = 3
        
        self.layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
}
extension String {
    var isValidContact: Bool {
        let phoneNumberRegex = "^[9-12]\\d{12}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneNumberRegex)
        let isValidPhone = phoneTest.evaluate(with: self)
        return isValidPhone
    }
}

extension SignUpViewController : UpdateSelectionDelegate {
    func didTapUpdate(flag: Bool, id: Int, name: String, phone: String, email: String, about: String) {
        txtName.text = name
        txtMobile.text = phone
        txtEmail.text = email
        txtView.text = about
        idMathch = id
        addUser = flag
        print("name \(name), phone \(phone), email \(email), about \(about), id \(id)")
    }
   
}
