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
    var messages = [EMMessage]()
    
    @IBOutlet var textbox: UITextField!
    @IBOutlet var textView: UITextView!
    
    override func viewDidLoad() {
        textView.userInteractionEnabled = true
        super.viewDidLoad()
        EaseMob.sharedInstance().chatManager.addDelegate(self, delegateQueue: nil)
        for message in messages {
            var chatter = message.conversation.chatter
            var messageBody = message.messageBodies.first as EMTextMessageBody
            var messageStr = messageBody.text
            if chatter == friendName {
                textView.text.write("\(chatter): \(messageStr)\n\n")
            }
            else {
                textView.text.write("我: \(messageStr)\n\n")
            }
        }
    }
    @IBAction func sendMessage(sender: AnyObject) {
        var text = textbox.text
        if (text != "") {
            var emText = EMChatText(text: text)
            
            var emTextMessageBody = EMTextMessageBody(chatObject: emText)
            var msg = EMMessage(receiver: friendName, bodies: [emTextMessageBody])
            EaseMob.sharedInstance().chatManager.sendMessage(msg, progress: nil, error: nil)
            textView.text.write("我: \(text)")
        }
    }
    
    func didReceiveMessage(message: EMMessage) {
        var chatter = message.conversation.chatter
        if chatter == friendName {
            var messageBody = message.messageBodies.first as EMTextMessageBody
            var messageStr = messageBody.text
            textView.text.write("\(chatter): \(messageStr)\n\n")
        }
    }
}
