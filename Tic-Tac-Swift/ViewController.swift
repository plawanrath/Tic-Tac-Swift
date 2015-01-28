//
//  ViewController.swift
//  Tic-Tac-Swift
//
//  Created by Plawan Rath on 27/01/15.
//  Copyright (c) 2015 Plawan Rath. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var TicTacImg1: UIImageView!
    @IBOutlet var TicTacImg2: UIImageView!
    @IBOutlet var TicTacImg3: UIImageView!
    @IBOutlet var TicTacImg4: UIImageView!
    @IBOutlet var TicTacImg5: UIImageView!
    @IBOutlet var TicTacImg6: UIImageView!
    @IBOutlet var TicTacImg7: UIImageView!
    @IBOutlet var TicTacImg8: UIImageView!
    @IBOutlet var TicTacImg9: UIImageView!
    
    @IBOutlet var TicTacBtn1: UIButton!
    @IBOutlet var TicTacBtn2: UIButton!
    @IBOutlet var TicTacBtn3: UIButton!
    @IBOutlet var TicTacBtn4: UIButton!
    @IBOutlet var TicTacBtn5: UIButton!
    @IBOutlet var TicTacBtn6: UIButton!
    @IBOutlet var TicTacBtn7: UIButton!
    @IBOutlet var TicTacBtn8: UIButton!
    @IBOutlet var TicTacBtn9: UIButton!
    
    @IBOutlet var resetBtn: UIButton!
    @IBOutlet var UserMessage: UILabel!
    
    var plays = Dictionary<Int,Int>()
    var done = false
    var aiDeciding = false
    
    @IBAction func UIBottonClicked(sender: UIButton) {
        UserMessage.hidden = true
        if (plays[sender.tag] != 0 || plays[sender.tag] != 1) && aiDeciding == false && done == false {
            setImageForSpot(sender.tag, player:1)
        }

/*        UserMessage.hidden = false
        UserMessage.text = "Button \(sender.tag) Clicked"
        TicTacImg1.image = UIImage(named: "x")*/
        checkForWin()
        aiTurn()
    }
    
    func setImageForSpot(spot: Int, player: Int) {
        var playerMark = player == 1 ? "x" : "o"
        plays[spot] = player
//        UserMessage.hidden = false
//        UserMessage.text = "Button \(spot) player \(player) playerMark \(playerMark)."
        switch spot {
        case 1:
            TicTacImg1.image = UIImage(named: playerMark)
        case 2:
            TicTacImg2.image = UIImage(named: playerMark)
        case 3:
            TicTacImg3.image = UIImage(named: playerMark)
        case 4:
            TicTacImg4.image = UIImage(named: playerMark)
        case 5:
            TicTacImg5.image = UIImage(named: playerMark)
        case 6:
            TicTacImg6.image = UIImage(named: playerMark)
        case 7:
            TicTacImg7.image = UIImage(named: playerMark)
        case 8:
            TicTacImg8.image = UIImage(named: playerMark)
        case 9:
            TicTacImg9.image = UIImage(named: playerMark)
        default:
            TicTacImg9.image = UIImage(named: playerMark)
        }
    }
    
    func reset() {
        plays = [:]
        TicTacImg1.image = nil
        TicTacImg2.image = nil
        TicTacImg3.image = nil
        TicTacImg4.image = nil
        TicTacImg5.image = nil
        TicTacImg6.image = nil
        TicTacImg7.image = nil
        TicTacImg8.image = nil
        TicTacImg9.image = nil
    }
    
    @IBAction func resetButtonClicked(sender: UIButton) {
        done = false
        resetBtn.hidden = true
        UserMessage.hidden = true
        reset()
    }
    
    func checkForWin() {
        var whoWon = ["I":0,"you":1]
        for(key,value) in whoWon {
            var found = 0
            if plays[7] == value && plays[8] == value && plays[9] == value {
                found = 1
            }
            else if plays[4] == value && plays[5] == value && plays[6] == value {
                found = 1
            }
            else if plays[1] == value && plays[2] == value && plays[3] == value {
                found = 1
            }
            else if plays[1] == value && plays[4] == value && plays[7] == value {
                found = 1
            }
            else if plays[2] == value && plays[5] == value && plays[8] == value {
                found = 1
            }
            else if plays[1] == value && plays[5] == value && plays[9] == value {
                found = 1
            }
            else if plays[3] == value && plays[5] == value && plays[7] == value {
                found = 1
            }
            else if plays[3] == value && plays[6] == value && plays[9] == value {
                found = 1
            }
            
            if found == 1 {
                UserMessage.hidden = false
                UserMessage.text = "Looks like \(key) has won"
                resetBtn.hidden = false
                done = true
            }
        }
    }
    
    func checkBottom(#value: Int) -> (location: String,pattern:String) {
        return ("bottom",checkFor(value, inList: [7,8,9]))
    }
    func checkTop(#value: Int) -> (location: String,pattern:String) {
        return ("top",checkFor(value, inList: [1,2,3]))
    }
    func checkLeft(#value: Int) -> (location: String,pattern:String) {
        return ("left",checkFor(value, inList: [1,4,7]))
    }
    func checkRight(#value: Int) -> (location: String,pattern:String) {
        return ("right",checkFor(value, inList: [3,6,9]))
    }
    func checkMiddleDown(#value: Int) -> (location: String,pattern:String) {
        return ("middleVert",checkFor(value, inList: [2,5,8]))
    }
    func checkMiddleAcross(#value: Int) -> (location: String,pattern:String) {
        return ("middleHorz",checkFor(value, inList: [4,5,6]))
    }
    func checkDiagLeftRight(#value: Int) -> (location: String,pattern:String) {
        return ("diagLeftRight",checkFor(value, inList: [3,5,7]))
    }
    func checkDiagRightLeft(#value: Int) -> (location: String,pattern:String) {
        return ("diagRightLeft",checkFor(value, inList: [1,5,9]))
    }

    func checkFor(value: Int, inList: [Int]) -> String {
        var conclusion = ""
        for cell in inList {
            if plays[cell] == value {
                conclusion += "1"
            } else {
                conclusion += "0"
            }
        }
        return conclusion
    }
    
    func rowCheck(#value: Int) -> (location: String,pattern: String)? {
        var acceptableFinds = ["011","110","101"]
        var findFuncs = [checkTop,checkBottom,checkLeft,checkRight,checkMiddleAcross,checkMiddleDown,checkDiagLeftRight,checkDiagRightLeft]
        for algorithm in findFuncs {
            var algResults = algorithm(value:value)
            if (find(acceptableFinds,algResults.pattern) != nil) {
                return algResults
            }
        }
        return nil
    }
    
    func isOccupied(spot: Int) -> Bool {
        if(plays[spot] != nil) {
            return true
        }
        else {
            return false
        }
    }
    
    func aiTurn() {
        if done == true {
            return
        }
        
        aiDeciding = true
        
        //The computer has 2 in a row
        if let result = rowCheck(value:0) {
            var whereToPlayResult = whereToPlay(result.location,pattern: result.pattern)
            if !isOccupied(whereToPlayResult) {
                setImageForSpot(whereToPlayResult, player: 0)
                aiDeciding = false
                checkForWin()
                return
            }
        }

        //The Player has 2 in a row
        if let result = rowCheck(value:1) {
            var whereToPlayResult = whereToPlay(result.location,pattern: result.pattern)
            if !isOccupied(whereToPlayResult) {
                setImageForSpot(whereToPlayResult, player: 0)
                aiDeciding = false
                checkForWin()
                return
            }
        }

        //is center available?
        if !isOccupied(5) {
            setImageForSpot(5, player: 0)
            aiDeciding = false
            checkForWin()
            return
        }
        
        func firstAvailable(#isCorner: Bool) -> Int? {
            var spots = isCorner ? [1,3,7,9] : [2,4,6,8]
            for spot in spots {
                if !isOccupied(spot) {
                    return spot
                }
            }
            return nil
        }
        
        // is a corner available
        if let cornerAvailable = firstAvailable(isCorner: true) {
            setImageForSpot(cornerAvailable, player: 0)
            aiDeciding = false
            checkForWin()
            return
        }
        
        if let sideAvailable = firstAvailable(isCorner: false) {
            setImageForSpot(sideAvailable, player: 0)
            aiDeciding = false
            checkForWin()
            return
        }
        
        //is a side available
        
        UserMessage.hidden = false
        UserMessage.text = "Looks like it was a tie"
        
        resetBtn.hidden = false
        done = true
        
        aiDeciding = false
        
    }
    
    
    func whereToPlay(location: String,pattern: String) -> Int {
        var leftPattern = "011"
        var rightPattern = "110"
        var middlePattern = "101"
        
        switch location {
            case "top":
                if pattern == leftPattern {
                    return 1
                } else if pattern == rightPattern {
                    return 3
                } else {
                    return 2
            }
        case "bottom":
            if pattern == leftPattern {
                return 7
            } else if pattern == rightPattern {
                return 9
            } else {
                return 8
            }
        case "left":
            if pattern == leftPattern {
                return 1
            } else if pattern == rightPattern {
                return 7
            } else {
                return 4
            }
        case "right":
            if pattern == leftPattern {
                return 3
            } else if pattern == rightPattern {
                return 9
            } else {
                return 6
            }
        case "MiddleVert":
            if pattern == leftPattern {
                return 2
            } else if pattern == rightPattern {
                return 8
            } else {
                return 5
            }
        case "MiddleHorz":
            if pattern == leftPattern {
                return 4
            } else if pattern == rightPattern {
                return 6
            } else {
                return 5
            }
        case "diagRightLeft":
            if pattern == leftPattern {
                return 3
            } else if pattern == rightPattern {
                return 7
            } else {
                return 5
            }
        case "diagLeftRight":
            if pattern == leftPattern {
                return 1
            } else if pattern == rightPattern {
                return 9
            } else {
                return 5
            }
        default: return 4
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

