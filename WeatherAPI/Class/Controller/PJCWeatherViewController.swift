//
//  PJCWeatherViewController.swift
//  WeatherAPI
//
//  Created by Peter Spencer on 14/07/2020.
//  Copyright © 2020 Peter Spencer. All rights reserved.
//

import UIKit


class PJCWeatherViewController: UIViewController
{
    // MARK: - Property(s)
    
    private(set) lazy var api: PJCCurrentWeatherAPI =
    {
        let configuration = URLSessionConfiguration.named("com.weather-api.cache")
        let session = URLSession(configuration: configuration)
        let service = PJCDataService(session: session)
        
        return PJCCurrentWeatherAPI(service)
    }()
    
    
    // MARK: - Managing the View
    
    override func loadView()
    {
        self.view = PJCWeatherView(frame: UIScreen.main.bounds)
        
        self.viewRespectsSystemMinimumLayoutMargins = false
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh,
                                                                 target: self,
                                                                 action: #selector(refresh(_:)))
    }
    
    
    // MARK: - Responding to View Events
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        self.refresh(nil)
    }
}

// MARK: - Action(s)
extension PJCWeatherViewController
{
    @IBAction func refresh(_ sender: Any?)
    {
        self.api.request(for: .london)
        { (result) in
            
            guard let currentWeather = try? result.get().objects.first,
                let view = self.view as? PJCWeatherView else
            { return }
            
            let viewModel = PJCWeatherViewModel(currentWeather)
            
            view.backgroundColor = viewModel.color
            view.locationLabel.text = viewModel.location
            view.temperatureLabel.text = viewModel.tempurature
            view.dateLabel.text = viewModel.date
            
            if let request = viewModel.request
            { view.webView.load(request) }
        }
    }
}

