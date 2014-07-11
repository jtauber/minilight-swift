//
//  main.swift
//  Minilight
//
//  Created by James Tauber on 6/14/14.
//  Copyright (c) 2014 James Tauber. See LICENSE.
//

import Foundation

srand48(0);

let iterations = 5

let width = 100
let height = 100

let image = Image(width: width, height: height)

let position = Vector(x:0.278, y:0.275, z:-0.789)
let direction =  Vector(x:0, y:0, z:1)
let angle =  40.0

let camera = Camera(position: position, direction: direction, angle: angle)

//let skyEmission = Vector(x:0.0906, y:0.0943, z:0.1151)
let skyEmission = Vector(x:4532, y:4712, z:5756)
let groundReflection = Vector(x:0.1, y:0.09, z:0.07)

let triangles = [
//    Triangle(v0:Vector(x:0.556, y:0.000, z:0.000), v1:Vector(x:0.000, y:0.000, z:0.559), v2:Vector(x:0.556, y:0.000, z:0.559), r:Vector(x:0.7, y:0.7, z:0.7), e:Vector(x:0.0, y:0.0, z:0.0)),
//    Triangle(v0:Vector(x:0.000, y:0.000, z:0.559), v1:Vector(x:0.556, y:0.000, z:0.000), v2:Vector(x:0.000, y:0.000, z:0.000), r:Vector(x:0.7, y:0.7, z:0.7), e:Vector(x:0.0, y:0.0, z:0.0)),
//
//    Triangle(v0:Vector(x:0.556, y:0.000, z:0.559), v1:Vector(x:0.000, y:0.549, z:0.559), v2:Vector(x:0.556, y:0.549, z:0.559), r:Vector(x:0.7, y:0.7, z:0.7), e:Vector(x:0.0, y:0.0, z:0.0)),
//    Triangle(v0:Vector(x:0.000, y:0.549, z:0.559), v1:Vector(x:0.556, y:0.000, z:0.559), v2:Vector(x:0.000, y:0.000, z:0.559), r:Vector(x:0.7, y:0.7, z:0.7), e:Vector(x:0.0, y:0.0, z:0.0)),
//
//    Triangle(v0:Vector(x:0.000, y:0.000, z:0.559), v1:Vector(x:0.000, y:0.549, z:0.000), v2:Vector(x:0.000, y:0.549, z:0.559), r:Vector(x:0.7, y:0.2, z:0.2), e:Vector(x:0.0, y:0.0, z:0.0)),
//    Triangle(v0:Vector(x:0.000, y:0.549, z:0.000), v1:Vector(x:0.000, y:0.000, z:0.559), v2:Vector(x:0.000, y:0.000, z:0.000), r:Vector(x:0.7, y:0.2, z:0.2), e:Vector(x:0.0, y:0.0, z:0.0)),
//    
//    Triangle(v0:Vector(x:0.556, y:0.000, z:0.000), v1:Vector(x:0.556, y:0.549, z:0.559), v2:Vector(x:0.556, y:0.549, z:0.000), r:Vector(x:0.2, y:0.7, z:0.2), e:Vector(x:0.0, y:0.0, z:0.0)),
//    Triangle(v0:Vector(x:0.556, y:0.549, z:0.559), v1:Vector(x:0.556, y:0.000, z:0.000), v2:Vector(x:0.556, y:0.000, z:0.559), r:Vector(x:0.2, y:0.7, z:0.2), e:Vector(x:0.0, y:0.0, z:0.0)),

//    Triangle(v0:Vector(x:0.556, y:0.549, z:0.559), v1:Vector(x:0.000, y:0.549, z:0.000), v2:Vector(x:0.556, y:0.549, z:0.000), r:Vector(x:0.7, y:0.7, z:0.7), e:Vector(x:0.0, y:0.0, z:0.0)),
//    Triangle(v0:Vector(x:0.000, y:0.549, z:0.000), v1:Vector(x:0.556, y:0.549, z:0.559), v2:Vector(x:0.000, y:0.549, z:0.559), r:Vector(x:0.7, y:0.7, z:0.7), e:Vector(x:0.0, y:0.0, z:0.0)),
//
//    Triangle(v0:Vector(x:0.343, y:0.545, z:0.332), v1:Vector(x:0.213, y:0.545, z:0.227), v2:Vector(x:0.343, y:0.545, z:0.227), r:Vector(x:0.7, y:0.7, z:0.7), e:Vector(x:1000.0, y:1000.0, z:1000.0)),
//    Triangle(v0:Vector(x:0.213, y:0.545, z:0.227), v1:Vector(x:0.343, y:0.545, z:0.332), v2:Vector(x:0.213, y:0.545, z:0.332), r:Vector(x:0.7, y:0.7, z:0.7), e:Vector(x:1000.0, y:1000.0, z:1000.0)),

//    Triangle(v0:Vector(x:0.316, y:0.165, z:0.272), v1:Vector(x:0.426, y:0.165, z:0.065), v2:Vector(x:0.474, y:0.165, z:0.225), r:Vector(x:0.7, y:0.7, z:0.7), e:Vector(x:0.0, y:0.0, z:0.0)),
//    Triangle(v0:Vector(x:0.426, y:0.165, z:0.065), v1:Vector(x:0.316, y:0.165, z:0.272), v2:Vector(x:0.266, y:0.165, z:0.114), r:Vector(x:0.7, y:0.7, z:0.7), e:Vector(x:0.0, y:0.0, z:0.0)),
//    Triangle(v0:Vector(x:0.266, y:0.000, z:0.114), v1:Vector(x:0.266, y:0.165, z:0.114), v2:Vector(x:0.316, y:0.165, z:0.272), r:Vector(x:0.7, y:0.7, z:0.7), e:Vector(x:0.0, y:0.0, z:0.0)),
//    Triangle(v0:Vector(x:0.316, y:0.000, z:0.272), v1:Vector(x:0.266, y:0.000, z:0.114), v2:Vector(x:0.316, y:0.165, z:0.272), r:Vector(x:0.7, y:0.7, z:0.7), e:Vector(x:0.0, y:0.0, z:0.0)),
//    Triangle(v0:Vector(x:0.316, y:0.000, z:0.272), v1:Vector(x:0.316, y:0.165, z:0.272), v2:Vector(x:0.474, y:0.165, z:0.225), r:Vector(x:0.7, y:0.7, z:0.7), e:Vector(x:0.0, y:0.0, z:0.0)),
//    Triangle(v0:Vector(x:0.474, y:0.165, z:0.225), v1:Vector(x:0.316, y:0.000, z:0.272), v2:Vector(x:0.474, y:0.000, z:0.225), r:Vector(x:0.7, y:0.7, z:0.7), e:Vector(x:0.0, y:0.0, z:0.0)),
//    Triangle(v0:Vector(x:0.474, y:0.000, z:0.225), v1:Vector(x:0.474, y:0.165, z:0.225), v2:Vector(x:0.426, y:0.165, z:0.065), r:Vector(x:0.7, y:0.7, z:0.7), e:Vector(x:0.0, y:0.0, z:0.0)),
//    Triangle(v0:Vector(x:0.426, y:0.165, z:0.065), v1:Vector(x:0.426, y:0.000, z:0.065), v2:Vector(x:0.474, y:0.000, z:0.225), r:Vector(x:0.7, y:0.7, z:0.7), e:Vector(x:0.0, y:0.0, z:0.0)),
    Triangle(v0:Vector(x:0.426, y:0.000, z:0.065), v1:Vector(x:0.426, y:0.165, z:0.065), v2:Vector(x:0.266, y:0.165, z:0.114), r:Vector(x:0.7, y:0.7, z:0.7), e:Vector(x:0.0, y:0.0, z:0.0)),
    Triangle(v0:Vector(x:0.266, y:0.165, z:0.114), v1:Vector(x:0.266, y:0.000, z:0.114), v2:Vector(x:0.426, y:0.000, z:0.065), r:Vector(x:0.7, y:0.7, z:0.7), e:Vector(x:0.0, y:0.0, z:0.0)),

//    Triangle(v0:Vector(x:0.133, y:0.330, z:0.247), v1:Vector(x:0.291, y:0.330, z:0.296), v2:Vector(x:0.242, y:0.330, z:0.456), r:Vector(x:0.7, y:0.7, z:0.7), e:Vector(x:0.0, y:0.0, z:0.0)),
//    Triangle(v0:Vector(x:0.242, y:0.330, z:0.456), v1:Vector(x:0.084, y:0.330, z:0.406), v2:Vector(x:0.133, y:0.330, z:0.247), r:Vector(x:0.7, y:0.7, z:0.7), e:Vector(x:0.0, y:0.0, z:0.0)),
//    Triangle(v0:Vector(x:0.133, y:0.000, z:0.247), v1:Vector(x:0.133, y:0.330, z:0.247), v2:Vector(x:0.084, y:0.330, z:0.406), r:Vector(x:0.7, y:0.7, z:0.7), e:Vector(x:0.0, y:0.0, z:0.0)),
//    Triangle(v0:Vector(x:0.084, y:0.330, z:0.406), v1:Vector(x:0.084, y:0.000, z:0.406), v2:Vector(x:0.133, y:0.000, z:0.247), r:Vector(x:0.7, y:0.7, z:0.7), e:Vector(x:0.0, y:0.0, z:0.0)),
//    Triangle(v0:Vector(x:0.084, y:0.000, z:0.406), v1:Vector(x:0.084, y:0.330, z:0.406), v2:Vector(x:0.242, y:0.330, z:0.456), r:Vector(x:0.7, y:0.7, z:0.7), e:Vector(x:0.0, y:0.0, z:0.0)),
//    Triangle(v0:Vector(x:0.242, y:0.330, z:0.456), v1:Vector(x:0.242, y:0.000, z:0.456), v2:Vector(x:0.084, y:0.000, z:0.406), r:Vector(x:0.7, y:0.7, z:0.7), e:Vector(x:0.0, y:0.0, z:0.0)),
//    Triangle(v0:Vector(x:0.242, y:0.000, z:0.456), v1:Vector(x:0.242, y:0.330, z:0.456), v2:Vector(x:0.291, y:0.330, z:0.296), r:Vector(x:0.7, y:0.7, z:0.7), e:Vector(x:0.0, y:0.0, z:0.0)),
//    Triangle(v0:Vector(x:0.291, y:0.330, z:0.296), v1:Vector(x:0.291, y:0.000, z:0.296), v2:Vector(x:0.242, y:0.000, z:0.456), r:Vector(x:0.7, y:0.7, z:0.7), e:Vector(x:0.0, y:0.0, z:0.0)),
//    Triangle(v0:Vector(x:0.291, y:0.000, z:0.296), v1:Vector(x:0.291, y:0.330, z:0.296), v2:Vector(x:0.133, y:0.330, z:0.247), r:Vector(x:0.7, y:0.7, z:0.7), e:Vector(x:0.0, y:0.0, z:0.0)),
//    Triangle(v0:Vector(x:0.133, y:0.330, z:0.247), v1:Vector(x:0.133, y:0.000, z:0.247), v2:Vector(x:0.291, y:0.000, z:0.296), r:Vector(x:0.7, y:0.7, z:0.7), e:Vector(x:0.0, y:0.0, z:0.0)),
]

let scene = Scene(skyEmission: skyEmission, groundReflection: groundReflection, eyePosition: camera.viewPosition, triangles: triangles)

for iteration in 1...iterations {
    camera.getFrame(scene, image:image)
    if iteration == 1 || iteration % 10 == 0 {
        image.generateImage(iteration)
    }
    println("iteration: \(iteration)")
}

image.generateImage(iterations)
