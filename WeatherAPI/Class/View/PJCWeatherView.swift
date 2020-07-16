//
//  PJCWeatherView.swift
//  WeatherAPI
//
//  Created by Peter Spencer on 14/07/2020.
//  Copyright © 2020 Peter Spencer. All rights reserved.
//

import UIKit
import WebKit


class PJCWeatherView: UIView
{
    // MARK: - Property(s)
    
    private(set) lazy var locationLabel: UILabel =
    {
        let anObject = UILabel(frame: .zero)
        anObject.font = UIFont(name: "HelveticaNeue-Light", size: 25)
        anObject.textAlignment = .center
        anObject.textColor = .white
        
        self.addSubview(anObject)
        return anObject
    }()
    
    private(set) lazy var webView: WKWebView =
    {
        let anObject = WKWebView(frame: .zero)
        anObject.isUserInteractionEnabled =  false
        anObject.isOpaque = false
        
        self.addSubview(anObject)
        return anObject
    }()
    
    private(set) lazy var temperatureLabel: UILabel =
    {
        let anObject = UILabel(frame: .zero)
        anObject.font = UIFont(name: "HelveticaNeue-UltraLight", size: 75)
        anObject.textAlignment = .center
        anObject.textColor = .white
        
        self.addSubview(anObject)
        return anObject
    }()
    
    private(set) lazy var dateLabel: UILabel =
    {
        let anObject = UILabel(frame: .zero)
        anObject.font = UIFont(name: "HelveticaNeue-Light", size: 25)
        anObject.textAlignment = .center
        anObject.textColor = .white
        
        self.addSubview(anObject)
        return anObject
    }()
    
    
    // MARK: - Creating a View Object
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        self.layoutMargins = UIEdgeInsets(top: 48, left: 24, bottom: 48, right: 24)
        self.backgroundColor = .black
        
        self.updateLayout(nil)
    }
    
    required init?(coder: NSCoder)
    { fatalError("init(coder:) has not been implemented") }
}

// MARK: - PJCGeometryLayout
extension PJCWeatherView: PJCGeometryLayout
{
    func updateLayout(_ container: UIView?)
    {
        let guide = self.layoutMarginsGuide
        let height: CGFloat = self.bounds.height * 0.23
        
        self.webView.translatesAutoresizingMaskIntoConstraints = false
        self.webView.centerXAnchor.constraint(equalTo: guide.centerXAnchor).isActive = true
        self.webView.centerYAnchor.constraint(equalTo: guide.centerYAnchor, constant: -75).isActive = true
        self.webView.widthAnchor.constraint(equalToConstant: self.bounds.width).isActive = true
        self.webView.heightAnchor.constraint(equalToConstant: height).isActive = true
        
        self.locationLabel.sizeToFit()
        self.locationLabel.translatesAutoresizingMaskIntoConstraints = false
        self.locationLabel.centerXAnchor.constraint(equalTo: guide.centerXAnchor).isActive = true
        self.locationLabel.topAnchor.constraint(equalTo: guide.topAnchor, constant: 0).isActive = true
        
        self.temperatureLabel.sizeToFit()
        self.temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        self.temperatureLabel.centerXAnchor.constraint(equalTo: guide.centerXAnchor).isActive = true
        self.temperatureLabel.topAnchor.constraint(equalTo: self.webView.bottomAnchor, constant: 0).isActive = true
        
        self.dateLabel.sizeToFit()
        self.dateLabel.translatesAutoresizingMaskIntoConstraints = false
        self.dateLabel.centerXAnchor.constraint(equalTo: guide.centerXAnchor).isActive = true
        self.dateLabel.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: 0).isActive = true
    }
}

