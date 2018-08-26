//
//  ReservationViewController.swift
//  AirbnbProject
//
//  Created by 김승진 on 2018. 8. 13..
//  Copyright © 2018년 김승진. All rights reserved.
//

import UIKit
import CVCalendar

class ReservationViewController: UIViewController {

    @IBOutlet weak var menuView: CVCalendarMenuView!
    @IBOutlet weak var calendarView: CVCalendarView!
    
    @IBOutlet weak var startDay: UILabel?
    @IBOutlet weak var endDay: UILabel!
    @IBOutlet weak var currentMonth: UILabel!
    @IBOutlet weak var reservationSaveButton: UIButton!
    
    private var isSelectedStartDay: Bool = false
    private var isSelectedEndDay: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        let date = Date()
        self.currentMonth.text = currentMonthString(date: date)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        menuView.commitMenuViewUpdate()
        calendarView.commitCalendarViewUpdate()
    }
    
    private func setupUI() {
        self.reservationSaveButton.layer.cornerRadius = 5
        self.reservationSaveButton.layer.masksToBounds = true
    }
    
    private func currentMonthString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M월"
        return dateFormatter.string(from: date)
    }
    
    private func weekIntToString(weekInt: Int) -> String {
        switch weekInt {
        case 0: return "일"
        case 1: return "월"
        case 2: return "화"
        case 3: return "수"
        case 4: return "목"
        case 5: return "금"
        default: return "토"
        }
    }
    
    @IBAction func saveReservation(_ sender: UIButton) {
        if isSelectedStartDay == false {
            self.dismiss(animated: true, completion: nil)
            print("dismiss")
        } else {
            
        }
    }
    
    @IBAction func dismissBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}

extension ReservationViewController: CVCalendarViewDelegate, CVCalendarMenuViewDelegate, CVCalendarViewAppearanceDelegate {
    
    
    func presentationMode() -> CalendarMode {
        return .monthView
    }
    
    func firstWeekday() -> Weekday {
        return .sunday
    }

    func shouldSelectRange() -> Bool {
        return true
    }

    func shouldAutoSelectDayOnMonthChange() -> Bool {
        return false
    }
    
    func shouldAutoSelectDayOnWeekChange() -> Bool {
        return true
    }
    
    func shouldShowWeekdaysOut() -> Bool {
        return false
    }

    func dayLabelWeekdaySelectedBackgroundColor() -> UIColor {
        return UIColor(red: 0/255.0, green: 132/255.0, blue: 137.0/255, alpha: 1)
    }
    
    func dayLabelPresentWeekdayInitallyBold() -> Bool {
        return true
    }
    
    func shouldAnimateResizing() -> Bool {
        return false
    }
    
    func disableScrollingBeforeDate() -> Date {
        return Date()
    }

    func earliestSelectableDate() -> Date {
        return Date()
    }
    
    func calendar() -> Calendar? {
        return Calendar.init(identifier: Calendar.Identifier.gregorian)
    }
    
    func didShowNextMonthView(_ date: Date) {
        self.currentMonth.text = currentMonthString(date: date)
    }
    
    func didShowPreviousMonthView(_ date: Date) {
        self.currentMonth.text = currentMonthString(date: date)
    }

    func didSelectRange(from startDayView: DayView, to endDayView: DayView) {
        isSelectedStartDay = false
        if isSelectedEndDay == false {
            isSelectedEndDay = true
            
            //종료 날짜
            let endDayString: String? = String(endDayView.date.month) + "월\n" + String(endDayView.date.day) + "일 " + weekIntToString(weekInt: endDayView.date.week)
            let attrString = NSMutableAttributedString(string: endDayString!)
            let style = NSMutableParagraphStyle()
            style.lineSpacing = 10
            attrString.addAttribute(NSAttributedStringKey.paragraphStyle, value: style, range: NSRange(location: 0, length: attrString.length))
            self.endDay?.attributedText = attrString
            self.endDay?.textColor = .black
            
            print("end",endDayView.date.day)
        }
    }
    
    func didSelectDayView(_ dayView: DayView, animationDidFinish: Bool) {
        guard isSelectedEndDay != true else { return isSelectedEndDay = false}
        
        isSelectedStartDay = true
        
        let placeholdStr = NSMutableAttributedString(string: "종료\n날짜")
        let placeholdStrstyle = NSMutableParagraphStyle()
        placeholdStrstyle.lineSpacing = 10
        placeholdStr.addAttribute(NSAttributedStringKey.paragraphStyle, value: placeholdStrstyle, range: NSRange(location: 0, length: placeholdStr.length))
        
        self.endDay.attributedText = placeholdStr
        
        
        //시작 날짜
        let startDayString: String? = String(dayView.date.month) + "월\n" + String(dayView.date.day) + "일 " + weekIntToString(weekInt: dayView.date.week)
        
        let attrString = NSMutableAttributedString(string: startDayString!)
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 10
        attrString.addAttribute(NSAttributedStringKey.paragraphStyle, value: style, range: NSRange(location: 0, length: attrString.length))
        
        self.startDay?.attributedText = attrString
        self.startDay?.textColor = .black
    
        print("start:",dayView.date.day)
    }
    
    func endAndStartStringStyle(contentString: String) {
        
    }
}
