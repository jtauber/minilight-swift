//
//  scene.swift
//  Minilight
//
//  Created by James Tauber on 6/14/14.
//  Copyright (c) 2014 James Tauber. See LICENSE.
//

import Foundation

struct Scene {
    let skyEmission: Vector;
    let groundReflection: Vector;
    
    let emitters: [Triangle] = []
    
    let index: SpatialIndex
    
    init(skyEmission: Vector, groundReflection: Vector, eyePosition: Vector, triangles: [Triangle]) {
        self.skyEmission = skyEmission
        self.groundReflection = groundReflection
        
        for triangle in triangles {
            if (triangle.emitivity != ZERO && triangle.area > 0.0) {
                emitters.append(triangle)
            }
        }
        
        println("loaded \(triangles.count) triangles (\(emitters.count) emitters)")
        
        index = NullSpatialIndex(eyePosition: eyePosition, triangles: triangles)
    }
    
    func getIntersection(#rayOrigin: Vector, rayDirection: Vector, lastHit: Triangle?) -> (Triangle?, Vector?) {
        return index.getIntersection(rayOrigin: rayOrigin, rayDirection: rayDirection, lastHit: lastHit)
    }
    
    func getEmitter() -> (Vector, Triangle?) {
        if emitters.count > 0 {
            let choice = Int(arc4random_uniform(UInt32(emitters.count)))
            let emitter = emitters[choice]
            return (emitter.getSamplePoint(), emitter)
        } else {
            return (ZERO, nil)
        }
    }
    
    func getDefaultEmission(backDirection: Vector) -> Vector {
        return (backDirection.y < 0.0) ? self.skyEmission : self.skyEmission * self.groundReflection
    }
}
