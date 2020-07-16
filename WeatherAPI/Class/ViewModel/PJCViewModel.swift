//
//  PJCViewModel.swift
//  WeatherAPI
//
//  Created by Peter Spencer on 15/07/2020.
//  Copyright © 2020 Peter Spencer. All rights reserved.
//

import Foundation


protocol PJCViewModelInitialiser
{
    associatedtype ModelType
    
    var model: ModelType { get }
    
    init(_ model: ModelType)
}

protocol PJCViewModelProvider
{
    associatedtype ViewModelType: PJCViewModelInitialiser
    
    func viewModel(forObjectAt index: Int) -> ViewModelType?
}

class PJCViewModel<T>: PJCViewModelInitialiser
{
    private(set) var model: T
    
    required init(_ model: T)
    { self.model = model }
}

