//
//  SearchTabBarViewModel.swift
//  YouthUnionTLU
//
//  Created by VanTuan on 21/03/2024.
//

import Foundation

struct SearchTabBarActions {
    let showHomeTabBar: () -> Void
    let showSettingTabBar: () -> Void
}

protocol SearchTabBarViewModelInput {
    func viewDidLoad()
    func openHomeTabBar()
    func openSettingTabBar()
}

protocol SearchTabBarViewModelOutput {
    var error: Observable<String?> {get}
}

protocol SearchTabBarViewModel: SearchTabBarViewModelInput, SearchTabBarViewModelOutput {
    
}

class DefaultSearchTabBarViewModel: SearchTabBarViewModel {

    var error: Observable<String?> = Observable(nil)
    private var actions:  SearchTabBarActions
    
    init(actions: SearchTabBarActions) {
        self.actions = actions
    }
    
    func viewDidLoad() {
        
    }
    
    func openHomeTabBar() {
        actions.showHomeTabBar()
    }
    
    func openSettingTabBar() {
        actions.showSettingTabBar()
    }
}


