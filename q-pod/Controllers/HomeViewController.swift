//
//  HomeViewController.swift
//  q-pod
//
//  Created by Murrali Ramasamy on 25/6/18.
//  Copyright © 2018 Murrali Ramasamy. All rights reserved.
//

import UIKit
import MapKit
import Kingfisher

protocol HandleUserPrefLocation {
    func getSelectedLocation(selectedPlaceMark: MKPlacemark)
}

class HomeViewController: UIViewController {
    
    let photoHelper = MGPhotoHelper()
    
    weak var selectedPlaceMark: MKPlacemark?
    //weak var newPod: Pod?
    
    @IBOutlet weak var whatTextfield: UITextField!
    @IBOutlet weak var whereTextfield: UITextField!
    @IBOutlet weak var whenTextfield: UITextField!
    @IBOutlet weak var bgImgView: UIImageView!
    @IBOutlet weak var expireSwitch: UISwitch!
    @IBOutlet weak var expiryLabel: UILabel!
    
    
    @IBAction func toggleLabel(_ sender: UISwitch) {
        if sender.isOn {
            sender.isSelected = true
            // SWITCH ACTUALLY CHANGED -- DO SOMETHING HERE
            print("Toggle On")
            self.expiryLabel.fadeIn()
        } else {
            sender.isSelected = false
            print("Toggle Off")
            self.expiryLabel.fadeOut()
        }
        
    }
    
    var whereTextAppend: String = ""
    var didSetLocation: Bool = false
    var didSetBg: Bool = false
    
    var pod: Pod?
    var podImg: UIImage?
    var imgUrl: URL?
    var posts = [Post]()
    var latestPost: Post?
    var imgUrlStr = ""
    
    @IBOutlet weak var outCreatePod: UIButton!
    @IBOutlet weak var outAddBg: UIButton!
    
    private var datePicker : UIDatePicker?
    private var selectedDate : Date?
    
    @IBAction func actAddBg(_ sender: UIButton) {
        photoHelper.presentActionSheet(from: self)
        
        photoHelper.completionHandler = { image in
            
            //set it to the global variable so we can use this for creating pod object
            self.podImg = image
            PostService.create(for: image) { (url) in
                guard let imgURL = url else {
                    return
                }
                self.imgUrl = imgURL
                self.imgUrlStr = imgURL.absoluteString
                print("YES MOTHER FUCKER!! \(self.imgUrlStr)")
            }
            
            //set background
            self.bgImgView.image = image
            self.didSetBg = true
        }
        
        /****************
         This block allows for pulling the "posts" objects from database for that particular user
         *****************/
        
        //        UserService.posts(for: User.current) { (posts) in
        //            self.posts = posts
        //            let lastIndex = posts.count - 1
        //            if posts.count > 1 {
        //                let post = posts[lastIndex]
        //                let imgURL = URL(string: post.imageURL)
        //                self.bgImgView.kf.setImage(with: imgURL)
        //            }
        //        }
    }
    
//    func fetchCurrentUsersPosts() {
//            UserService.posts(for: User.current) { (posts) in
//            self.posts = posts
//            //let lastIndex = posts.count - 1
//
//                self.latestPost = posts.last
//                let imgURL = URL(string: (self.latestPost?.imageURL)!)
//        }
//    }
    
