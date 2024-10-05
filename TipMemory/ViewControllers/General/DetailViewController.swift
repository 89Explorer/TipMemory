//
//  DetailViewController.swift
//  TipMemory
//
//  Created by 권정근 on 9/27/24.
//

import UIKit
import DGCharts

class DetailViewController: UIViewController {
    
    // MARK: - Variables
    // 홈뷰컨트롤러에서 전달할 데이터를 받기 위한 변수
    var model: Item?
    
    var detailImages: [String] = []
    var detailInfo: [InfoItem] = []
    
    // 방문자 접속 추이 확인을 위한 변수
    var areaCode: String = ""
    var sigunguCode: String = ""
    var tAtsNm: String?
    var visitorRatio: [String] = []
    
    
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
        getYoutubeFromTitle(with: model!)
        
        // getVisitorChart()
        // reverseAddrToCode(address: (model?.addr1)!)
        // getVisitorRatio(with: model!)
    }
        
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
    
    // 관광지의 이름을 갖고 youtubeAPI를 통해 데이터를 받아오기
    func getYoutubeFromTitle(with model: Item) {
        let title = "\(String(describing: model.title)) + 방문"
        
        NetworkManager.shared.getMovie(with: title) { [weak self] results in
            switch results {
            case .success(let item):
                guard let videoId = item.id.videoId else { return }
                guard let url = URL(string: "https://www.youtube.com/embed/\(videoId)") else { return }
                print(url)
                DispatchQueue.main.async {
                    self?.detailView.detailbodyView.youtubeWebView.load(URLRequest(url: url))
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // chart 관련 함수
//    func getVisitorChart() {
//        var entries: [BarChartDataEntry] = []
//        let today = Date()
//        
//        // x축 데이터: 오늘부터 7일
//        for i in 0..<7 {
//            _ = Calendar.current.date(byAdding: .day, value: i, to: today)!
//            entries.append(BarChartDataEntry(x: Double(i), y: Double(10 * (i + 1)))) // y값은 임의로 설정
//        }
//        
//        // x축 데이터: 오늘부터 7일
//        for i in 0..<7 {
//            _ = Calendar.current.date(byAdding: .day, value: i, to: today)!
//            entries.append(BarChartDataEntry(x: Double(i), y: Double(10 * (i + 1)))) // y값은 임의로 설정
//        }
//        
//        let dataSet = BarChartDataSet(entries: entries, label: "방문자 집중률")
//        dataSet.colors = [NSUIColor.label] // 모든 막대를 같은 색상으로 설정
//        dataSet.valueTextColor = .label // 막대 위에 표시될 값의 색상
//        dataSet.valueFont = .systemFont(ofSize: 12) // 막대 위 값의 폰트 크기
//
//        // BarChartData 생성
//        let data = BarChartData(dataSet: dataSet)
//        detailView.detailbodyView.visitorChartView.data = data
//        
//        // X축에 날짜를 표시하는 Formatter 설정
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "MM/dd"
//        
//        detailView.detailbodyView.visitorChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: getFutureDates(forDays: 7, from: today, formatter: dateFormatter))
//    }
    
    // 날짜 배열을 반환하는 함수
    func getFutureDates(forDays days: Int, from startDate: Date, formatter: DateFormatter) -> [String] {
        var dates: [String] = []
        for i in 0..<days {
            if let futureDate = Calendar.current.date(byAdding: .day, value: i, to: startDate) {
                dates.append(formatter.string(from: futureDate))
            }
        }
        return dates
    }
    
    //  areaCode, sigunguCode 데이터 반환 함수
    func reverseAddrToCode(address: String) {
        let addressComponents = address.split(separator: " ")
        let city = String(addressComponents[0])   // 경기도
        let district = String(addressComponents[1])  // 고양시 덕양구
        
        // 데이터를 순회하면서 일치하는 데이터를 찾기
        var areaCode: String?
        var singunguCode: String?
        
        guard let locationCode = HomeViewController.locationCode else { return }
        
        for row in locationCode {
            let areaNm = row[1].replacingOccurrences(of: "\"", with: "") // "areaNm" 값
            let sigunguNm = row[3].replacingOccurrences(of: "\"", with: "") // "sigunguNm" 값
            
            if areaNm == city && sigunguNm == district {
                areaCode = row[0].replacingOccurrences(of: "\"", with: "") // "areaCd" 값
                singunguCode = row[2].replacingOccurrences(of: "\"", with: "") // "sigunguCd" 값
                break
            }
        }
        
        self.areaCode = areaCode ?? ""
        self.sigunguCode = singunguCode ?? ""
    }
    
    // 방문객 집중추이를 확인하기 위한 호출 함수
    func getVisitorRatio(with model: Item) {
        
        guard let title = model.title else { return }
        
        NetworkManager.shared.getTatsCnctrRatedList(areaCd: self.areaCode, signguCd: self.sigunguCode, tAtsNm: title) { [weak self] results in
            switch results {
            case .success(let data):
                self?.visitorRatio = data.compactMap{ $0.cnctrRate }
                print(self?.visitorRatio)
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
