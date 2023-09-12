//
//  PlayerView.swift
//  contrast
//
//  Created by Александра Орлова on 10.07.2023.
//

import UIKit
import AVFoundation

final class PlayerView: UIView {
    override static var layerClass: AnyClass {
        return AVPlayerLayer.self
    }

    var playerLayer: AVPlayerLayer {
        return layer as! AVPlayerLayer
    }

    var player: AVPlayer? {
        get {
            return playerLayer.player
        }
    
        set {
            playerLayer.player = newValue
        }
    }
}
