//
//  ColorPalette.swift
//  PassTheLaugh

import UIKit

final class ColorPalette {
    
    let name: String
    let colors: [UIColor]
    var first: UIColor { return colors[0] }
    var second: UIColor { return colors[1] }
    var third: UIColor { return colors[2] }
    var fourth: UIColor { return colors[3] }
    var fifth: UIColor { return colors[4] }

    init(name: String, colors: [UIColor]) {
        self.colors = colors
        self.name = name
    }
    
}

extension ColorPalette {
    
    // TODO: This either belongs in Firebase (so we can add colors without updating the app) or it belongs in local file.
    // source: http://www.colourlovers.com/palettes/most-favorites/all-time/meta
    static func dummyData() -> [ColorPalette] {
        let red = UIColor.red
        let orange = UIColor.orange
        let yellow = UIColor.yellow
        let green = UIColor.green
        let blue = UIColor.blue
        let rainbow = ColorPalette(name: "Rainbow", colors: [red, orange, yellow, green, blue])
        
        let eminence = UIColor(red:0.40, green:0.27, blue:0.45, alpha:1.00)
        let finn = UIColor(red:0.40, green:0.27, blue:0.33, alpha:1.00)
        let woodland = UIColor(red:0.40, green:0.40, blue:0.27, alpha:1.00)
        let stromboli = UIColor(red:0.27, green:0.40, blue:0.33, alpha:1.00)
        let blueBayoux = UIColor(red:0.27, green:0.40, blue:0.45, alpha:1.00)
        let crayonBoxRenewed = ColorPalette(name: "Crayon Box Renewed", colors: [eminence, finn, woodland, stromboli, blueBayoux])
        
//        let firstColor = UIColor(red:0.42, green:0.82, blue:0.90, alpha:1.00)
//        let secondColor = UIColor(red:0.66, green:0.86, blue:0.84, alpha:1.00)
//        let thirdColor = UIColor(red:0.88, green:0.89, blue:0.80, alpha:1.00)
//        let jaffa = UIColor(red:0.95, green:0.53, blue:0.24, alpha:1.00)
//        let black = UIColor.blackColor()
//        let giantGoldfish = ColorPalette(name: "Giant Goldfish", colors: [firstColor, secondColor, thirdColor, jaffa, black])
        
        let rhino = UIColor(red:0.16, green:0.21, blue:0.38, alpha:1.00)
        let jungleGreen = UIColor(red:0.16, green:0.65, blue:0.50, alpha:1.00)
        let black = UIColor.black
        let white = UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.00)
        let sweetPink = UIColor(red:1.00, green:0.62, blue:0.62, alpha:1.00)
        let crayonDoodles = ColorPalette(name: "Crayon Doodles", colors: [rhino, jungleGreen, sweetPink, white, black])
        
        
        
        let marzipan = UIColor(red:0.92, green:0.82, blue:0.49, alpha:1.00)
        let velanzia = UIColor(red:0.85, green:0.37, blue:0.29, alpha:1.00)
        let oldRose = UIColor(red:0.75, green:0.18, blue:0.27, alpha:1.00)
        let blackRose = UIColor(red:0.33, green:0.15, blue:0.22, alpha:1.00)
        let breakerBay = UIColor(red:0.33, green:0.47, blue:0.48, alpha:1.00)
        let thoughtProvoking = ColorPalette(name: "Thought Provoking", colors: [marzipan, velanzia, oldRose, blackRose, breakerBay])
        
        
        let greenYello = UIColor(red:0.67, green:1.00, blue:0.18, alpha:1.00)
        let seeBuckhorn = UIColor(red:1.00, green:0.67, blue:0.16, alpha:1.00)
        let spicyPink = UIColor(red:1.00, green:0.11, blue:0.67, alpha:1.00)
        let vividViolet = UIColor(red:0.67, green:0.06, blue:0.99, alpha:1.00)
        let spiroDiscoBall = UIColor(red:0.09, green:0.67, blue:0.99, alpha:1.00)
        let neonFun = ColorPalette(name: "Neon Fun", colors: [greenYello, seeBuckhorn, spicyPink, vividViolet, spiroDiscoBall])
//        let reef = UIColor(red:0.82, green:0.95, blue:0.66, alpha:1.00)
//        let chiffron = UIColor(red:0.94, green:0.98, blue:0.72, alpha:1.00)
//        let chardenoy = UIColor(red:1.00, green:0.77, blue:0.56, alpha:1.00)
//        let vividTangerine = UIColor(red:1.00, green:0.63, blue:0.52, alpha:1.00)
//        let lightCrimson = UIColor(red:0.96, green:0.42, blue:0.57, alpha:1.00)
//        let mellonBallSurprise = ColorPalette(name: "Mellon Ball Surprise", colors: [reef, chiffron, chardenoy, vividTangerine, lightCrimson])
        
        return [rainbow, crayonDoodles, neonFun, thoughtProvoking, crayonBoxRenewed]
    }
}
