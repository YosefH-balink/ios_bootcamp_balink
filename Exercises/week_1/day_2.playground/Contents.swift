import UIKit

// compute slice sizes which returns nil for invalid input
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

