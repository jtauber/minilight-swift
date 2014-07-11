//
//  triangle.swift
//  Minilight
//
//  Created by James Tauber on 6/14/14.
//  Copyright (c) 2014 James Tauber. See LICENSE.
//

import Foundation

struct Triangle: Equatable {
    
    let vertices: [Vector]
    let reflectivity: Vector
    let emitivity: Vector
    
    let edge0: Vector
    let edge1: Vector
    let edge2: Vector
    
    let tangent: Vector
    let normal: Vector
    
    let area: Double
    
    init(v0: Vector, v1: Vector, v2:Vector, r:Vector, e:Vector) {
        vertices = [v0, v1, v2]
        reflectivity = r.clamped(lo: ZERO, hi: ONE)
        emitivity = e.clamped(lo: ZERO, hi: MAX)
        
        edge0 = v1 - v0
        edge1 = v2 - v1
        edge2 = v2 - v0
        
        tangent = edge0.unitize()
        normal = tangent.cross(edge1).unitize()
        
        let pa2 = edge0.cross(edge1)
        area = sqrt(pa2.dot(pa2)) * 0.5
        
        println()
        println("\(vertices[0])")
        println("\(reflectivity)")
        println("t=\(tangent), n=\(normal), a=\(area)")
    }
    
    func getIntersection(#rayOrigin: Vector, rayDirection: Vector) -> Double? {
    
        let e1x = edge0.x
        let e1y = edge0.y
        let e1z = edge0.z
        
        let e2x = edge2.x
        let e2y = edge2.y
        let e2z = edge2.z
        
        let pvx = rayDirection.y * e2z - rayDirection.z * e2y
        let pvy = rayDirection.z * e2x - rayDirection.x * e2z
        let pvz = rayDirection.x * e2y - rayDirection.y * e2x
        
        let det = e1x * pvx + e1y * pvy + e1z * pvz
        
        if abs(det) < 0.000001 {
            return nil
        }
        
        let invDet = 1.0 / det
        let v0 = self.vertices[0]
        
        let tvx = rayOrigin.x - v0.x
        let tvy = rayOrigin.y - v0.y
        let tvz = rayOrigin.z - v0.z
        
        let u = (tvx * pvx + tvy * pvy + tvz * pvz) * invDet
        
        if (u < 0.0) || (u > 1.0) {
            return nil
        }
        
        let qvx = tvy * e1z - tvz * e1y
        let qvy = tvz * e1x - tvx * e1z
        let qvz = tvx * e1y - tvy * e1x
        
        let v = (rayDirection.x * qvx + rayDirection.y * qvy + rayDirection.z * qvz) * invDet
        
        if (v < 0.0) || (u + v > 1.0) {
            return nil
        }
        
        let t = (e2x * qvx + e2y * qvy + e2z * qvz) * invDet
        
        if t < 0.0 {
            return nil
        }
        
        return t
    }
    
    func getSamplePoint() -> Vector {
        let sqr1 = sqrt(drand48())
        let r2 = drand48()
        let a = 1.0 - sqr1
        let b = (1.0 - r2) * sqr1
        
        return edge0 * a + edge2 * b + self.vertices[0]
    }
}

func ==(lhs: Triangle, rhs: Triangle) -> Bool {
    return lhs.edge0 == rhs.edge0 && lhs.edge1 == rhs.edge1 && lhs.edge2 == rhs.edge2 && lhs.reflectivity == rhs.reflectivity && lhs.emitivity == rhs.emitivity
}