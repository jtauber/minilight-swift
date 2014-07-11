//
//  camera.swift
//  Minilight
//
//  Created by James Tauber on 6/14/14.
//  Copyright (c) 2014 James Tauber. All rights reserved.
//

import Foundation

let MIN_ANGLE = 10.0
let MAX_ANGLE = 160.0

struct Camera {
    let viewPosition: Vector
    let viewDirection: Vector
    let viewAngle: Double

    let right: Vector
    let up: Vector
    
    init(position: Vector, direction:Vector, angle: Double) {
        self.viewPosition = position
        self.viewDirection = direction.unitize()
        self.viewAngle = min(max(angle, MIN_ANGLE), MAX_ANGLE) * (pi / 180)
        
        if viewDirection == ZERO { viewDirection = Vector(x:0.0, y:0.0, z:1.0) }
                
        // calculate right and up
        
        self.right = Vector(x:0.0, y:1.0, z:0.0).cross(viewDirection).unitize()
        
        if right == ZERO {
            if viewDirection.y > 0 {
                up = Vector(x: 0.0, y: 0.0, z: 1.0)
            } else {
                up = Vector(x: 0.0, y: 0.0, z: -1.0)
            }
            right = up.cross(viewDirection).unitize()
        } else {
            up = viewDirection.cross(right).unitize()
        }
    }
    
    func getFrame(scene: Scene, image: Image) {
        
        let raytracer = RayTracer(scene: scene)
        let aspect = Double(image.height) / Double(image.width)
        
        for y in 0..image.height {
            for x in 0..image.width {
                
                // convert x, y into sample_direction
                
                let xCoefficient = ((Double(x) + drand48()) * 2.0 / Double(image.width)) - 1.0
                let yCoefficient = ((Double(y) + drand48()) * 2.0 / Double(image.height)) - 1.0
                
                let offset = right * xCoefficient + up * (yCoefficient * aspect)
                let sampleDirection = (viewDirection + (offset * tan(viewAngle * 0.5))).unitize()
                
                // calculate radiance from that direction
                
                let radiance = raytracer.getRadiance(rayOrigin: viewPosition, rayDirection: sampleDirection, lastHit: nil)
                                
                // and add to image
                image.addRadiance(x: x, y: y, radiance: radiance)
            }
        }
    }
}