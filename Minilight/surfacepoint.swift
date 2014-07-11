//
//  surfacepoint.swift
//  Minilight
//
//  Created by James Tauber on 6/15/14.
//  Copyright (c) 2014 James Tauber. All rights reserved.
//

import Foundation

struct SurfacePoint {
    let triangle: Triangle
    let position: Vector

    func getEmission(toPosition: Vector, outDirection: Vector, isSolidAngle: Bool) -> Vector {
    
        let ray = toPosition - position
        let distance2 = ray.dot(ray)
        let cosArea = outDirection.dot(triangle.normal) * self.triangle.area
        let solidAngle = isSolidAngle ? cosArea / max(distance2, 1e-6) : 1.0
    
        return (cosArea > 0.0) ? triangle.emitivity * solidAngle : ZERO
    }
    
    func getReflection(#inDirection: Vector, inRadiance: Vector, outDirection: Vector) -> Vector {
    
        let inDot = inDirection.dot(triangle.normal)
        let outDot = outDirection.dot(triangle.normal)
        
        return ((inDot < 0.0) ^ (outDot < 0.0)) ? ZERO : inRadiance * triangle.reflectivity * (abs(inDot) / pi)
    }
    
    func getNextDirection(inDirection: Vector) -> (Vector?, Vector) {

        let reflectivityMean = triangle.reflectivity.dot(ONE) / 3.0
        
        if drand48() < reflectivityMean {
            let color = triangle.reflectivity * (1.0 / reflectivityMean)
            let _2pr1 = pi * 2.0 * drand48()
            let sr2 = sqrt(drand48())
            
            let x = (cos(_2pr1) * sr2)
            let y = (sin(_2pr1) * sr2)
            let z = sqrt(1.0 - (sr2 * sr2))
            
            var normal = triangle.normal
            let tangent = triangle.tangent
            
            if normal.dot(inDirection) < 0.0 {
                normal = -normal
            }
            
            let outDirection = (tangent * x) + (normal.cross(tangent) * y) + (normal * z)
            
            return (outDirection, color)
        } else {
            return (nil, ZERO)
        }
    }
}
