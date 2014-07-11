//
//  Vector.swift
//  Minilight
//
//  Created by James Tauber on 6/14/14.
//  Copyright (c) 2014 James Tauber. See LICENSE.
//

import Foundation

struct Vector: Equatable, Printable {
    
    let x, y, z: Double

    var description: String {
        return "(\(x), \(y), \(z))"
    }

    init() {
        self.init(n: 0.0)
    }
    
    init(n: Double) {
        self.init(x: n, y: n, z: n)
    }
    
    init(x: Double, y: Double, z: Double) {
        self.x = x
        self.y = y
        self.z = z
    }
    
    init(other: Vector) {
        self.init(x: other.x, y: other.y, z: other.z)
    }
    
    subscript(index: Int) -> Double {
        return [x, y, z][index]
    }
    

    func unitize() -> Vector {
        let length = sqrt(x * x + y * y + z * z)
        if length > 0 {
            return self * (1.0 / length)
        } else {
            return Vector()
        }
    }
    
    func cross(other:Vector) -> Vector {
        return Vector(
            x: (y * other.z) - (z * other.y),
            y: (z * other.x) - (x * other.z),
            z: (x * other.y) - (y * other.x)
        )
    }
    func dot(other:Vector) -> Double {
        return (x * other.x) + (y * other.y) + (z * other.z)
    }
    
    func clamped(#lo: Vector, hi: Vector) -> Vector {
        return Vector(
            x: min(max(x, lo.x), hi.x),
            y: min(max(y, lo.y), hi.y),
            z: min(max(z, lo.z), hi.z)
        )
    }
}

func +(lhs: Vector, rhs: Vector) -> Vector {
    return Vector(x: lhs.x + rhs.x, y: lhs.y + rhs.y, z: lhs.z + rhs.z)
}

func -(lhs: Vector, rhs: Vector) -> Vector {
    return Vector(x: lhs.x - rhs.x, y: lhs.y - rhs.y, z: lhs.z - rhs.z)
}

@prefix func -(v: Vector) -> Vector {
    return Vector(x: -v.x, y: -v.y, z: -v.z)
}

// component-wise multiplication
func *(lhs: Vector, rhs: Vector) -> Vector {
    return Vector(x: lhs.x * rhs.x, y: lhs.y * rhs.y, z: lhs.z * rhs.z)
}

// scalar multiplication
func *(lhs: Vector, rhs: Double) -> Vector {
    return Vector(x: lhs.x * rhs, y: lhs.y * rhs, z: lhs.z * rhs)
}

func ==(lhs: Vector, rhs: Vector) -> Bool {
    return lhs.x == rhs.x && lhs.y == rhs.y && lhs.z == rhs.z
}


let ZERO = Vector()
let ONE = Vector(n: 1.0)
let MAX = Vector(n: Double(pow(2, 1024) - pow(2, 971)))
