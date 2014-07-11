//
//  spatialindex.swift
//  Minilight
//
//  Created by James Tauber on 6/15/14.
//  Copyright (c) 2014 James Tauber. See LICENSE.
//

import Foundation

let MAX_LEVELS = 44
let MAX_ITEMS = 8

let TOLERANCE = 1.0 / 1024.0


protocol SpatialIndex {
    func getIntersection(#rayOrigin: Vector, rayDirection: Vector, lastHit: Triangle?) -> (Triangle?, Vector?)
    
}


// this is just does a brute-force search with no indexing
struct NullSpatialIndex: SpatialIndex {
    let triangles: [Triangle] = []
    let deepestLevel: Int
    
    init(eyePosition: Vector, triangles: [Triangle]) {
        self.triangles = triangles
        deepestLevel = 0
    }
    
    func getIntersection(#rayOrigin: Vector, rayDirection: Vector, lastHit: Triangle?) -> (Triangle?, Vector?) {
        var hitObject: Triangle?
        var hitPosition: Vector?
        
        var nearestDistance = Double.infinity
        
        for triangle in triangles {
            if let distance = triangle.getIntersection(rayOrigin: rayOrigin, rayDirection: rayDirection) {
                if distance > 0 && distance < nearestDistance {
                    hitObject = triangle
                    hitPosition = rayOrigin + rayDirection * distance
                    nearestDistance = distance
                }
            }
        }
        
        return (hitObject, hitPosition)
    }
}


//struct OctreeSpatialIndex: SpatialIndex {
//    let root: OctreeNode;
//    let deepestLevel: Int
//    
//    init(eyePosition: Vector, triangles: Triangle[]) {
//        let bound = Bound(point: eyePosition)
//        
//        var triangleBounds: (Triangle, Bound)[] = []
//        
//        for triangle in triangles {
//            let triangleBound = Bound(triangle: triangle)
//            triangleBounds.append(triangle, triangleBound)
//            bound.expandToFit(triangleBound)
//        }
//        
//        bound.clamp()
//        
//        root = OctreeNode(bound: bound, triangleBounds: triangleBounds, level: 0)
//        deepestLevel = root.deepestLevel
//    }
//    
//    func getIntersection(#rayOrigin: Vector, rayDirection: Vector, lastHit: Triangle?) -> (Triangle?, Vector?) {
//        return root.getIntersection(rayOrigin: rayOrigin, rayDirection: rayDirection, lastHit: lastHit, start: rayOrigin)
//    }
//}
//
//
//struct OctreeNode {
//
//    let bound: Bound
//    let isBranch: Bool
//    let children: OctreeNode?[]
//    let triangles: Triangle[]
//    let deepestLevel: Int
//
//    init(bound: Bound, triangleBounds: (Triangle, Bound)[], level: Int) {
//        self.bound = bound
//        deepestLevel = level
//        children = OctreeNode?[](count: 8, repeatedValue: nil)
//
//        isBranch = triangleBounds.count > MAX_ITEMS && level < MAX_LEVELS - 1
//        
//        if isBranch {
//            let q1 = 0
//            
//            for subCell in range(0..8) {
//                subBound = Bound(nil, nil)
//
//                for m in 0..3 {
//                    if (sub_cell >> m) % 2 == 1 {
//                    }
//                }
//            }
//        } else {
//        
//        }
//    }
//    
//    func getIntersection(#rayOrigin: Vector, rayDirection: Vector, lastHit: Triangle?, start: Vector) -> (Triangle?, Vector?) {
//        // @@@
//    }
//}
//
//
//
//struct Bound {
//    
//    let lower: Double[]
//    let upper: Double[]
//    
//    init(point: Vector) {
//        lower = [point.x, point.y, point.z]
//        upper = [point.x, point.y, point.z]
//    }
//    
//    init(triangle: Triangle) {
//        self.init(point: triangle.vertices[2])
//        
//        for j in 0..3 {
//            let v0 = triangle.vertices[0][j]
//            let v1 = triangle.vertices[1][j]
//            
//            if v0 < v1 {
//                if v0 < lower[j] {
//                    lower[j] = v0
//                }
//                if v1 > upper[j] {
//                    upper[j] = v1
//                }
//            } else {
//                if v1 < lower[j] {
//                    lower[j] = v1
//                }
//                if v0 > upper[j] {
//                    upper[j] = v0
//                }
//            }
//            
//            lower[j] -= (abs(lower[j]) + 1.0) * TOLERANCE
//            upper[j] += (abs(upper[j]) + 1.0) * TOLERANCE
//        }
//    }
//    
//    func expandToFit(bound: Bound) {
//        for j in 0..3 {
//            if lower[j] > bound.lower[j] {
//                lower[j] = bound.lower[j]
//            }
//            if upper[j] < bound.upper[j] {
//                upper[j] = bound.upper[j]
//            }
//        }
//    }
//    
//    func clamp() {
//        // @@@
//    }
//}
