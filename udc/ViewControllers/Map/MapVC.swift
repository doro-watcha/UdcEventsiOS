//
//  MapVC.swift
//  udc
//
//  Created by 도로맥 on 2021/05/26.
//

import Foundation
import UIKit
import NMapsMap


class MapVC : EXViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = .white

        configureTPNavigationBar()
        
        initMapView()
        
        debugE("MapVC")
    }
    
    private func initMapView() {
        
        let mapView = NMFMapView(frame: view.frame)
        view.addSubview(mapView)
    }
    
}
