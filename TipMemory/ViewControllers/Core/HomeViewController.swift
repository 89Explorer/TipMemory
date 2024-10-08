//
//  HomeViewController.swift
//  TipMemory
//
//  Created by 권정근 on 9/23/24.
//

import UIKit

// 위치 정보 관련 import
import CoreLocation

class HomeViewController: UIViewController {
    
    
    // MARK: - Variables
    private var categories: [String] = ["자연 여행", "문화 여행", "음식 여행", "코스 여행", "쇼핑 여행"]
    private var categoriesImage: [String] = ["Nature", "Museum", "Restaurant", "Stroll", "Shopping"]
    
    // 카테고리 선택을 위한 변수
    private var categorySelectedIndex: Int = 0
    private var selectedContentTypeId: String = "12"
    
    // 홈 화면 테이블 섹션
    private var sections: [String] = ["사용자 위치 기준 여행지", "전국 기준 카테고리 여행지", "인기 있는 여행지"]
    
    // 사용자 위치 정보 확인
    private var userLocation: String = ""
    private var userLatitude: String = ""
    private var userLongitude: String = ""
    static var locationCode: [[String]]?
    
    
    // 사용자 위치 서비스 관리 객체
    let locationManager = CLLocationManager()
    let geocoder = CLGeocoder()
    
    
    // 테이블의 각 섹션에 필요한 데이터를 저장할 프로퍼티
    var locationReceivedItems: [Item] = []
    var categoryReceivedItems: [Item] = []
    var popularReceivedItems: [Item] = []
    
    // 방문자 접속 추이 확인을 위한 변수
    var areaCode: String = ""
    var sigunguCode: String = ""
    
    
    
    // MARK: - UI Components
    let homeView: HomeMainView = {
        let view = HomeMainView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(homeView)
        configureConstraints()
        
        categoryViewDelegate()
        tableViewDelegate()
        alarmButton()
        locationButton()
        
        // CSV 파일로 부터 데이터 추출하는 함수 호출
        // self.loadLocationsFromCSV()
        
        // 위치 서비스 활성화 여부 확인 함수 호출
        checkUserDeviceLocationServiceAuthorization()
        
        // 카테고리 별 여행지 받아오는 함수 호출
        getCategorySpotData(contentTypeId: self.selectedContentTypeId)
        
    }
    