    @IBAction func actCreatePod(_ sender: UIButton) {
        print("Create Pod Button Pressed!")
        
        //create new pod object
        //the initialisers already generate podid & passcode
        //let newPod = Pod(ownerId: User.current.uid)
        let newPod = Pod(ownerId: User.current.uid)
        
        //check podImg is not nil get textfield values
        //remember to handle when pod does not have image
        //right now assuming all pod's need image
        guard podImg != nil, let currWhatVal = whatTextfield.text, let currWhereVal = whereTextfield.text, let currWhenVal = whenTextfield.text else {
            return
        }
        if didSetBg {

            newPod.podImgUrl = imgUrlStr
        }
        
        newPod.whatVal = currWhatVal
        newPod.whereVal = currWhereVal
        //need to handle when date is not set
        newPod.whenVal = selectedDate
        
        //check if got location set, and get MKPlaceMark
        if didSetLocation{
            newPod.locPlaceMark = selectedPlaceMark
        }
        
        if self.expireSwitch.isOn {
            newPod.willExpire = true
        } else {
            newPod.willExpire = false
        }
        
        // Create date formatter
        let dateFormatter: DateFormatter = DateFormatter()
        // Set date format
        dateFormatter.dateFormat = "MMM dd, yyyy hh:mm a"
        // Apply date format
        let selectedDateStr: String = dateFormatter.string(from: (newPod.whenVal!))
        let docStr: String = dateFormatter.string(from: (newPod.doc!))
        
        print("Congratulation! You have successfully created a pod!")
        print("These are the values: ")
        print("Pod ID: \(newPod.podId ?? "Not generating ID")")
        print("Owner ID: \(newPod.ownerId ?? "Could not get owner ID")")
        print("Passcode: \(newPod.passcode ?? "No passcode generated")")
        print("No. of Participants: \(newPod.participantsId.count)")
        print("*******************************************************")
        print("What: \(newPod.whatVal ?? "No What Filled")")
        print("Where: \(newPod.whereVal ?? "No Where Filled")")
        print("When: \(selectedDateStr)")
        print("Pod Img URL: \(newPod.podImgUrl ?? "Error in getting img URL")")
        print("Date of Creation: \(docStr)")
        print("Will Pod Expire? \(newPod.willExpire)")
        print("*******************************************************")
        
        self.pod = newPod
        print("PLEASE!!!")
        performSegue(withIdentifier: Constants.Segue.toCreatePod, sender: nil)
        
    }
    
    @IBAction func addLocation(_ sender: Any) {
        print("Add Location Button Pressed!")
        
        if selectedPlaceMark != nil {
            //if location was already set
            
            guard let currTextVal = whereTextfield.text else {
                return
            }
            
            var userText: String = ""
            
            if currTextVal != "" {
                var subdividedStringArray = currTextVal.components(separatedBy: ", @")
                userText = subdividedStringArray[0]
                
                //things to do when user toggles off the location switch
                if subdividedStringArray.count > 1 {
                    subdividedStringArray[1] = ""
                    //set PlaceMark to nil again
                    self.selectedPlaceMark = nil
                    addImageForRightView(whereTextfield, iconName: Constants.Icons.addLocation)
                }
            }
            whereTextfield.text = "\(userText)"
            didSetLocation = false
        } else {
            //if location was not yet set
            didSetLocation = true
            performSegue(withIdentifier: Constants.Segue.setUserLocation, sender: nil)
            
        }
        
    }
    
