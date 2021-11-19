//
//  RatingViewController.swift
//  Movies
//
//  Created by Muhammed Shabeer on 19/11/21.
//

import UIKit

class RatingViewController: UIViewController {
    private let viewModel: RatingViewModel
    let progressLayer = CAShapeLayer()
    @IBOutlet weak var holderView: UIView!
    
    @IBOutlet weak var percentageLabel: UILabel!
    // MARK: initialization
    init(viewModel: RatingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupRatingAndAnimate()
    }
    
    @IBAction func closeButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupRatingAndAnimate() {
        let trackLayer = CAShapeLayer()
        let position = holderView.convert(CGPoint.zero, to: self.view)
        let x = position.x + holderView.bounds.width/2
        let y = position.y + holderView.bounds.height/2
        let path = UIBezierPath(arcCenter: CGPoint(x: x, y: y), radius: 80, startAngle: -CGFloat.pi/2, endAngle: 1.5 * CGFloat.pi, clockwise: true)
        trackLayer.path = path.cgPath
        trackLayer.strokeColor = UIColor.lightGray.cgColor
        trackLayer.lineWidth = 10
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.strokeEnd = 1
        view.layer.addSublayer(trackLayer)
        progressLayer.path = path.cgPath
        progressLayer.strokeColor = UIColor.darkGray.cgColor
        progressLayer.lineWidth = 10
        progressLayer.strokeEnd = 0
        progressLayer.lineCap = CAShapeLayerLineCap.round
        progressLayer.fillColor = UIColor.clear.cgColor
        view.layer.addSublayer(progressLayer)
        animate()
    }
    
    func animate() {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = viewModel.getRatingInDouble()
        animation.duration = 1.5
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.isRemovedOnCompletion = false
        progressLayer.strokeEnd =  CGFloat(viewModel.getRatingInDouble())
        progressLayer.add(animation, forKey: "animate")
    }
        
    func setupUI() {
        StyleKit.applyRoundCornersAndShadowAroundView(view: holderView)
        StyleKit.applyMediumLabelStyle(label: percentageLabel, fontSize: 20)
        percentageLabel.text = viewModel.getRatingInPercentage()
    }
}
