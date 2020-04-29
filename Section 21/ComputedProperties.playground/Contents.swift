import Foundation

let pizzaInInches: Int = 12
var numberOfPeople = 6
let slicesPerPerson = 3

var numberOfSlices: Int {
    get {
        return pizzaInInches - 4
    }
    set {
        print("Number of slices has a new value of \(newValue)")
    }
}

var numberOfPizza: Int {
    get {
        let numberOfPeoplePerPizza = numberOfSlices / slicesPerPerson
        return numberOfPeople / numberOfPeoplePerPizza
    }
    set {
        let totalSlices = numberOfSlices * newValue
        numberOfPeople = totalSlices / slicesPerPerson
    }
}
