//
//  HomeViewController.swift
//  Fodamy
//
//  Created by İbrahim Kültepe on 20.04.2023.
//

import UIKit
import KeychainSwift
import MobilliumUserDefaults

final class HomeViewController: BaseViewController<HomeViewModel> {
    
    private let segmentedControl: UISegmentedControl = {
        let items = [L10n.Home.segmentedControl0, L10n.Home.segmentedControl1]
        let segmentedControl = UISegmentedControl(items: items)
        return segmentedControl
    }()
    
    private let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    
    private lazy var subViewControllers: [UIViewController] = {
        return self.preparedViewControllers()
    }()
    
    private let keychain = KeychainSwift()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNavigationBarLogo()
        addSubviews()
        configureContent()
        subscribeViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkIsUserLogin()
    }
}

// MARK: - UILayout
extension HomeViewController {
    
    private func addSubviews() {
        view.addSubview(segmentedControl)
        segmentedControl.height(48)
        segmentedControl.edgesToSuperview(excluding: .bottom, usingSafeArea: true)
        
        view.addSubview(pageViewController.view)
        addChild(pageViewController)
        pageViewController.didMove(toParent: self)
        pageViewController.view.topToBottom(of: segmentedControl)
        pageViewController.view.edgesToSuperview(excluding: .top)
    }
}

// MARK: - Configure
extension HomeViewController {
    
    private func configureContent() {
        segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.appRed], for: .selected)
        segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.appRaven], for: .normal)
        segmentedControl.backgroundColor = .appWhite
        segmentedControl.setBackgroundImage(UIImage(), for: .normal, barMetrics: .default)
        segmentedControl.selectedSegmentIndex = viewModel.selectedSegmentIndex
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
        pageViewController.delegate = self
        pageViewController.dataSource = self
        pageViewController.setViewControllers([subViewControllers[viewModel.selectedSegmentIndex]],
                                              direction: .forward,
                                              animated: true,
                                              completion: nil)
    }
    
    private func addLogoutButton() {
        let logoutButton = UIBarButtonItem(image: .icLogout, style: .done, target: self, action: #selector(logoutButtonAction))
        navigationItem.rightBarButtonItem = logoutButton
    }
    
    private func checkIsUserLogin() {
        guard keychain.get(Keychain.token) != nil else {
            navigationItem.rightBarButtonItem = .none
            return
        }
        addLogoutButton()
    }
}

// MARK: - Actions
extension HomeViewController {
    
    @objc
    private func segmentedControlValueChanged() {
        var direction: UIPageViewController.NavigationDirection = .forward
        if segmentedControl.selectedSegmentIndex < viewModel.selectedSegmentIndex {
            direction = .reverse
        }
        pageViewController.setViewControllers([subViewControllers[segmentedControl.selectedSegmentIndex]],
                                              direction: direction,
                                              animated: true, completion: nil)
        viewModel.selectedSegmentIndex = segmentedControl.selectedSegmentIndex
        segmentedControl.selectedSegmentIndex = viewModel.selectedSegmentIndex
    }
    
    @objc
    private func logoutButtonAction() {
        viewModel.userLogoutRequest()
    }
}

// MARK: - Helper
extension HomeViewController {
    
    private func preparedViewControllers() -> [UIViewController] {
        let editorChoiceRouter = RecipesRouter()
        let editorChoiceViewModel = RecipesViewModel(recipeListType: .editorChoice, router: editorChoiceRouter)
        let editorChoiceViewController = RecipesViewController(viewModel: editorChoiceViewModel)
        editorChoiceRouter.viewController = editorChoiceViewController
        
        let recentlyAddedRouter = RecipesRouter()
        let recentlyAddedViewModel = RecipesViewModel(recipeListType: .recentlyAdded, router: recentlyAddedRouter)
        let recentlyAddedViewController = RecipesViewController(viewModel: recentlyAddedViewModel)
        recentlyAddedRouter.viewController = recentlyAddedViewController
        
        return [editorChoiceViewController, recentlyAddedViewController]
    }
}

// MARK: - UIPageViewController
extension HomeViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let currentIndex = subViewControllers.firstIndex(of: viewController) ?? 0
        if currentIndex <= 0 {
            return nil
        }
        return subViewControllers[currentIndex - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let currentIndex = subViewControllers.firstIndex(of: viewController) ?? 0
        if currentIndex >= subViewControllers.count - 1 {
            return nil
        }
        return subViewControllers[currentIndex + 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {
        guard let viewControllers = pageViewController.viewControllers,
              let firtsViewController = viewControllers.first,
              let index = subViewControllers.firstIndex(of: firtsViewController) else {return}
        if finished && completed {
            segmentedControl.selectedSegmentIndex = index
        }
    }
}

// MARK: - SubscribeViewModel
extension HomeViewController {
    
    private func subscribeViewModel() {
        viewModel.didSuccesLogout = { [weak self] in
            guard let self = self else { return }
            self.keychain.delete(Keychain.token)
            DefaultsKey.userId.remove()
            self.navigationItem.rightBarButtonItem = .none
        }
    }
}
