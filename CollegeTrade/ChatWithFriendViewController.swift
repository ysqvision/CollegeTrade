//
//  ChatWithFriendViewController.swift
//  CollegeTrade
//
//  Created by Shaoqing Yang on 10/28/14.
//  Copyright (c) 2014 Shaoqing Yang. All rights reserved.
//

import UIKit

protocol chatProtocol {
    func receivedMessage(message: EMMessage)
    
    func receivedBuddyRequest(username: String, message: String)
}

class ChatWithFriendViewController: UIViewController, IChatManagerDelegate {
    
    var friendName: String!
    var messages = [EMMessage]()
    
    var cnt:Int = 0
    
    var delegate: chatProtocol!
    
    @IBOutlet var textbox: UITextField!
    @IBOutlet var textView: UITextView!
    
    override func viewDidLoad() {
        textView.editable = false
        textView.userInteractionEnabled = true
        
        super.viewDidLoad()
        EaseMob.sharedInstance().chatManager.addDelegate(self, delegateQueue: nil)
        
        cnt = 0
        for message in messages {
            var messageBody = message.messageBodies.first as EMTextMessageBody
            var messageStr = messageBody.text
            if message.ext != nil {
                var exten = message.ext as [String: String]
                var name : String = exten["username"]! as String
                cnt = cnt + 1
                if name == friendName {
                    println(name)
                    textView.text.write("\(name): \(messageStr)\n\n")
                }
                else {
                    textView.text.write("我: \(messageStr)\n\n")
                }

            }
        }
        textView.scrollRangeToVisible(NSRange(location: countElements(textView.text), length: 0))
    }
    @IBAction func sendMessage(sender: AnyObject) {
        var text = textbox.text
        if (text != "") {
        
            var emText = EMChatText(text: text)
            
            var emTextMessageBody = EMTextMessageBody(chatObject: emText)
            var msg = EMMessage(receiver: friendName, bodies: [emTextMessageBody])
            var userName = LOGGED_IN_USER_INFORMATION!["userName"] as String
            var exten = ["username": userName]
            msg.ext = exten
            EaseMob.sharedInstance().chatManager.sendMessage(msg, progress: nil, error: nil)
            
            textView.text.write("我: \(text)\n\n")
            textbox.text = ""
        }
        //cnt = cnt + 1
               
        textView.scrollRangeToVisible(NSRange(location: countElements(textView.text), length: 0))
        //let range:NSRange = NSRange(location:cnt - 1, length: 0)
        //textView.scrollRangeToVisible(range)
    }
    
    func didReceiveMessage(message: EMMessage) {
        var chatter = message.conversation.chatter
        cnt = cnt + 1
        if chatter == friendName {
            var messageBody = message.messageBodies.first as EMTextMessageBody
            var messageStr = messageBody.text
            textView.text.write("\(chatter): \(messageStr)\n\n")
        } else {
            self.delegate.receivedMessage(message)
        }

    }
    
    func didReceiveBuddyRequest(username: String!, message: String!) {
        self.delegate.receivedBuddyRequest(username, message: message)
    }
    
}
