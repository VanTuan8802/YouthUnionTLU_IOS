//
//  HomeTabBarViewController.swift
//  YouthUnionTLU
//
//  Created by VanTuan on 21/03/2024.
//

import UIKit

enum ActionType {
    case new, event, libriay
}

class HomeTabBarViewController: UIViewController, StoryboardInstantiable {
    
    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet weak var homeTabBarItem: UITabBarItem!
    @IBOutlet weak var searchTabBarItem: UITabBarItem!
    @IBOutlet weak var settingTabBarItem: UITabBarItem!
    @IBOutlet weak var newsTableView: UITableView!
    @IBOutlet weak var addBtn: UIButton!
    
    private var viewModel: HomeTabBarViewModel!
    
    private var position: Position?
    private var actionType = ActionType.new {
        didSet {
            switch actionType {
            case .new:
                break
            case .event:
                break
            case .libriay:
                break
            }
            bind(to: viewModel)
            newsTableView.reloadData()
        }
    }
    
    private var listNew: [NewModel] = []
    private var listPostActivity:[ActivityModel] = []
    private var listDocumnet: [DocumnetModel] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        bind(to: viewModel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar?.delegate = self
        setUI()
        viewModel.viewDidLoad()
    }
    
    class func create(with viewModel: HomeTabBarViewModel) -> HomeTabBarViewController {
        let vc = HomeTabBarViewController.instantiateViewController()
        vc.viewModel = viewModel
        return vc
    }
    
    
    private func setUI() {
        tabBar.selectedItem = homeTabBarItem
        homeTabBarItem.title = R.stringLocalizable.tabBarHome()
        searchTabBarItem.title = R.stringLocalizable.tabBarSearch()
        settingTabBarItem.title = R.stringLocalizable.tabBarSettings()
        
        if UserDefaultsData.shared.posision == Position.member.rawValue ||
            UserDefaultsData.shared.posision == Position.teacher.rawValue {
            addBtn.isHidden = true
        }
        
        setUpTableView()
        
    }
    
    private func bind(to viewModel: HomeTabBarViewModel) {
        viewModel.error.observe(on: self) { [weak self] error in
            if let error = error {
                self?.show(message: error,
                           okTitle: R.stringLocalizable.buttonOk())
                return
            }
        }
        
        viewModel.listNew.observe(on: self) { listNew in
            guard let listNew = listNew else {
                return
            }
            
            self.listNew = listNew
            self.newsTableView.reloadData()
        }
        
        viewModel.listPostActivities.observe(on: self) { listPostActivity in
            guard let listPostActivity = listPostActivity else {
                return
            }
            
            self.listPostActivity = listPostActivity
            self.newsTableView.reloadData()
        }
    }
    
    private func setUpTableView() {
        newsTableView.delegate = self
        newsTableView.dataSource = self
        
        newsTableView.rowHeight = UITableView.automaticDimension
        
        newsTableView.register(UINib(nibName: NewTableViewCell.className, bundle: nil) , forCellReuseIdentifier: NewTableViewCell.className)
        newsTableView.register(UINib(nibName: PostActivityTableViewCell.className, bundle: nil) , forCellReuseIdentifier: PostActivityTableViewCell.className)
        newsTableView.register(UINib(nibName: DocumentTableViewCell.className, bundle: nil), forCellReuseIdentifier: DocumentTableViewCell.className)
    }
    
    @IBAction func newAcions(_ sender: Any) {
        actionType = .new
    }
    
    @IBAction func eventAction(_ sender: Any) {
        actionType = .event
        newsTableView.reloadData()
    }
    
    @IBAction func libraryAction(_ sender: Any) {
        actionType = .libriay
    }
    
    @IBAction func qAndAAction(_ sender: Any) {
        
    }
    
    @IBAction func addPostAction(_ sender: Any) {
        viewModel.openAddPost()
    }
}

extension HomeTabBarViewController: UITabBarDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item == homeTabBarItem {
            viewModel.viewDidLoad()
        } else if item == searchTabBarItem {
            viewModel.openSearchTabBar()
        } else if item == settingTabBarItem {
            viewModel.openSettingTabBar()
        }
    }
}

extension HomeTabBarViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch actionType {
        case .new:
            return listNew.count
        case .event:
            return listPostActivity.count
        case .libriay:
            return listDocumnet.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch actionType {
        case .new:
            let cell = tableView.dequeueReusableCell(withIdentifier: NewTableViewCell.className, for: indexPath) as! NewTableViewCell
            cell.fetchData(new: listNew[indexPath.row])
            return cell
        case .event:
            let cell = tableView.dequeueReusableCell(withIdentifier: PostActivityTableViewCell.className, for: indexPath) as! PostActivityTableViewCell
            cell.fetchData(postActivity: listPostActivity[indexPath.row])
            return cell
        case .libriay:
            let cell = tableView.dequeueReusableCell(withIdentifier: DocumentTableViewCell.className, for: indexPath) as! DocumentTableViewCell
            cell.fetchData(document: listDocumnet[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.openPost(newId: listNew[indexPath.row].id ?? "")
    }
}
