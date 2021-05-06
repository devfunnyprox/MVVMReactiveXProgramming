//
//  ParentPagingViewController.swift
//  MVVMReactiveProgram
//
//  Created by Nguyen Van Nguyen on 5/6/21.
//  Copyright © 2021 Nguyen Bro. All rights reserved.
//

import UIKit

class ParentPagingViewController: BaseViewController {
    
    @IBOutlet weak var contentButtonView: UIView!
    @IBOutlet weak var paging1Button: UIButton!
    @IBOutlet weak var paging2Button: UIButton!
    
    var lineView: UIView!
    var pagingView: UIPageViewController!
    var viewControllers: [UIViewController]!
    
    var pageIndex = 0

    override func viewDidLoad() {
        viewModel = ParentPagingViewModel()
        super.viewDidLoad()
        
        paging1Button.isSelected = true
        paging2Button.isSelected = false
        prepareLineView()
        
        configurePagingView()
    }
    
    override func bindViewModel() {
        super.bindViewModel()
    }
    
    private func prepareLineView() {
        view.layoutIfNeeded()
        let frame = paging1Button.isSelected ? paging1Button.frame : paging2Button.frame
        if lineView == nil {
            lineView = UIView(frame: CGRect(x: frame.origin.x, y: frame.size.height - 1, width: frame.size.width, height: 1))
            lineView.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
            contentButtonView.addSubview(lineView)
        }
        UIView.animate(withDuration: 0.3) {
            self.lineView.frame = CGRect(x: frame.origin.x, y: frame.size.height - 1, width: frame.size.width, height: 1)
        }
    }
    
    private func configurePagingView() {
        viewControllers = [UIViewController]()
        
        let storyboard = UIStoryboard(name: "Paging", bundle: nil)
        guard let page1 = storyboard.instantiateViewController(withIdentifier: "ChildPagingViewController") as? ChildPagingViewController else { return }
        page1.view.backgroundColor = .red
        guard let page2 = storyboard.instantiateViewController(withIdentifier: "ChildPagingViewController") as? ChildPagingViewController else { return }
        page2.view.backgroundColor = .green
        viewControllers.append(page1)
        viewControllers.append(page2)
        
        pagingView = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        self.addChild(pagingView)
        self.view.addSubview(pagingView.view)
        pagingView.delegate = self
        pagingView.dataSource = self
        
        pagingView.setViewControllers([viewControllers[0]], direction: .forward, animated: true, completion: nil)
        
        // PageViewController Constraints
        pagingView.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pagingView.view.topAnchor.constraint(equalTo: self.contentButtonView.bottomAnchor),
            pagingView.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            pagingView.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            pagingView.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        pagingView.didMove(toParent: self)
    }
    
    private func moveToViewController(withIndex index: Int) {
        if index != pageIndex {
            if index > pageIndex {
                pagingView.setViewControllers([viewControllers[index]], direction: .forward, animated: true, completion: nil)
            } else {
                pagingView.setViewControllers([viewControllers[index]], direction: .reverse, animated: true, completion: nil)
            }
            pageIndex = index
        }
    }
    
    @IBAction func pagingButtonDidTap(_ sender: UIButton) {
        var index = 0
        switch sender {
        case paging1Button:
            paging1Button.isSelected = true
            paging2Button.isSelected = false
            index = 0
            break
        case paging2Button:
            paging1Button.isSelected = false
            paging2Button.isSelected = true
            index = 1
            break
        default:
            break
        }
        prepareLineView()
        moveToViewController(withIndex: index)
    }

}

extension ParentPagingViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let vc = pageViewController.viewControllers?.first else { return nil }
        if pageIndex == 0 {
            return nil
        }
        pageIndex = 0
        return viewControllers[pageIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if pageIndex == 1 {
            return nil
        }
        pageIndex = 1
        return viewControllers[pageIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            guard let currentViewController = pageViewController.viewControllers?.first,
                let viewControllerCurrentIndex = viewControllers.firstIndex(of: currentViewController)
                else { return }
            pageIndex = viewControllerCurrentIndex
        }
    }
    
}

class ParentPagingViewModel: BaseViewModel {
    
    override func react() {
        super.react()
    }
}
