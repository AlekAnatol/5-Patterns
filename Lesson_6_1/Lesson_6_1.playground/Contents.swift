import UIKit

protocol Coffee {
    var cost: Int { get }
}

class SimpleCoffee: Coffee {
    var cost: Int {
    return 100 }
}

protocol CoffeeDecorator: Coffee {
    var base: Coffee { get }
    init(base: Coffee)
}

class Milk: CoffeeDecorator {
    let base: Coffee
    var cost: Int {
        return base.cost + 50
    }
    required init(base: Coffee) {
        self.base = base
    }
}

class Cream: CoffeeDecorator {
    let base: Coffee
    var cost: Int {
        return base.cost + 70
    }
    required init(base: Coffee) {
        self.base = base
    }
}

class VegetableMilk: CoffeeDecorator {
    let base: Coffee
    var cost: Int {
        return base.cost + 100
    }
    required init(base: Coffee) {
        self.base = base
    }
}

class Sugar: CoffeeDecorator {
    let base: Coffee
    var cost: Int {
        return base.cost + 10
    }
    required init(base: Coffee) {
        self.base = base
    }
}

class Syrop: CoffeeDecorator {
    let base: Coffee
    var cost: Int {
        return base.cost + 30
    }
    required init(base: Coffee) {
        self.base = base
    }
}

let coffee = SimpleCoffee()
let coffeeWithMilk = Milk(base: coffee)
let coffeeWithVegetableMilk = VegetableMilk(base: coffee)
let coffeeWithVegetableMilkAndSyrop = Syrop(base: coffeeWithVegetableMilk)
let coffeeWithMilkAndSugar = Sugar(base: coffeeWithMilk)
let coffeeWithSyrop = Syrop(base: coffee)
let coffeeWithDoubleSyrop = Syrop(base: coffeeWithSyrop)

print(coffee.cost)
print(coffeeWithMilk.cost)
print(coffeeWithVegetableMilk.cost)
print(coffeeWithVegetableMilkAndSyrop.cost)
print(coffeeWithMilkAndSugar.cost)
print(coffeeWithSyrop.cost)
print(coffeeWithDoubleSyrop.cost)
