//
//  MVLocalizable.swift
//  Movies
//
//  Created by Rubens Pessoa on 4/26/18.
//  Copyright © 2018 Ilhasoft. All rights reserved.
//

import Foundation
import UIKit

class MVLocalizable {
    /**
     * Add item here in alphabetic order
     */
    enum LocalizedText: String {
        case begin
        case collect
        case collectDescription = "collect_description"
        case direction
        case duration
        case genre
        case login
        case mainActors = "main_actors"
        case movie
        case movieDescription = "movie_description"
        case oops
        case release
        case soundTrack = "sound_track"
        case synopsis
        case technicalSheet = "technical_sheet"
        case title
        case tryAgain = "try_again"
    }
}

func localizedString(_ localizedText: MVLocalizable.LocalizedText) -> String {
    return NSLocalizedString(localizedText.rawValue, comment: "")
}

func localizedString(_ localizedText: MVLocalizable.LocalizedText, andNumber number: Int) -> String {
    let format = localizedString(localizedText)
    return String(format: format, arguments: [number])
}

func localizedString(_ localizedText: MVLocalizable.LocalizedText, andText text: String) -> String {
    let format = localizedString(localizedText)
    return String(format: format, arguments: [text])
}
