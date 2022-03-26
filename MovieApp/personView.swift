//
//  personView.swift
//  MovieApp
//
//  Created by Marin on 25.03.2022..
//

import UIKit
import SnapKit

class personView: UIView{
    var personName: UILabel!
    var personRole: UILabel!

    weak var delegate: MovieDetailsViewController?
    
    init(){
        super.init(frame: CGRect.zero)
        
        personName = UILabel()
        personRole = UILabel()
        self.backgroundColor = .yellow
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setInfo(name: String, role: String){
        personName.text = name
        personRole.text = role
        
        personName.font = UIFont.systemFont(ofSize: 14, weight: .black)
        personRole.font = UIFont.systemFont(ofSize: 14)
        
        self.setNeedsDisplay()
    }  
}

protocol updatePersonView{
    func setInfo(name: String, role: String)
}
