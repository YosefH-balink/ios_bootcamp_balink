import UIKit

let workHoursInDay = 8
let workDaysInMonth = 22

func calculateDiscount (discount: Double) -> Double {
    (100 - discount) / 100
}

// Calculate the daily rate given an hourly rate
func dailyRateFrom (hourlyRate: Int) -> Double {
    Double(hourlyRate) * Double(workHoursInDay)
}
print(dailyRateFrom(hourlyRate: 60))

// Calculate the monthly rate, given an hourly rate and a discount
func monthlyRateFrom (hourlyRate: Int,
                     withDiscount: Double) -> Double{
    let dailyRate = dailyRateFrom (hourlyRate: hourlyRate)
    return  round((dailyRate * Double(workDaysInMonth)) * calculateDiscount(discount: withDiscount))
}
print(monthlyRateFrom(hourlyRate: 77, withDiscount: 10.5))

// Calculate the number of workdays given a budget
func workDaysIn(budget: Int,
                hourlyRate: Int,
                withDiscount: Double) -> Double {
  let dailyRateWithDiscount = monthlyRateFrom(
    hourlyRate:hourlyRate,
    withDiscount: withDiscount) / Double(workDaysInMonth)
    return round(Double(budget) / dailyRateWithDiscount)
}

print(workDaysIn(budget: 22000, hourlyRate: 80, withDiscount: 11.0))

// Compute whether or not you can afford the monthly payments on a car
func canIBuy(vehicle: String,
             price: Double,
             monthlyBudget: Double) {
    let montsOfNoInterest = 60
    let monthlyPaymentForVehicle = price /  Double(montsOfNoInterest)
    
    if monthlyPaymentForVehicle <= monthlyBudget {
        print("Yes! I'm getting a \(vehicle)")
    } else if   monthlyPaymentForVehicle <= monthlyBudget * 1.1    {
        print( "I'll have to be frugal if I want a \(vehicle)")
    } else {
        print("Darn! No \(vehicle) for me")
    }
}

canIBuy(vehicle: "1974 Ford Pinto", price: 516.32, monthlyBudget: 100.00)
// => "Yes! I'm getting a 1974 Ford Pinto"
canIBuy(vehicle: "2011 Bugatti Veyron", price: 2_250_880.00, monthlyBudget: 10000.00)
// => "Darn! No 2011 Bugatti Veyron for me"
canIBuy(vehicle: "2020 Indian FTR 1200", price: 12_500, monthlyBudget: 200)
// => "I'll have to be frugal if I want a 2020 Indian FTR 1200"
