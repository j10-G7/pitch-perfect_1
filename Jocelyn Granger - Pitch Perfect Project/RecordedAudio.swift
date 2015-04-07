//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Jocelyn Granger on 4/6/15.
//  Copyright (c) 2015 Jocelyn Granger. All rights reserved.
//


import Foundation

class RecordedAudio: NSObject {
    var filePathUrl: NSURL!
    var title: String!
    
    func recordedAudioInit(in_filePathURL: NSURL, in_title: String) {
        self.filePathUrl = in_filePathURL
        self.title = in_title
    }
}
