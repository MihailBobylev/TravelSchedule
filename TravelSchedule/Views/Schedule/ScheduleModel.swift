//
//  CarrierModel.swift
//  TravelSchedule
//
//  Created by Михаил Бобылев on 14.10.2025.
//

import Foundation

struct ScheduleModel: Hashable {
    let carrier: Components.Schemas.Carrier
    let startDate: String
    
    let departure: String
    let arrival: String
    let duration: Int
    let hasTransfers: Bool
    
    var formattedStartDate: String {
        guard let date = DateFormatterCache.input.date(from: startDate) else {
            return startDate
        }
        return DateFormatterCache.output.string(from: date)
    }
    
    var formattedDeparture: String {
        guard let time = DateFormatterCache.inputTime.date(from: departure) else {
            return departure
        }
        return DateFormatterCache.outputTime.string(from: time)
    }
    
    var formattedArrival: String {
        guard let time = DateFormatterCache.inputTime.date(from: arrival) else {
            return arrival
        }
        return DateFormatterCache.outputTime.string(from: time)
    }
    
    var formattedDuration: String {
        let totalMinutes = duration / 60
        let hours = totalMinutes / 60
        let minutes = totalMinutes % 60
        
        if hours > 0 {
            return "\(hours) \(hourWord(for: hours))"
        } else {
            return "\(minutes) \(minuteWord(for: minutes))"
        }
    }
}

private extension ScheduleModel {
    func hourWord(for count: Int) -> String {
        let mod10 = count % 10
        let mod100 = count % 100
        if mod10 == 1 && mod100 != 11 {
            return "час"
        } else if (2...4).contains(mod10) && !(12...14).contains(mod100) {
            return "часа"
        } else {
            return "часов"
        }
    }
    
    func minuteWord(for count: Int) -> String {
        let mod10 = count % 10
        let mod100 = count % 100
        if mod10 == 1 && mod100 != 11 {
            return "минута"
        } else if (2...4).contains(mod10) && !(12...14).contains(mod100) {
            return "минуты"
        } else {
            return "минут"
        }
    }
}
