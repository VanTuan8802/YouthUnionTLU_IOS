//  SettingDIContainer.swift
//  YouthUnionTLU
//
//  Created by VanTuan on 21/03/2024.
//

import Foundation
import UIKit

class SettingDIContainer {
    
    struct Dependencies {
        let userClient: FSUserClient
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    func makeSettingFlowCoodinator(navigationController: UINavigationController) -> SettingFlowCoodinator {
        SettingFlowCoodinator(navigationController: navigationController,
                           dependencies: self)
    }
    
    func makeSettingTabBarvc(actions: SettingTabBarActions) -> SettingTabBarViewModel {
        DefaultSettingTabBarViewModel(actions: actions)
    }
}

extension SettingDIContainer: SettingFlowCoodinatorDependencies {
    func makeSettingTabBarVC(actions: SettingTabBarActions) -> SettingTabBarViewController {
        SettingTabBarViewController.create(with: makeSettingTabBarvc(actions: actions))
    }

}

