//
//  WrapContentConstraint.swift
//  PetSpotCoreUI
//
//  Created by Mario Plaza on 19/9/18.
//  Copyright © 2018 Machipla. All rights reserved.
//

import Foundation
import UIKit

public final class WrapContentConstraint: NSLayoutConstraint{
    @IBOutlet weak var observingView:UIView!{
        didSet{ updateOnObservingViewChange() }
    }
    @IBInspectable var rawActiveLayoutPriority:Float = WrapContentConstraint.DefaultLayoutPriorities.enabled.rawValue
    
    private var observerHasBeenAdded:Bool = false
    private var firstView:UIView?{ return firstItem as? UIView }
    private var secondView:UIView?{ return secondItem as? UIView }
    
    
    deinit{
        removeObserverIfAdded()
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        
        rawActiveLayoutPriority = priority.rawValue
        update()
    }
    
    public func update(){
        guard rawActiveLayoutPriority != 0 else { return }
        
        // We don't deactivate the constraint as if we do, it get's released and we just want to get it disabled to activate it again if it's necessary.
        priority =  observingView.isHidden ? WrapContentConstraint.DefaultLayoutPriorities.disabled : UILayoutPriority(rawValue: rawActiveLayoutPriority)
        
        firstView?.layoutIfNeeded()
        secondView?.layoutIfNeeded()
    }
    
    override public func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard keyPath == WrapContentConstraint.hiddenViewObservingPath && (object as? UIView) === observingView else { return }
        update()
    }
    
    public override func addObserver(_ observer: NSObject, forKeyPath keyPath: String, options: NSKeyValueObservingOptions = [], context: UnsafeMutableRawPointer?) {
        super.addObserver(observer, forKeyPath: keyPath, options: options, context: context)
        observerHasBeenAdded = true
    }
    
    public override func removeObserver(_ observer: NSObject, forKeyPath keyPath: String) {
        super.removeObserver(observer, forKeyPath: keyPath)
        observerHasBeenAdded = false
    }
    
}

private extension WrapContentConstraint{
    func removeObserverIfAdded(){
        guard observerHasBeenAdded else { return }
        
        removeObserver(self, forKeyPath: WrapContentConstraint.hiddenViewObservingPath)
    }
    
    func addObserverIfPossible(){
        guard let observingView = observingView else { return }
        
        removeObserverIfAdded()
        observingView.addObserver(self, forKeyPath: WrapContentConstraint.hiddenViewObservingPath, options: [], context: nil)
    }
    
    func updateOnObservingViewChange(){
        addObserverIfPossible()
        update()
    }
}