    // 네비게이션바를 투명하게 만드는 함수
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }
    
    
    // MARK: - Total Layouts
    private func configureConstraints() {
        
        let homeViewConstraints = [
            homeView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            homeView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            homeView.topAnchor.constraint(equalTo: view.topAnchor),
            homeView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(homeViewConstraints)
    }
    
    // MARK: - Functions
    // 카테고리 컬렉션 델리게이트 함수
    private func categoryViewDelegate() {
        
        let homeviewDelegate = homeView.homeheaderView.categoryView.categoryCollectionView
        
        homeviewDelegate.delegate = self
        homeviewDelegate.dataSource = self
        homeviewDelegate.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
    }
    
    // 홈 화면 섹션 테이블 델리게이트 함수
    private func tableViewDelegate() {
        let homeTableDelegate = homeView.homeBodyView.homeBodyTable
        
        homeTableDelegate.delegate = self
        homeTableDelegate.dataSource = self
        homeTableDelegate.register(HomeBodyTableViewCell.self, forCellReuseIdentifier: HomeBodyTableViewCell.identifier)
    }
    
    // 홈 화면 섹셜 테이블 내 컬렉션뷰 델리게이트 함수
    private func tableCollectionViewDelegate() {
        
        
    }
    
    // 테이블 섹션 타이틀 "더보기" 버튼 함수
    @objc func moreButtonTapped(_ sender: UIButton) {
        print("더 보기 버튼 클릭 ")
    }
    
    // 홈 헤더의 알람 버튼 함수
    func alarmButton() {
        homeView.homeheaderView.alarmButton.addTarget(self, action: #selector(alarmButtonTapped(_:)), for: .touchUpInside)
    }
    
    // 홈 헤더의 알람 버튼를 누르면 동작하는 함수
    // AlarmViewController로 이동함
    @objc func alarmButtonTapped(_ sender: UIButton) {
        let alarmVC = AlarmViewController()
        navigationController?.pushViewController(alarmVC, animated: true)
    }
    
    // 홈 헤더의 위치 확인 버튼 함수
    func locationButton() {
        homeView.homeheaderView.checkLocationButton.addTarget(self, action: #selector(locationButtonTapped(_:)), for: .touchUpInside)
    }
    
    // 홈 헤더의 위치 확인 버튼을 누르면 동작하는 함수
    // 위치를 수동으로 재확인함
    @objc func locationButtonTapped(_ sender: UIButton) {
        // 현재 권한 상태를 확인
        locationManagerDidChangeAuthorization(locationManager)
    }
    
    // 사용자의 위치 서비스 활성화 여부 확인 함수
    func checkUserDeviceLocationServiceAuthorization() {
        
        // 디바이스 자체에 위치 서비스가 활성화 상태인지 확인한다.
        DispatchQueue.global().async {
            guard CLLocationManager.locationServicesEnabled() else {
                // 시스템 설정으로 유도하는 커스텀 얼럿
                self.showRequestLocationServiceAlert()
                return
            }
        }
        
        // 위치 서비스가 활성화 상태라면 권한 오청
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    // iOS 14 이상에서는 권한 상태를 델리게이트 메서드에서 처리
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        // 3.2 사용자 디바이스의 위치 서비스가 활성화 상태라면,  앱에 대한 권한 상태를 확인해야 한다.
        let authorizationStatus: CLAuthorizationStatus
        
        // 앱의 권한 상태 가져오는 코드 (iOS 버전에 따라 분기처리)
        if #available(iOS 14.0, *) {
            authorizationStatus = manager.authorizationStatus
        }else {
            authorizationStatus = CLLocationManager.authorizationStatus()
        }
        
        // 권한 상태값에 따라 분기처리를 수행하는 메서드 실행
        checkUserCurrentLocationAuthorization(authorizationStatus)
    }
    
    // 앱에 대한 위치 권한이 부여된 상태인지 확인하는 메서드 추가
    func checkUserCurrentLocationAuthorization(_ status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            // 사용자가 권한에 대한 설정을 선택하지 않은 상태
            print("Not determained")
            
            // 권한 요청을 보내기 전에 desiredAccuracy 설정 필요
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            // 권한 요청을 보낸다.
            
        case .denied, .restricted:
            // 사용자가 명시적으로 권한을 거부했거나, 위치 서비스 활성화가 제한된 상태
            // 시스템 설정에서 설정값을 변경하도록 유도한다.
            // 시스템 설정으로 유도하는 커스텀 얼럿
            print("Restricted or denied")
            showRequestLocationServiceAlert()
            
            
        case .authorizedWhenInUse:
            // 앱을 사용중일 때, 위치 서비스를 이용할 수 있는 상태
            // manager 인스턴스를 사용하여 사용자의 위치를 가져온다.
            print("Authorized")
            locationManager.startUpdatingLocation()
            
        default:
            print("Default")
        }
    }
    
    // 위치 권한 접근을 거절할 경우 나올 경고창
    func showRequestLocationServiceAlert() {
        let requestLocationServiceAlert = UIAlertController(title: "위치 정보 이용", message: "위치 서비스를 사용할 수 없습니다.\n디바이스의 '설정 > 개인정보 보호'에서 위치 서비스를 켜주세요.", preferredStyle: .alert)
        let goSetting = UIAlertAction(title: "설정으로 이동", style: .destructive) { _ in
            if let appSetting = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(appSetting)
            }
        }
        
        let cancel = UIAlertAction(title: "취소", style: .default) { _ in
            
        }
        
        requestLocationServiceAlert.addAction(cancel)
        requestLocationServiceAlert.addAction(goSetting)
        
        present(requestLocationServiceAlert, animated: true)
    }
    
    // 위도와 경도를 주소로 변환하는 메서드
    func reverseGeocode(location: CLLocation, completion: @escaping (String?) -> Void) {
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            if let error = error {
                print("Reverse geocoding failed: \(error.localizedDescription)")
                completion(nil) // 에러가 발생한 경우 nil을 반환
                return
            }
            
            guard let placemark = placemarks?.first else {
                print("No placemark found")
                completion(nil) // placemark가 없는 경우 nil을 반환
                return
            }
            
            // 지번 주소 구성
            let administrativeArea = placemark.administrativeArea ?? ""        // 경기도
            let locality = placemark.locality ?? ""                            // 고양시
            let subAdministrativeArea = placemark.subAdministrativeArea ?? ""  // 덕양구 (자치구)
            let subLocality = placemark.subLocality ?? ""                      // 동 (화정동)
            
            var jibunAddress = ""
            
            // "특별시" 또는 "광역시" 처리
            if administrativeArea.hasSuffix("특별시") || administrativeArea.hasSuffix("광역시") {
                // 특별시 또는 광역시인 경우, administrativeArea 생략하고 자치구(subAdministrativeArea)도 추가
                jibunAddress = "\(locality) \(subAdministrativeArea) \(subLocality)"
            } else {
                // 그 외 지역은 그대로 표시 (경기도 같은 지역은 administrativeArea 포함)
                jibunAddress = "\(administrativeArea) \(locality) \(subAdministrativeArea) \(subLocality)"
            }
            
            // userLocation에 값을 할당
            self.userLocation = jibunAddress
            completion(jibunAddress)
        }
    }
    
    // contentTypeId를 통해 카테고리 별 관광지 정보를 받아오는 함수
    func getCategorySpotData(contentTypeId: String) {
        NetworkManager.shared.getKeywordnData(contentTypeId: contentTypeId) { [weak self] results in
            switch results {
            case .success(let items):
                self?.categoryReceivedItems = items.response.body.items.item
                DispatchQueue.main.async {
                    self?.homeView.homeBodyView.homeBodyTable.reloadData()
                }
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // contentTypeId, mapX, mapY를 통해 위치 + 카테고리 별 관광지 정보를 받아오는 함수
    func getLocationSpotData(mapX: String, mapY: String, contentTypeId: String) {
        NetworkManager.shared.getSpotDataFromLocation(mapX: self.userLongitude, mapY: self.userLatitude, contentTypeId: self.selectedContentTypeId) { [weak self] results in
            switch results {
            case .success(let item):
                // 데이터를 받아온 후 첫 번째 아이템을 사용
                self?.locationReceivedItems = item
                DispatchQueue.main.async {
                    self?.homeView.homeBodyView.homeBodyTable.reloadData()
                }
            case .failure(let error):
                print("Failed to fetch data:\(error)")
            }
        }
    }
    
    // LocationCode를 통해 사용자 위치에 따른 주소 코드 반환 함수
    func loadLocationsFromCSV() {
        guard let path = Bundle.main.path(forResource: "LocationCode", ofType: "csv") else { return }
        
        HomeViewController.locationCode = parseCSVAt(url: URL(fileURLWithPath: path))
    }
    
    // 상세페이지로 이동하는 함수
    func navigateToDetailPage(with model: Item) {
        let detailVC = DetailViewController()
        detailVC.model = model
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func presentToDetailPage() {
        let detailVC = DetailViewController()
        
        detailVC.modalPresentationStyle = .fullScreen
        self.present(detailVC, animated: true)
    }
}


// MARK: - extension CollectionView
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        // 카테고리 부분 컬렉션 뷰
        if collectionView == homeView.homeheaderView.categoryView.categoryCollectionView {
            return categories.count
        }
        
        
        // 테이블뷰에 있는 컬렉션 뷰
        
        guard let collectionViewTag = CollectionViewTags(rawValue: collectionView.tag) else { return 0 }
        
        switch collectionViewTag {
        case .location:
            return locationReceivedItems.count
        case .category:
            return categoryReceivedItems.count
        case .popular:
            return popularReceivedItems.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // 카테고리 있는 부분의 컬렉션 뷰
        if collectionView == homeView.homeheaderView.categoryView.categoryCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as? CategoryCollectionViewCell else { return UICollectionViewCell() }
            
            let title = categories[indexPath.row]
            let image = categoriesImage[indexPath.row]
            let isSelected = indexPath.item == categorySelectedIndex
            
            cell.configureCategory(title: title, isSelected: isSelected, image: image)
            
            return cell
        }
        
        // 테이블뷰에 있는 컬렉션 뷰
        guard let collectionViewTag = CollectionViewTags(rawValue: collectionView.tag) else { return UICollectionViewCell() }
        
        switch collectionViewTag {
        case .location:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeBodyTableCollectionViewCell.identifier, for: indexPath) as? HomeBodyTableCollectionViewCell else { return UICollectionViewCell() }
            cell.configureData(with: locationReceivedItems[indexPath.item])
            
            return cell
            
        case .category:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeBodyTableCollectionViewCell.identifier, for: indexPath) as? HomeBodyTableCollectionViewCell else { return UICollectionViewCell() }
            cell.configureData(with: categoryReceivedItems[indexPath.item])
            return cell
            
        case .popular:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeBodyTableCollectionViewCell.identifier, for: indexPath) as? HomeBodyTableCollectionViewCell else { return UICollectionViewCell() }
            cell.configureData(with: popularReceivedItems[indexPath.item])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // 카테고리 있는 부분의 컬렉션 뷰
        if collectionView == homeView.homeheaderView.categoryView.categoryCollectionView {
            let previousSelectedIndex = categorySelectedIndex    // 이전에 선택된 인덱스 저장
            categorySelectedIndex = indexPath.item    // 새로운 선택 인덱스로 업데이트
            
            print("Selected category index: \(categorySelectedIndex)")
            
            let selectedIndexPath = IndexPath(item: categorySelectedIndex, section: 0)
            let previousSelectedIndexPath = IndexPath(item: previousSelectedIndex, section: 0)
            
            
            // 이전 선택 항목이 유효한 경우에만 리로드
            if previousSelectedIndex != categorySelectedIndex {
                homeView.homeheaderView.categoryView.categoryCollectionView.reloadItems(at: [selectedIndexPath, previousSelectedIndexPath])
            }
            
            // 필요한 데이터 처리
            var selectedCategory: ContentCategory?
            switch categorySelectedIndex {
            case 0:
                selectedCategory = .attractions
                selectedContentTypeId = selectedCategory!.rawValue
                print("Category: attractions")
            case 1:
                selectedCategory = .facilities
                selectedContentTypeId = selectedCategory!.rawValue
                print("Category: facilities")
            case 2:
                selectedCategory = .restaurants
                selectedContentTypeId = selectedCategory!.rawValue
                print("Category: restaurants")
            case 3:
                selectedCategory = .course
                selectedContentTypeId = selectedCategory!.rawValue
                print("Category: course")
            case 4:
                selectedCategory = .shopping
                selectedContentTypeId = selectedCategory!.rawValue
                print("Category: shopping")
            default:
                print("Unknown category")
                break
            }
            
            if let category = selectedCategory {
                getCategorySpotData(contentTypeId: category.contentTypeId)
                getLocationSpotData(mapX: self.userLongitude, mapY: self.userLatitude, contentTypeId: self.selectedContentTypeId)
                // 테이블 뷰의 컬렉션 뷰를 갱신
                homeView.homeBodyView.homeBodyTable.reloadData()
            }
        }
        
        
        
        // 카테고리 컬렉션뷰를 눌럿을때 발생하는 오류를 개선하기 위한 코드
        // 테이블뷰 내의 컬렉션 뷰에서 셀 선택 시
        else if let collectionViewTag = CollectionViewTags(rawValue: collectionView.tag) {
            switch collectionViewTag {
            case .location:
                let selectedItem = locationReceivedItems[indexPath.item]
                navigateToDetailPage(with: selectedItem)
                // presentToDetailPage()
            case .category:
                let selectedItem = categoryReceivedItems[indexPath.item]
                navigateToDetailPage(with: selectedItem)
                // presentToDetailPage()
            case .popular:
                let selectedItem = popularReceivedItems[indexPath.item]
                navigateToDetailPage(with: selectedItem)
                // presentToDetailPage()
            }
        }
        
        //                else if collectionView.tag == 0{
        //                    let selectedItem = locationReceivedItems[indexPath.item]
        //                    navigateToDetailPage()
        //                }
        //                else if collectionView.tag == 1{
        //                    let selectedItem = categoryReceivedItems[indexPath.item]
        //                    navigateToDetailPage()
        //                }
        //                else if collectionView.tag == 2{
        //                    let selectedItem = popularReceivedItems[indexPath.item]
        //                    navigateToDetailPage()
        //                }
    }
}


