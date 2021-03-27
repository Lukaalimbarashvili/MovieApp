//
//  File.swift
//  MovieApp
//
//  Created by Lucas on 10/9/20.
//
import UIKit

extension String {
    func downloadImage( completion: @escaping (UIImage?) -> ()) {
    guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(self)") else {return}
    URLSession.shared.dataTask(with: url) { (data, res, err) in
      guard let data = data else {return}
      completion(UIImage(data: data))
    }.resume()
  }
}


extension NSLayoutConstraint {

    override public var description: String {
        let id = identifier ?? ""
        return "id: \(id), constant: \(constant)" 
    }
}

extension UIImageView {
    func gradient(firstColor: UIColor, secondColor: UIColor){
        let gradient = CAGradientLayer()
        gradient.frame = self.frame
        gradient.colors = [firstColor.cgColor,secondColor.cgColor]
        gradient.locations = [0.0,1.0]
        self.layer.insertSublayer(gradient, at: 0)

    }
}

extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }

        return nil
    }
}

