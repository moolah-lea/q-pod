//
//  PodViewController.swift
//  q-pod
//
//  Created by Murrali Ramasamy on 24/7/18.
//  Copyright © 2018 Murrali Ramasamy. All rights reserved.
//

import UIKit

//class AvatarCell: UICollectionViewCell {
//    
//    var outAvatarImgView = UIImageView()
//    
//    override func awakeFromNib() {
//        //mImage.layer.cornerradius = 5
//        //Does not work, the image is still square in the cell
//        
//    }
//    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        layoutIfNeeded()
//        outAvatarImgView.layer.cornerRadius = outAvatarImgView.frame.height/2
//    }
//    
//}


class PodViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    //fileprivate let reuseIdentifier = "choiceCell"

    @IBOutlet weak var outWhatLabel: UILabel!
    @IBOutlet weak var outWhereLabel: UILabel!
    @IBOutlet weak var outWhenLabel: UILabel!
    @IBOutlet weak var outPodImgView: UIImageView!
    @IBOutlet weak var outAskPlaceholderImg: UIImageView!
    @IBOutlet weak var outPlaceholderTxt: UILabel!
    @IBOutlet weak var outAskBn: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    //check how to populate each cell's img for collection
    //@IBOutlet weak var outAvatarImgView: UIImageView!
    
    var currPod: Pod!
    
    
    @IBAction func actAskBn(_ sender: UIButton) {
    }
    
    @IBAction func actSettingsBn(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func actQPodsBn(_ sender: UIBarButtonItem) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        guard (currPod != nil) else{
            return
        }
        
        outWhatLabel.text = currPod.whatVal
        outWhereLabel.text = currPod.whereVal
        outWhenLabel.text = currPod.whenVal?.description
        
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "podCollectionCell", for: indexPath) as! PodCollectionCell
        
        cell.displayContent(name: "NNOLAH88")
        return cell
    }
    
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "choiceCell", for: indexPath) as! AvatarCell
//        //cell.mImage.layer.cornerradius = 5
//        //Does not work, the image is still square in the cell
//
//        cell.layoutIfNeeded()
//
//        //set the image for individual collection
//        cell.outAvatarImgView = UIImageView()
//        cell.outAvatarImgView.layer.cornerRadius = cell.outAvatarImgView.frame.height/2
//
//        //remember to set image for avatar
//
//        return cell
//    }
//

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