// MARK: - extension TableView
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 3
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeBodyTableViewCell.identifier) as? HomeBodyTableViewCell else { return UITableViewCell() }
        // cell.delegate = self
        cell.homeCollectionView.delegate = self
        cell.homeCollectionView.dataSource = self
        cell.homeCollectionView.tag = indexPath.section  // 각 컬렉션 뷰에 테이블 섹션을 구분하는 태그 부여
        
        // 테이블 셀 마다 켤렉션 뷰가 다르게 동작해야 하기 때문에
        // 각 셀의 UICollectionView에 tag값을 부여하여 컬렉션 뷰 구분
        switch indexPath.section {
        case 0:
            cell.configure(with: locationReceivedItems)
        case 1:
            cell.configure(with: categoryReceivedItems)
        case 2:
            cell.configure(with: popularReceivedItems)
        default:
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    func tableView(_ tableView: UITableView,viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView()
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "\(sections[section])"
        label.font = UIFont(name: "HakgyoansimBunpilR", size: 16)
        label.textColor = .label
        label.backgroundColor = .clear
        label.textAlignment = .left
        
        headerView.addSubview(label)
        
        let moreButton = UIButton(type: .system)
        moreButton.translatesAutoresizingMaskIntoConstraints = false
        moreButton.setTitle("더 보기", for: .normal)
        moreButton.titleLabel?.font = UIFont(name: "HakgyoansimBunpilR", size: 16)
        moreButton.setTitleColor(.label, for: .normal)
        moreButton.addTarget(self, action: #selector(moreButtonTapped(_:)), for: .touchUpInside)
        
        headerView.addSubview(moreButton)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 10),
            label.topAnchor.constraint(equalTo: headerView.topAnchor),
            
            // 더보기 버튼의 제약조건
            moreButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -10),
            moreButton.topAnchor.constraint(equalTo: headerView.topAnchor, constant: -5),
        ])
        
        return headerView
    }
}

