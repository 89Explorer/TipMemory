//
//  DetailBodyView.swift
//  TipMemory
//
//  Created by 권정근 on 9/30/24.
//

import UIKit

class DetailBodyView: UIView {
    
    // MARK: - Variables
    // 명소 소개 글의 더보기를 동작 유무를 확인하기 위한 변수
    var isExpanded: Bool = false
    
    
    // MARK: - UI Components
    let basicView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let useTimeRestDateStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 8
        return stackView
    }()
    
    let useTimeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .secondarySystemBackground
        stackView.layer.cornerRadius = 5
        stackView.clipsToBounds = true
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 8
        return stackView
    }()
    
    let useTimeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let configuration = UIImage.SymbolConfiguration(pointSize: 20)
        imageView.image = UIImage(systemName: "clock.circle", withConfiguration: configuration)
        imageView.tintColor = .label
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let useTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "09:00 ~ 18:00"
        label.font = UIFont(name: "HakgyoansimBunpilR", size: 18)
        label.textColor = .label
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    let restDateStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .secondarySystemBackground
        stackView.layer.cornerRadius = 5
        stackView.clipsToBounds = true
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 8
        return stackView
    }()
    
    let restDateImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let configuration = UIImage.SymbolConfiguration(pointSize: 20)
        imageView.image = UIImage(systemName: "calendar.circle", withConfiguration: configuration)
        imageView.tintColor = .label
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let restDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "매주 화요일"
        label.font = UIFont(name: "HakgyoansimBunpilR", size: 18)
        label.textColor = .label
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    let parkingPhoneStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 8
        return stackView
    }()
    
    let parkingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .secondarySystemBackground
        stackView.layer.cornerRadius = 5
        stackView.clipsToBounds = true
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 8
        return stackView
    }()
    
    let parkingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let configuration = UIImage.SymbolConfiguration(pointSize: 20)
        imageView.image = UIImage(systemName: "parkingsign.circle", withConfiguration: configuration)
        imageView.tintColor = .label
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let parkingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "주차 가능 (30대)"
        label.font = UIFont(name: "HakgyoansimBunpilR", size: 18)
        label.textColor = .label
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    let phoneStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .secondarySystemBackground
        stackView.layer.cornerRadius = 5
        stackView.clipsToBounds = true
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 8
        return stackView
    }()
    
    let phoneImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let configuration = UIImage.SymbolConfiguration(pointSize: 20)
        imageView.image = UIImage(systemName: "phone.circle", withConfiguration: configuration)
        imageView.tintColor = .label
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let phoneLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "031-040-0333"
        label.font = UIFont(name: "HakgyoansimBunpilR", size: 18)
        label.textColor = .label
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    let overviewTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "HakgyoansimBunpilR", size: 22)
        label.text = "소개"
        label.textColor = .label
        return label
    }()
    
    let overviewContentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "경복궁은 1395년 태조 이성계에 의해서 새로운 조선왕조의 법궁으로 지어졌다. 경복궁은 동궐(창덕궁)이나 서궐(경희궁)에 비해 위치가 북쪽에 있어 ‘북궐’이라 불리기도 했다. 경복궁은 5대 궁궐 가운데 으뜸의 규모와 건축미를 자랑한다. 경복궁 근정전에서 즉위식을 가진 왕들을 보면 제2대 정종, 제4대 세종, 제6대 단종, 제7대 세조, 제9대 성종, 제11대 중종, 제13대 명종 등이다. 경복궁은 임진왜란 때 상당수의 건물이 불타 없어진 아픔을 갖고 있으며, 고종 때에 흥선대원군의 주도 아래 7,700여 칸에 이르는 건물들을 다시 세웠다. 그러나 또다시 명성황후 시해사건이 일어나면서 왕조의 몰락과 함께 경복궁도 왕궁으로서의 기능을 상실하고 말았다. 경복궁에는 조선시대의 대표적인 건축물인 경회루와 향원정의 연못이 원형대로 남아 있으며, 근정전의 월대와 조각상들은 당시의 조각미술을 대표한다. 현재 흥례문 밖 서편에는 국립고궁 박물관이 위치하고 있고, 경복궁 내 향원정의 동편에는 국립민속 박물관이 위치하고 있다.\n\n* 주요 문화재\n1) 사적 경복궁\n2) 국보 경복궁 근정전\n3) 국보 경복궁 경회루\n4) 보물 경복궁 자경전\n5) 보물 경복궁 자경전 십장생 굴뚝\n6) 보물 경복궁 아미산굴뚝\n7) 보물 경복궁 근정문 및 행각\n8) 보물 경복궁 풍기대\n\n◎ 한류의 매력을 만나는 여행 정보\n미국의 국민 TV 쇼 ‘더 투나잇 쇼 스타링 지미 팰런’에서는 ‘BTS위크’라는 이름을 붙여 닷새간 BTS 특별 방송을 진행했는데, 그중 BTS가 ‘맵 오브 더 솔 : 페르소나’ 미니앨범 수록곡 ‘소우주’와 ‘IDOL’을 부른 장소가 화제다. 그 장소는 바로 조선시대의 궁궐 중 하나인 ‘경복궁’의 경회루와 근정전이다. 보랏빛 조명에 아름답게 빛나던 경복궁에서 한국의 과거를 체험해 보길 추천한다."
        label.font = UIFont(name: "HakgyoansimBunpilR", size: 16)
        label.textColor = .label
        label.numberOfLines = 3
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    let seeMoreButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("더 보기 ", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .secondarySystemBackground
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.titleLabel?.font = UIFont(name: "HakgyoansimBunpilR", size: 16)
        return button
    }()
    
    let seeMoreOverviewStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 5
        return stackView
    }()
    
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        
        addSubview(basicView)
        
        basicView.addSubview(useTimeRestDateStackView)
        useTimeRestDateStackView.addArrangedSubview(useTimeStackView)
        useTimeRestDateStackView.addArrangedSubview(restDateStackView)
        
        useTimeStackView.addArrangedSubview(useTimeImageView)
        useTimeStackView.addArrangedSubview(useTimeLabel)
        
        restDateStackView.addArrangedSubview(restDateImageView)
        restDateStackView.addArrangedSubview(restDateLabel)
        
        basicView.addSubview(parkingPhoneStackView)
        parkingPhoneStackView.addArrangedSubview(parkingStackView)
        parkingPhoneStackView.addArrangedSubview(phoneStackView)
        
        parkingStackView.addArrangedSubview(parkingImageView)
        parkingStackView.addArrangedSubview(parkingLabel)
        
        phoneStackView.addArrangedSubview(phoneImageView)
        phoneStackView.addArrangedSubview(phoneLabel)
        
        basicView.addSubview(overviewTitleLabel)
        
        basicView.addSubview(seeMoreOverviewStackView)
        
        seeMoreOverviewStackView.addArrangedSubview(overviewContentLabel)
        seeMoreOverviewStackView.addArrangedSubview(seeMoreButton)
        
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layouts
    private func configureConstraints() {
        let basicViewConstraints = [
            basicView.leadingAnchor.constraint(equalTo: leadingAnchor),
            basicView.trailingAnchor.constraint(equalTo: trailingAnchor),
            basicView.topAnchor.constraint(equalTo: topAnchor),
            basicView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        
        let useTimeRestDateStackViewConstraints = [
            useTimeRestDateStackView.leadingAnchor.constraint(equalTo: basicView.leadingAnchor, constant: 15),
            useTimeRestDateStackView.topAnchor.constraint(equalTo: basicView.topAnchor),
            
        ]
        
        let parkingPhoneStackViewConstraints = [
            parkingPhoneStackView.leadingAnchor.constraint(equalTo: basicView.leadingAnchor, constant: 15),
            parkingPhoneStackView.topAnchor.constraint(equalTo: useTimeRestDateStackView.bottomAnchor, constant: 5),
        ]
        
        let overviewTitleLabelConstraints = [
            overviewTitleLabel.leadingAnchor.constraint(equalTo: basicView.leadingAnchor, constant: 10),
            overviewTitleLabel.topAnchor.constraint(equalTo: parkingPhoneStackView.bottomAnchor, constant: 20),
            overviewTitleLabel.trailingAnchor.constraint(equalTo: basicView.trailingAnchor, constant: -10)
        ]
        
        let seeMoreOverviewStackViewConstraints = [
            seeMoreOverviewStackView.leadingAnchor.constraint(equalTo: basicView.leadingAnchor, constant: 10),
            seeMoreOverviewStackView.trailingAnchor.constraint(equalTo: basicView.trailingAnchor, constant: -10),
            seeMoreOverviewStackView.topAnchor.constraint(equalTo: overviewTitleLabel.bottomAnchor, constant: 5),
            seeMoreOverviewStackView.bottomAnchor.constraint(equalTo: basicView.bottomAnchor, constant: -85)
        ]
        
        let useTimeStackViewConstraints = [
            useTimeStackView.widthAnchor.constraint(equalToConstant: 180)
        ]
        
        let restDateStackViewConstraints = [
            restDateStackView.widthAnchor.constraint(equalToConstant: 180)
        ]
        
        let parkingStackViewConstraints = [
            parkingStackView.widthAnchor.constraint(equalToConstant: 180)
        ]
        
        let phoneStackViewConstraints = [
            phoneStackView.widthAnchor.constraint(equalToConstant: 180)
        ]
        
        useTimeImageView.widthAnchor.constraint(equalToConstant: 22).isActive = true
        restDateImageView.widthAnchor.constraint(equalToConstant: 22).isActive = true
        parkingImageView.widthAnchor.constraint(equalToConstant: 22).isActive = true
        phoneImageView.widthAnchor.constraint(equalToConstant: 22).isActive = true
        seeMoreButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        NSLayoutConstraint.activate(basicViewConstraints)
        NSLayoutConstraint.activate(useTimeRestDateStackViewConstraints)
        NSLayoutConstraint.activate(parkingPhoneStackViewConstraints)
        NSLayoutConstraint.activate(overviewTitleLabelConstraints)
        NSLayoutConstraint.activate(seeMoreOverviewStackViewConstraints)
        
        // 추가
        NSLayoutConstraint.activate(useTimeStackViewConstraints)
        NSLayoutConstraint.activate(restDateStackViewConstraints)
        NSLayoutConstraint.activate(parkingStackViewConstraints)
        NSLayoutConstraint.activate(phoneStackViewConstraints)
        
        
        // 자동 줄바꿈을 위한 코드 삽입
        useTimeLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)  // 텍스트가 가로로 확장될 수 있도록 설정
        useTimeLabel.setContentCompressionResistancePriority(.required, for: .horizontal)  // 텍스트가 가로로 잘리지 않도록 설정
        
        restDateLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        restDateLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
    }
    
    
    // MARK: - Functions
    //    func updateLabels(with item: InfoItem) {
    //        // contentTypeId에 따라 영업시간 설정
    //        if let useTime = item.opentime  {
    //            if item.opentime?.count == 0 {
    //                useTimeLabel.text = "정보 없음"
    //            } else {
    //                useTimeLabel.text = removeHTMLTags(from: useTime)
    //            }
    //        }
    //
    //        // 휴무일 설정
    //        if let restDate = item.restDate {
    //            if restDate.count == 0 {
    //                restDateLabel.text = "정보 없음"
    //            } else {
    //                restDateLabel.text = removeHTMLTags(from: restDate)
    //            }
    //        }
    //
    //        // 주차 가능 여부 설정
    //        if let parkingInfo = item.parkingLot {
    //            if item.parkingLot?.count == 0 {
    //                parkingLabel.text = "주차 정보 없음"
    //            } else {
    //                parkingLabel.text = removeHTMLTags(from: parkingInfo)
    //            }
    //        }
    //
    //        // 전화번호 설정
    //        if let phone = item.phoneNumber {
    //            if item.phoneNumber?.count == 0 {
    //                phoneLabel.text = "전화번호 정보 없음"
    //            } else {
    //                phoneLabel.text = removeHTMLTags(from: phone)
    //            }
    //        }
    //    }
    
    
    // 위의 함수 리팩토링함
    func updateLabels(with item: InfoItem) {
        updateLabel(useTimeLabel, with: item.opentime, defaultText: "정보 없음")
        updateLabel(restDateLabel, with: item.restDate, defaultText: "정보 없음")
        updateLabel(parkingLabel, with: item.parkingLot, defaultText: "주차 정보 없음")
        updateLabel(phoneLabel, with: item.phoneNumber, defaultText: "전화번호 정보 없음")
    }
    
    private func updateLabel(_ label: UILabel, with text: String?, defaultText: String) {
        if let text = text, !text.isEmpty {
            label.text = removeHTMLTags(from: text)
        } else {
            label.text = defaultText
        }
    }
    
    func getOverview(with item: Item) {
        guard let overview = item.overview else { return }
        overviewContentLabel.text = overview
    }
}

