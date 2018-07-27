//
//  MVOnboardingViewController.swift
//  Movies
//
//  Created by Rubens Pessoa on 4/3/18.
//  Copyright © 2018 Ilhasoft. All rights reserved.
//

import UIKit
import SnapKit

class MVOnboardingViewController: UIPageViewController {

    lazy var orderedViewControllers: [UIViewController] = [MVFirstPageViewController(), MVSecondPageViewController()]

    var presenter: MVOnboardingPresenter!
    var pageControl: UIPageControl!
    var beginBtn: UIButton!

    init() {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        presenter = MVOnboardingPresenter(view: self)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self

        setupPageViewController()
        setupPageControl()
        setupLayout()
    }

    func setupPageViewController() {
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
    }

    func setupLayout() {
        view.backgroundColor = UIColor.black
        let buttonFrame = CGRect(x: 0, y: 0, width: 110, height: 30)
        beginBtn = UIButton(frame: buttonFrame)
        view.addSubview(beginBtn)

        beginBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(pageControl.snp.centerY).offset(-33)
            make.centerX.equalTo(pageControl.snp.centerX)
            make.width.equalTo(110)
            make.height.equalTo(30)
        }

        beginBtn.setTitle(localizedString(.begin), for: .normal)
        beginBtn.titleLabel?.numberOfLines = 1
        beginBtn.titleLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 14)
        beginBtn.showsTouchWhenHighlighted = true
        beginBtn.backgroundColor = UIColor.mediumTurquoise
        beginBtn.layer.cornerRadius = beginBtn.layer.bounds.height/2
        beginBtn.clipsToBounds = true
        beginBtn.addTarget(self, action: #selector(beginButtonTapped), for: .touchUpInside)
    }

    func setupPageControl() {
        let pageControlFrame = CGRect(x: 0,
                                      y: UIScreen.main.bounds.maxY - 50,
                                      width: UIScreen.main.bounds.width,
                                      height: 50)
        pageControl = UIPageControl(frame: pageControlFrame)
        pageControl.numberOfPages = orderedViewControllers.count
        pageControl.currentPage = 0
        pageControl.tintColor = UIColor.white
        pageControl.pageIndicatorTintColor = UIColor.gray
        pageControl.currentPageIndicatorTintColor = UIColor.white

        view.addSubview(pageControl)
    }

    @objc func beginButtonTapped(sender: UIButton!) {
        presenter.onBeginButtonTapped()
    }
}

extension MVOnboardingViewController: MVOnboardingContract {
    func navigateToLogin() {
        self.present(MVLoginViewController(), animated: true, completion: nil)
    }
}

extension MVOnboardingViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {
        guard let viewControllers = pageViewController.viewControllers,
            let currentPageIndex = orderedViewControllers.index(of: viewControllers[0]) else {
                return
        }

        pageControl.currentPage = currentPageIndex
    }
}

extension MVOnboardingViewController: UIPageViewControllerDataSource {
    func pageViewController( _ pageViewController: UIPageViewController,
                             viewControllerBefore viewController: UIViewController) -> UIViewController? {

        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }

        let previousIndex = viewControllerIndex - 1

        guard previousIndex >= 0, previousIndex < orderedViewControllers.count else {
            return nil
        }

        return orderedViewControllers[previousIndex]
    }

    func pageViewController( _ pageViewController: UIPageViewController,
                             viewControllerAfter viewController: UIViewController) -> UIViewController? {

        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }

        let nextIndex = viewControllerIndex + 1

        guard  nextIndex < orderedViewControllers.count else {
            return nil
        }

        return orderedViewControllers[nextIndex]
    }
}
