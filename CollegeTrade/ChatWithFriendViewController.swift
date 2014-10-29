//
//  ChatWithFriendViewController.swift
//  CollegeTrade
//
//  Created by Shaoqing Yang on 10/28/14.
//  Copyright (c) 2014 Shaoqing Yang. All rights reserved.
//

import UIKit

class ChatWithFriendViewController: UIViewController, IChatManagerDelegate {
    
    var friendName: String!
    
    @IBOutlet var textbox: UITextField!
    @IBOutlet var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        EaseMob.sharedInstance().chatManager.addDelegate(self, delegateQueue: nil)
    }
    @IBAction func sendMessage(sender: AnyObject) {
        var text = textbox.text
        if (text != "") {
            var emText = EMChatText(text: text)
            
            var emTextMessageBody = EMTextMessageBody(chatObject: emText)
            var msg = EMMessage(receiver: friendName, bodies: [emTextMessageBody])
            EaseMob.sharedInstance().chatManager.sendMessage(msg, progress: nil, error: nil)
        }
    }
    
    func didReceiveMessage(message: EMMessage) {
        println(message)
        println(message.conversation.chatter)
        println(message.messageBodies)
        textView.text.write("\(message)\n\n")
    }
}
