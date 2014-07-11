//
//  raytracer.swift
//  Minilight
//
//  Created by James Tauber on 6/14/14.
//  Copyright (c) 2014 James Tauber. All rights reserved.
//

import Foundation

struct RayTracer {
    let scene: Scene;
    
    func getRadiance(#rayOrigin: Vector, rayDirection: Vector, lastHit: Triangle?) -> Vector {

        let (hitObject, hitPosition) = scene.getIntersection(rayOrigin: rayOrigin, rayDirection: rayDirection, lastHit: lastHit)
        
        if hitObject {
            let surfacePoint = SurfacePoint(triangle: hitObject!, position: hitPosition!)
            let localEmission = lastHit ? ZERO : surfacePoint.getEmission(rayOrigin, outDirection: -rayDirection, isSolidAngle: false)
            let illumination = sampleEmitters(rayDirection: rayDirection, surfacePoint: surfacePoint)
            let (nextDirection, color) = surfacePoint.getNextDirection(-rayDirection)

            let reflection = nextDirection ? color * getRadiance(rayOrigin: surfacePoint.position, rayDirection: nextDirection!, lastHit: surfacePoint.triangle) : ZERO
            
            println("\(hitObject!.vertices[0]) \(reflection) \(illumination) \(localEmission) \(color)")
            return reflection + illumination + localEmission
        } else {
            return scene.getDefaultEmission(-rayDirection)
        }
    }

    func sampleEmitters(#rayDirection: Vector, surfacePoint: SurfacePoint) -> Vector {
        
        let (emitterPosition, emitter) = self.scene.getEmitter()

        if emitter {
            let emitDirection = (emitterPosition - surfacePoint.position).unitize()
            let (hitObject, hitPosition) = scene.getIntersection(rayOrigin: surfacePoint.position, rayDirection: emitDirection, lastHit: surfacePoint.triangle)
            
            var emissionIn: Vector = ZERO
            if !(hitObject && (emitter != hitObject!)) {
                emissionIn = SurfacePoint(triangle: emitter!, position: emitterPosition).getEmission(surfacePoint.position, outDirection: -emitDirection, isSolidAngle: true)
            }
            
            return surfacePoint.getReflection(inDirection: emitDirection, inRadiance: emissionIn * Double(scene.emitters.count), outDirection: -rayDirection)
        } else {
            return ZERO
        }
    }
}
