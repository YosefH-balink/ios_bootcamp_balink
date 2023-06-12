import UIKit

//1. compute slice sizes which returns nil for invalid input
func sliceSize(diameter: Double?, slices: Int?) -> Double? {
    
    if IsNilOrDiameterNegativeOrSlicesLessThen1 (diameter: diameter, slices: slices){
        return calculateAreaOfCircleFromDiameter (diameter: diameter!) / Double(slices!)
    } else  {
        return nil
    }
}
 
// calculates area of circle from diameter
func calculateAreaOfCircleFromDiameter (diameter: Double) -> Double {
    let pi = 3.14159265359
    let radius = diameter / 2
    return pi * pow(radius, 2)
}
 

// returns false if nil, or Diameter is negative,
// or slices is less then 1.
func IsNilOrDiameterNegativeOrSlicesLessThen1
    (diameter: Double?, slices: Int?) -> Bool {
    switch (diameter, slices) {
    case let (diam?, slic?): return diam > 1 && slic >= 1
    default: return false
    }
}

sliceSize(diameter: 16, slices: 12)
// => 16.75516081914556
sliceSize(diameter: nil, slices: 8)
// => nil


//2. Process inputs to determine the larger slice.
func biggestSlice(diameterA: String, slicesA: String, diameterB: String, slicesB: String) -> String {
    
    let diameter1 = Double(diameterA)
    let slices1 = Int(slicesA)
    let diameter2 = Double(diameterB)
    let slices2 = Int(slicesB)
    
    let sliceSize1 = sliceSize(diameter: diameter1, slices: slices1)
    let sliceSize2 = sliceSize(diameter: diameter2, slices: slices2)
    
    let message: String
    
    if (sliceSize1 == nil && sliceSize2 == nil){
        message = "Neither slice is bigger"
    } else if (sliceSize1 != nil && sliceSize2 == nil) {
        message = "Slice A is bigger"
    }else if (sliceSize1 == nil && sliceSize2 != nil) {
        message = "Slice B is bigger"
    }else if (sliceSize1! > sliceSize2!) {
        message = "Slice A is bigger"
    }else  {
        message = "Slice B is bigger"
    }
    
       return message
}


biggestSlice(diameterA: "10", slicesA: "6", diameterB: "14", slicesB: "12")
// => Slice A is bigger
biggestSlice(diameterA: "10", slicesA: "6", diameterB: "12", slicesB: "8")
// => Slice B is bigger
biggestSlice(diameterA: "Pepperoni", slicesA: "6", diameterB: "Sausage", slicesB: "12")
// => Neither slice is bigger
