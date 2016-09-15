//
//  FriendViewControllerDelegate.swift
//  Friends
//
//  Created by Philip on 9/15/16.
//  Copyright © 2016 Philip Vo. All rights reserved.
//

import Foundation

protocol AddViewControllerDelegate: class {
    func addViewController(controller: AddViewController, didFinishAddingFriend friend: [String])
    func addViewController(controller: AddViewController, didFinishEditingFriend friend: Friend)

}