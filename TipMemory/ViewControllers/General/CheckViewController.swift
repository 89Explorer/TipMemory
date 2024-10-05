//
//  CheckViewController.swift
//  TipMemory
//
//  Created by 권정근 on 10/3/24.
//

import UIKit
import DGCharts

class CheckViewController: UIViewController {
    var barChartView: BarChartView!

     override func viewDidLoad() {
         super.viewDidLoad()
         view.backgroundColor = .systemBackground

         // BarChartView 인스턴스 생성 및 크기 설정
         barChartView = BarChartView()
         barChartView.translatesAutoresizingMaskIntoConstraints = false
         
         
         // 그래프를 뷰에 추가
         view.addSubview(barChartView)
         
         // barChartView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height / 2)
         // barChartView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 300)
         // barChartView.center = view.center

         NSLayoutConstraint.activate([
            barChartView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            barChartView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            barChartView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            barChartView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50)
         ])
         
         // 그래프 데이터 설정
         var entries: [BarChartDataEntry] = []
         let today = Date()
         print(today)

         // x축 데이터: 오늘부터 7일
         for i in 0..<7 {
             _ = Calendar.current.date(byAdding: .day, value: i, to: today)!
             entries.append(BarChartDataEntry(x: Double(i), y: Double(10 * (i + 1)))) // y값은 임의로 설정
         }

         // BarChartDataSet 생성 및 색상 동일하게 설정
         let dataSet = BarChartDataSet(entries: entries, label: "Sales")
         dataSet.colors = [NSUIColor.systemBlue] // 모든 막대를 같은 색상으로 설정
         dataSet.valueTextColor = .label // 막대 위에 표시될 값의 색상
         dataSet.valueFont = .systemFont(ofSize: 12) // 막대 위 값의 폰트 크기

         // BarChartData 생성
         let data = BarChartData(dataSet: dataSet)
         barChartView.data = data

         // X축에 날짜를 표시하는 Formatter 설정
         let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = "MM/dd"

         // X축에 오늘부터 7일까지 날짜 표시
         barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: getFutureDates(forDays: 7, from: today, formatter: dateFormatter))
         barChartView.xAxis.granularity = 1 // x축 간격을 1로 설정하여 모든 막대마다 날짜 표시
         barChartView.xAxis.labelPosition = .bottom // X축 레이블을 아래쪽에 표시

         // 막대 위에 값 표시 설정
         barChartView.data?.setDrawValues(true)

         // 그래프 애니메이션
         barChartView.animate(yAxisDuration: 1.5)

         barChartView.xAxis.drawGridLinesEnabled = false  // X축 눈금선 제거
         barChartView.rightAxis.drawGridLinesEnabled = false // Y축(오른쪽) 눈금선 제거
         barChartView.highlightPerTapEnabled = false // 막대 선택 삭제 

         barChartView.rightAxis.enabled = false  // y축(오른쪽) 해제
     }


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
}
