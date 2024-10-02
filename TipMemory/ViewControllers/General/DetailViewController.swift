//
//  DetailViewController.swift
//  TipMemory
//
//  Created by 권정근 on 9/27/24.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: - Variables
    // 홈뷰컨트롤러에서 전달할 데이터를 받기 위한 변수
    var model: Item?
    
    var detailImages: [String] = []
    var detailInfo: [InfoItem] = []
    
    // MARK: - UI Components
    let detailView: DetailMainView = {
        let view = DetailMainView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(detailView)
        
        navigationController?.isNavigationBarHidden = true
        imageCollectionDelegate()
        configureConstraints()
        gobackButton()
        
        getDetailDatasCalled()
        getSpotInfo(with: model!)
        
        
        runSeeMoreButton()
        
        getOverview(with: model!)
    }
    
    //    override func viewDidAppear(_ animated: Bool) {
    //        super.viewDidAppear(animated)
    //        runSeeMoreButton()  // 여기서 호출해보기
    //    }
    
    // 네비게이션바를 투명하게 만드는 함수
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }
    
    // MARK: - Layouts
    private func configureConstraints() {
        
        let detailViewConstraints = [
            detailView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            detailView.topAnchor.constraint(equalTo: view.topAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(detailViewConstraints)
    }
    
    // MARK: - Functions
    // 디테일 이미지 컬렉션 뷰 관련 델리게이트 함수
    func imageCollectionDelegate() {
        let imageCollectionDelegate = detailView.detailheaderView.detailImageCollectionView
        
        imageCollectionDelegate.delegate = self
        imageCollectionDelegate.dataSource = self
        imageCollectionDelegate.register(DetailImageCollectionViewCell.self, forCellWithReuseIdentifier: DetailImageCollectionViewCell.identifier)
    }
    
    // 뒤로가기 버튼
    func gobackButton() {
        detailView.detailheaderView.backButton.addTarget(self, action: #selector(didBackButtonTapped), for: .touchUpInside)
    }
    
    @objc private func didBackButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // 이미지 불러오는 함수호출
    func getDetailDatasCalled() {
        guard let model = model else  { return }
        
        let contentId = model.contentid
        getDetailImages(contentId: contentId)
        setTitleAddressLabel(with: model)
        
    }
    
    // 외부 API 호출 함수
    func getDetailImages(contentId: String) {
        NetworkManager.shared.getSpotImage(contentId: contentId) { [weak self] results in
            switch results {
            case .success(let item):
                if item.isEmpty {
                    self?.setDefaultImage()
                } else {
                    self?.detailImages = item.compactMap({ $0.originimgurl })
                }
                DispatchQueue.main.async {
                    self?.detailView.detailheaderView.detailImageCollectionView.reloadData()
                    self?.detailView.detailheaderView.pageControl.numberOfPages = self?.detailImages.count ?? 0
                }
                
            case .failure(let error):
                self?.setDefaultImage()
                DispatchQueue.main.async {
                    self?.detailView.detailheaderView.detailImageCollectionView.reloadData()
                }
                print(error.localizedDescription)
            }
        }
    }
    
    // 외부로부터 이미지를 받아올게 없다면? 기본 이미지를 설정하는 함수
    func setDefaultImage() {
        // 기본 이미지 URL 또는 로컬 이미지 파일의 이름을 detailMainImage에 배열 형태로 추가
        if let defaultImage = model?.firstimage {
            detailImages = [defaultImage]    // 기본 이미지의 URL 또는 로컬 이미지의 이름
        } else {
            detailImages = []
        }
    }
    
    func setTitleAddressLabel(with model: Item) {
        guard let title = model.title,
              let address = model.addr1 else { return }
        
        detailView.detailheaderView.detailTitleLabel.text = title
        detailView.detailheaderView.detailAddressLabel.text = address
    }
    
    // 홈화면에서 데이터를 받아와 info 데이터 갖고오는 함수
    func getSpotInfo(with model: Item) {
        
        let contentid = model.contentid
        let contenttypeid = model.contenttypeid
        
        NetworkManager.shared.getSpotDetail(contentId: contentid, contentTypeId: contenttypeid) { [weak self] results in
            switch results {
            case .success(let item):
                // items의 타입을 명확히 지정
                guard let item = item.first else {
                    print("No items found")
                    return
                }
                
                guard let detailView = self?.detailView else {
                    print("Detail view is not available")
                    return
                }
                
                DispatchQueue.main.async {
                    self?.handleData(for: contenttypeid, item: item, detailBodyView: detailView)
                }
               
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // 명소 소개 글에서 더보기 addTarget
    func runSeeMoreButton() {
        detailView.detailbodyView.seeMoreButton.addTarget(self, action: #selector(handleSeeMoreTapped), for: .touchUpInside)
    }
    
    // 명소 소개 글에서 더보기 누르면 호출되는 함수
    @objc func handleSeeMoreTapped() {
        // 상태를 바로 반전시킴 (로컬 변수가 아닌 실제 값을 수정)
        detailView.detailbodyView.isExpanded.toggle()
        
        // 줄 수 조절
        detailView.detailbodyView.overviewContentLabel.numberOfLines = detailView.detailbodyView.isExpanded ? 0 : 3
        
        // 버튼 타이틀 변경
        let buttonTitle = detailView.detailbodyView.isExpanded ? "줄이기" : "더보기"
        detailView.detailbodyView.seeMoreButton.setTitle(buttonTitle, for: .normal)
        
        // 애니메이션으로 높이 변경
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    // info 데이터 전달하는 함수
    func handleData(for contentTypeId: String, item: InfoItem, detailBodyView: DetailMainView) {
        detailView.detailbodyView.updateLabels(with: item)
    }
    
    func getOverview(with model: Item) {
        
        let contentid = model.contentid
        let contenttypeid = model.contenttypeid
        
        NetworkManager.shared.getCommonData(contentId: contentid, contentTypeId: contenttypeid) { [weak self] results in
            switch results {
            case .success(let item):
                DispatchQueue.main.async {
                    self?.detailView.detailbodyView.getOverview(with: item)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}

// MARK: - 컬렉션뷰 관련 extensions
extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == detailView.detailheaderView.detailImageCollectionView {
            return detailImages.count
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == detailView.detailheaderView.detailImageCollectionView {
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailImageCollectionViewCell.identifier, for: indexPath) as? DetailImageCollectionViewCell else { return UICollectionViewCell() }
            
            let imageUrl = detailImages[indexPath.item]
            
            cell.configureImage(with: imageUrl)
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    // UIScrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let pageIndex = round(scrollView.contentOffset.x / scrollView.frame.width)
        detailView.detailheaderView.pageControl.currentPage = Int(pageIndex)
        
    }
}