    // *************************************
    //problem is with this function
    // *************************************
    func getImageUrl() -> String{
        //var post: Post?
        var imgUrlStr: String = ""
        
        UserService.posts(for: User.current) { (posts) in
            self.posts = posts
            self.latestPost = posts.last
            imgUrlStr = (self.latestPost?.imageURL)!
            
            //this is how to create URL object with the string
            self.imgUrlStr = imgUrlStr
        }
        return imgUrlStr
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.pod = Pod(ownerId: User.current.uid)
        
        print("Passcode: \(PassGenerator().randomPassCode())")
        // Do any additional setup after loading the view.
        
        // set image for navigation header
        let logo = UIImage(named: Constants.Icons.logo)
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        
        // draw border for Textfields
        drawBorderForTextfield(whatTextfield)
        drawBorderForTextfield(whereTextfield)
        drawBorderForTextfield(whenTextfield)
        
        //corner radius for UIButton
        outCreatePod.layer.cornerRadius = 8
        outCreatePod.layer.borderWidth = 3
        let borderCol = UIColor().uicolorFromHex(rgbValue: 0x25DEB2)
        outCreatePod.layer.borderColor = borderCol.cgColor
        
        /*figure out a way to show button being pressed, check out https://stackoverflow.com/questions/48317211/programmatically-added-button-not-showing-touch-feel-in-ios
         */
        
        
        //add location button on where textfield
        addImageForRightView(whereTextfield, iconName: Constants.Icons.addLocation)
        
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .dateAndTime
        let currDate = Date()
        datePicker?.minimumDate = currDate
        whenTextfield.inputView = datePicker
        
        datePicker?.addTarget(self, action: #selector(HomeViewController.datePickerValueChanged(_:)), for: .valueChanged)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.viewTapped(gestureRecognizer:)))
        
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker){
        
        // Create date formatter
        let dateFormatter: DateFormatter = DateFormatter()
        
        // Set date format
        dateFormatter.dateFormat = "MMM dd, yyyy hh:mm a"
        
        // Apply date format
        let selectedDateStr: String = dateFormatter.string(from: sender.date)
        self.selectedDate = sender.date
        whenTextfield.text = selectedDateStr
    }
    
    func addImageForRightView(_ textField: UITextField, iconName: String) {
        let button = UIButton(type: .custom)
        
        let img: UIImage
        let colorState: UIColor
        
        if selectedPlaceMark == nil {
            colorState = UIColor().uicolorFromHex(rgbValue: 0x5B5B5B)
            img = (UIImage(named: iconName)?.imageWithColor(color1: colorState))!
        } else {
            colorState = UIColor().uicolorFromHex(rgbValue: 0x25DEB2)
            img = (UIImage(named: iconName)?.imageWithColor(color1: colorState))!
        }
        button.setImage(img, for: .normal)
        button.imageEdgeInsets = UIEdgeInsetsMake(0, -16, 0, 0)
        button.frame = CGRect(x: CGFloat(textField.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        button.addTarget(self, action: #selector(self.addLocation), for: .touchUpInside)
        textField.rightView = button
        textField.rightViewMode = .always
    }
    
    func drawBorderForTextfield(_ textField: UITextField) {
        //set bottom border for textfield
        let border = CALayer()
        let width = CGFloat(2.0)
        border.borderColor = UIColor.darkGray.cgColor
        border.frame = CGRect(x: 0, y: textField.frame.size.height - width, width: textField.frame.size.width + 30, height: textField.frame.size.height)
        
        border.borderWidth = width
        textField.layer.addSublayer(border)
        textField.layer.masksToBounds = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //self.view.setNeedsLayout()
    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == Constants.Segue.setUserLocation {
            if let destinationNavigationController = segue.destination as? UINavigationController {
                let targetController = destinationNavigationController.topViewController as! MapViewController
                targetController.userLocationDelegate = self
            }
        }
        
        else if segue.identifier == Constants.Segue.toCreatePod {
            if let destinationController = segue.destination as? UINavigationController {
                let targetController = destinationController.topViewController as! InviteViewController
                targetController.currPod = pod
                targetController.bgImg = podImg
            }
        }
    }
    
}

extension HomeViewController: HandleUserPrefLocation {
    
    func getSelectedLocation(selectedPlaceMark: MKPlacemark) {
        
        guard let title = selectedPlaceMark.title, let _ = selectedPlaceMark.name else {
            return
        }
        
        self.selectedPlaceMark = selectedPlaceMark
        
        print("***************** FINALLY! \(title) ******************")
        
        whereTextAppend = title
        guard var currTextVal = whereTextfield.text else {
            return
        }
        if currTextVal != "" {
            var subdividedStringArray = currTextVal.components(separatedBy: ", @")
            let userText = subdividedStringArray[0]
            var locationText  = ""
            
            if subdividedStringArray.count > 1 {
                subdividedStringArray[1] = whereTextAppend
                locationText = subdividedStringArray[1]
                currTextVal = "\(userText) , @ \(locationText)"
            }
            
        }
        whereTextfield.text = "\(currTextVal), @ \(whereTextAppend)"
        addImageForRightView(whereTextfield, iconName: Constants.Icons.addLocation)
    }
    
}


