//
//  ViewController.swift
//  PingPong
//
//  Created by Kevin on 10/7/15.
//  Copyright © 2015 Kevin. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet var minusP2: UIButton!
    @IBOutlet var minusP1: UIButton!
    @IBOutlet var navigationBar: UINavigationBar!
    @IBOutlet var btnOne: UIButton!
    @IBOutlet var btnTwo: UIButton!
    
    var playerOne = 0;
    var playerTwo = 0;
    
    @IBOutlet var labelPlayerOne: UILabel!
    @IBOutlet var labelPlayerTwo: UILabel!
    
    var player1sound: AVAudioPlayer = AVAudioPlayer()
    var player2sound: AVAudioPlayer = AVAudioPlayer()
    let path1 = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("p1", ofType: "mp3")!)
    let path2 = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("p2", ofType: "mp3")!)

    var serving: String = "";
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        btnOne.setTitle("0", forState: .Normal)
        btnTwo.setTitle("0", forState: .Normal)
        
        validCont()
        
        let gestureP1: UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: "playerOneServing:")
        gestureP1.minimumPressDuration = 2.0
        
        let gestureP2: UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: "playerTwoServing:")
        gestureP2.minimumPressDuration = 2.0
        
        btnOne.addGestureRecognizer(gestureP1)
        btnTwo.addGestureRecognizer(gestureP2)
    
        do{
            player1sound = try AVAudioPlayer(contentsOfURL: path1)
            player2sound = try AVAudioPlayer(contentsOfURL: path2)
        } catch {
            print(error)
        }
    }
    
    func playerOneServing(sender: UITapGestureRecognizer){
        serving = "p1"
        labelPlayerOne.text = "Player One Serving"
        labelPlayerTwo.text = "Player Two Waitting"
        player1sound.play()
    }
    
    func playerTwoServing(sender: UITapGestureRecognizer){
        serving = "p2"
        labelPlayerTwo.text = "Player Tow Serving"
        labelPlayerOne.text = "Player One Waitting"
        player2sound.play()
    }
    
    func howIsServing(sum: Int){
        if sum % 2 == 0 {
            if serving == "p1" {
                serving = "p2"
                labelPlayerTwo.text = "Player Tow Serving"
                labelPlayerOne.text = "Player One Waitting"
                player2sound.play()
            } else if serving == "p2" {
                serving = "p1"
                labelPlayerOne.text = "Player One Serving"
                labelPlayerTwo.text = "Player Two Waitting"
                player1sound.play()
            }
        }
    }
    
    func validCont(){
        if playerOne == 0 && playerTwo == 0 {
            minusP2?.enabled = false
            minusP1?.enabled = false
        }
    }
    
    @IBAction func minusP1(sender: AnyObject) {
        playerOne -= 1;
        btnOne.setTitle(String(playerOne), forState: .Normal)
        if playerOne < 1 {
            minusP1?.enabled = false
        }
    }
    
    @IBAction func minusP2(sender: AnyObject) {
        playerTwo -= 1;
        btnTwo.setTitle(String(playerTwo), forState: .Normal)
        if playerTwo < 1 {
            minusP2?.enabled = false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnOnePlus(sender: AnyObject) {
        playerOne += 1;
        btnOne.setTitle(String(playerOne), forState: .Normal)
        minusP1?.enabled = true
        howIsServing(playerOne + playerTwo)
        howIsTheWinner(playerOne, playerTwo: playerTwo)
    }

    @IBAction func btnTwoPlus(sender: AnyObject) {
        playerTwo += 1;
        btnTwo.setTitle(String(playerTwo), forState: .Normal)
        minusP2?.enabled = true
        howIsServing(playerOne + playerTwo)
        howIsTheWinner(playerOne, playerTwo: playerTwo)
    }
    
    @IBAction func reset(sender: AnyObject) {
      resetMacth()
    }
    
    func resetMacth(){
        playerOne = 0;
        playerTwo = 0;
        btnOne.setTitle("0", forState: .Normal)
        btnTwo.setTitle("0", forState: .Normal)
        serving = ""
        labelPlayerTwo.text = "Player Two"
        labelPlayerOne.text = "Player One"
        validCont()
    }
    
    func howIsTheWinner(playerOne : Int, playerTwo: Int){
        
        if playerOne >= 10 && playerTwo >= 10 {
            if playerOne - playerTwo == 2 {
                showAlert("Player One Won")
            } else if playerTwo - playerOne == 2{
                showAlert("Player Two Won")
            }
        } else {
            if playerOne > 10 {
                showAlert("Player One Won")
            } else if playerTwo > 10 {
                showAlert("Player Two Won")
            } else if playerOne == 6 && playerTwo == 0 {
                showAlert("Player Two Won by knockout")
            } else if playerOne == 0 && playerTwo == 6 {
                showAlert("Player Two Won by knockout")
            }
        }
        
    }
    
    func showAlert(msg : String){
        let alert = UIAlertController(title: "Oops!", message: msg, preferredStyle: .Alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (alert : UIAlertAction) -> Void in
            self.resetMacth()
        }))
            
        presentViewController(alert, animated: true, completion: nil)
    }

}

