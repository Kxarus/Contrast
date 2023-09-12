//
//  TimeSlotsView.swift
//  contrast
//
//  Created by Roman Kiruxin on 05.07.2023.
//

import UIKit

protocol TimeSlotsViewDelegate: AnyObject {
    func dateSelection(date: TimeIntervalModel)
    func timeSelection(time: IntervalModel)
}

final class TimeSlotsView: UIView {

    private let datesCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout.init()
        flowLayout.scrollDirection = .horizontal
        
        flowLayout.sectionHeadersPinToVisibleBounds = true
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        cv.tag = 0
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .mainBackgroundColor
        return cv
    }()
    
    private let timesCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout.init()
        flowLayout.scrollDirection = .horizontal
        
        flowLayout.sectionHeadersPinToVisibleBounds = true
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        cv.tag = 1
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .mainBackgroundColor
        return cv
    }()
    
    weak var delegate: TimeSlotsViewDelegate?
    
    private var intervals: [TimeIntervalModel] = []
    private var currentDate = 0
    private var currentTime = 0
    private var isSelectedDate = false
    private var isSelectedTime = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension TimeSlotsView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionView.viewWithTag(0) {
            return intervals.count
        } else {
            if intervals.count == 0 {
                return 0
            }
            
            if intervals.contains(where: { interval in
                interval.isActive == true
            }) {
                return intervals[currentDate].intervals.count
            } else {
                return 0
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if collectionView == collectionView.viewWithTag(0) {
            let cell = collectionView.dequeueReusableCell(withType: DatesCollectionViewCell.self, for: indexPath)
            cell.setupCell(model: intervals[indexPath.item])
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withType: TimesCollectionViewCell.self, for: indexPath)
            for interval in intervals {
                if interval.isActive {
                    cell.setupCell(model: interval.intervals[indexPath.item])
                }
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collectionView.viewWithTag(0) {
            currentDate = indexPath.item
            
            var newTimeIntervals: [TimeIntervalModel] = []
            for interval in intervals {
                let item = TimeIntervalModel(day: interval.day, month: interval.month, intervals: interval.intervals, isActive: false)
                newTimeIntervals.append(item)
            }
            intervals = newTimeIntervals
            
            intervals[currentDate].isActive = true
            delegate?.dateSelection(date: intervals[currentDate])
            isSelectedDate = true
            datesCollectionView.reloadData()
            timesCollectionView.reloadData()
        } else {
            currentTime = indexPath.item
            
            var newIntervals: [TimeIntervalModel] = []
            for interval in intervals {
                var newIntervalModel: [IntervalModel] = []
                for time in interval.intervals {
                    let item = IntervalModel(id: time.id, timeStarts: time.timeStarts, timeFinish: time.timeFinish, isActive: false)
                    newIntervalModel.append(item)
                }
                let item = TimeIntervalModel(day: interval.day, month: interval.month, intervals: newIntervalModel, isActive: interval.isActive)
                newIntervals.append(item)
            }
            
            intervals = newIntervals
            intervals[currentDate].intervals[currentTime].isActive = true
            delegate?.timeSelection(time: intervals[currentDate].intervals[currentTime])
            isSelectedTime = true
            timesCollectionView.reloadData()
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == collectionView.viewWithTag(0) {
            return CGSize(width: 64, height: 58)
        } else {
            return CGSize(width: 110, height: 34)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 12, bottom: 10, right: 12)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(10)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(10)
    }
}

// MARK: - Private methods
private extension TimeSlotsView {
    
    private func setup() {
        addSubview(datesCollectionView)
        addSubview(timesCollectionView)
        
        datesCollectionView.delegate = self
        datesCollectionView.dataSource = self
        
        timesCollectionView.delegate = self
        timesCollectionView.dataSource = self
        
        registerCollectionViewCells()
        setupConstrains()
    }
    
    private func registerCollectionViewCells() {
        datesCollectionView.register(cellTypes: [DatesCollectionViewCell.self])
        timesCollectionView.register(cellTypes: [TimesCollectionViewCell.self])
    }
    
    private func setupConstrains() {
        
        datesCollectionView.snp.makeConstraints({
            $0.top.equalToSuperview().inset(8)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(58)
        })
        
        timesCollectionView.snp.makeConstraints({
            $0.top.equalTo(datesCollectionView.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(34)
        })
    }
}

// MARK: - Public methods
extension TimeSlotsView {
    func setupView(intervals: [TimeIntervalModel]) {
        self.intervals = intervals
        datesCollectionView.reloadData()
        timesCollectionView.reloadData()
    }
}
