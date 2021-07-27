//
//  LocationPickVC.swift
//  udc
//
//  Created by 도로맥 on 2021/07/27.
//

import Foundation
import UIKit
import NMapsMap
import PromiseKit
import Bagel

class LocationPickVC : EXViewController{
    
    @objc var closeTapHandler: (() -> Void)?
    
    private lazy var centerImageView : UIImageView = {
        
        let v = UIImageView(named:"camera")
        v.translatesAutoresizingMaskIntoConstraints = false
        
        return v
    }()
    
    private lazy var curAddressLabel : UILabel = {
        
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .white
        v.text = "지도를 검색해주세요"
        
        return v
    }()
    
    private lazy var confirmButton : RoundButton = {
        let v = RoundButton(heightType: .Height36)
        v.translatesAutoresizingMaskIntoConstraints = false
        v.text = "확인"
        v.isHidden = true
        
        return v
    }()
    
    private lazy var closeButton : UIImageView = {
        let v = UIImageView(named:"close")
        v.isUserInteractionEnabled = true
        v.translatesAutoresizingMaskIntoConstraints = false
        v.widthAnchor.constraint(equalToConstant: 30).isActive = true
        v.heightAnchor.constraint(equalToConstant: 30).isActive = true
        v.contentMode = .scaleAspectFit
        v.image = v.image!.withRenderingMode(.alwaysTemplate)
        v.tintColor = .black
        v.addGestureRecognizer(self.tapCloseGesture)
        
        return v
    }()
    
    private lazy var tapCloseGesture : UITapGestureRecognizer = {
        let tap = UITapGestureRecognizer(target: self, action: #selector(closeTapped(_:)))
        return tap
    }()
    
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = .white

        configureTPNavigationBar()
        
        initMapView()
        initView()
        
        
        debugE("MapVC")
    }
    
    private func initView() {
        
        closeTapHandler = { [unowned self] in
            debugE("close tap handler")
            self.dismiss(animated: true, completion: nil)
        }
    }
    private func initMapView() {
        
        let mapView = NMFMapView(frame: view.frame)
        mapView.addCameraDelegate(delegate: self)
        

        view.addSubview(mapView)
        
        let views = [
            "closeButton" :closeButton,
            "centerImageView" : centerImageView,
            "confirmButton" : confirmButton,
            "curAddressLabel" :curAddressLabel
        ]
        
        view.addSubviews(closeButton,centerImageView, confirmButton, curAddressLabel)
        
        view.addConstraints("V:|-40-[closeButton]", views: views)
        view.addConstraints("H:[closeButton]-30-|",views:views)
        view.addConstraints("H:|-16-[confirmButton]-16-|", views :views )
 
        view.addConstraints("V:[curAddressLabel(45)]-15-[confirmButton(45)]|",views: views )
        centerImageView.activateCenterConstraints(to: view)
        curAddressLabel.activateCenterXConstraint(to: view)
        
    }
    
    private func getAddresByLocation ( longitude : Double, latitude : Double) {
        NaverMap.getAddressByLocation(latitude :latitude, longitude : longitude ).done { response in
            
            debugE(response.status?.message)
            if ( response.status?.name ==  "ok") {
                let address = response.results?[0]
                let curAddress : String = "\(address?.region?.area1?.name) \(address?.region?.area2?.name) \(address?.region?.area3?.name) \(address?.region?.area4?.name) \(address?.land?.name) \(address?.land?.number1)"
                self.curAddressLabel.text = curAddress
                
                self.confirmButton.isHidden = false
            }
            else {
                
                self.curAddressLabel.text = "좀 더 줌을 땡겨서 정확한 주소를 찾아주세요!"
                self.confirmButton.isHidden = true
            }
            
        
        }.catch {[unowned self] e in
            debugE(e)
        }.finally {
         
        }
        
    }
    
    @objc func closeTapped (_ sender :UITapGestureRecognizer) {
        closeTapHandler?()
    }
}

extension LocationPickVC : NMFMapViewCameraDelegate {
    

    func mapView(_ mapView: NMFMapView, cameraIsChangingByReason reason: Int) {
        getAddresByLocation(longitude : mapView.longitude, latitude : mapView.latitude)
    }

}
