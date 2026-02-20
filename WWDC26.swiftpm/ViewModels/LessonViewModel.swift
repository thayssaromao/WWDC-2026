//
//  File.swift
//  My App
//
//  Created by Thayssa Romão on 06/02/26.
//

import SwiftUI

final class LessonViewModel: ObservableObject {
    let lesson: Lesson
    
    init(lesson: Lesson) {
        self.lesson = lesson
    }
}