// MARK: - extension ScrollView
extension HomeViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        
        navigationController?.navigationBar.transform = .init(translationX: 0, y: -offset)
    }
}


// MARK: - extension 위치 정보 delegate 메서드 구현
extension HomeViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        self.userLatitude = "\(location.coordinate.latitude)"
        self.userLongitude = "\(location.coordinate.longitude)"
        
        // 경도와 위도를 통해 지번 / 도로명 주소 변환
        reverseGeocode(location: location) { userLocation in
            if let userLocation = userLocation {
                
                // userLocation을 사용하여 homeHeaderView 타이틀 설정
                DispatchQueue.main.async {
                    self.homeView.homeheaderView.locationLabel.text = "현재 위치: \(userLocation)"
                    
                    // 위치 정보를 통해 관광지 정보 가져오기
                    self.getLocationSpotData(mapX: self.userLongitude, mapY: self.userLatitude, contentTypeId: self.selectedContentTypeId)
                }
            }
        }
        
    }
}

// 델리게이트 패턴을 사용하여 테이블 뷰 내에 컬렉션뷰셀을 누르면 상세페이지로 이동하는 확장
//extension HomeViewController: TableViewCollectionViewCellDelegate {
//    func tableViewCollectionViewCellDidTapped(_ cell: HomeBodyTableViewCell) {
//        DispatchQueue.main.async {
//            let detailVC = DetailViewController()
//            self.navigationController?.pushViewController(detailVC, animated: true)
//        }
//    }
//}
