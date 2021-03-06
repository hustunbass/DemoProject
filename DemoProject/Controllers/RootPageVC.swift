//
//  RootPageVC.swift
//  DemoProject
//
//  Created by Hakan Üstünbaş on 24.09.2020.
//

import UIKit

class RootPageVC: UIPageViewController,UIPageViewControllerDataSource {

    lazy var viewControllerList : [UIViewController] = {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        let vc1 = sb.instantiateViewController(identifier: "BlueVC")
        let vc2 = sb.instantiateViewController(identifier: "OrangeVC")
        let vc3 = sb.instantiateViewController(identifier: "GreenVC")
        
        return [vc1,vc2,vc3]
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.dataSource = self
        
        if let firsViewController = viewControllerList.first {
            self.setViewControllers([firsViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let vcIndex = viewControllerList.firstIndex(of: viewController) else {return nil}
        
        let previousIndex = vcIndex - 1
        
        guard previousIndex >= 0 else {return nil}
        
        guard viewControllerList.count > previousIndex else{return nil}
        
        return viewControllerList[previousIndex]
        
        
        
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let vcIndex = viewControllerList.firstIndex(of: viewController) else {return nil}
        
        let nextIndex = vcIndex + 1
        
        guard viewControllerList.count != nextIndex else {return nil}
        
        guard viewControllerList.count > nextIndex else {return nil}
        
        return viewControllerList[nextIndex]
        
    }

}
