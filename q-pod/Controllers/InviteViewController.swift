//
//  InviteViewController.swift
//  q-pod
//
//  Created by Murrali Ramasamy on 20/7/18.
//  Copyright © 2018 Murrali Ramasamy. All rights reserved.
//

import UIKit

class InviteViewController: UIViewController {
    
    weak var currPod: Pod?
    weak var bgImg: UIImage?
    
    @IBOutlet weak var outSecretKey: UILabel!
    @IBOutlet weak var outInviteMsg: UITextView!
    @IBOutlet weak var outGotoPod: UIButton!
    @IBOutlet weak var bgImgView: UIImageView!
    
    @IBAction func actGotoPod(_ sender: UIButton) {
        print("*********************** GO TO YOUR POD! ***********************")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let borderCol = UIColor().uicolorFromHex(rgbValue: 0x25DEB2)
        
        // set image for navigation header
        let logo = UIImage(named: Constants.Icons.logo)
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        
        if bgImg != nil {
            self.bgImgView.image = bgImg
        }
        
        
        
        
        //corner radius for UIButton
        outGotoPod.layer.cornerRadius = 8
        outGotoPod.layer.borderWidth = 3
        outGotoPod.layer.borderColor = borderCol.cgColor
        
        // Create date formatter
        let dateFormatter: DateFormatter = DateFormatter()
        // Set date format
        dateFormatter.dateFormat = "MMM dd, yyyy hh:mm a"
        // Apply date format
        let eventDateStr: String = dateFormatter.string(from: (currPod?.whenVal)!)
        //generate the invite message
        let inviteMsg = "Hey guys, Planning a \(currPod?.whatVal ?? "What Value") at \(currPod?.whereVal ?? "Where Value") - on \(eventDateStr). Join if you can make it, via this link, http://q.pod/moolah/event238"
        
        //set the passcode field to non-editable
        outSecretKey.text = currPod?.passcode?.uppercased()
        
        outInviteMsg.layer.cornerRadius = 8
        outInviteMsg.layer.borderWidth = 1
        outInviteMsg.layer.borderColor = borderCol.cgColor
        outInviteMsg.text = inviteMsg
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
