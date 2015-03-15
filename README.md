# Ideal-Gas-Simulator
An app to simulate at a kinematic level molecules in an idea gas, and explore thermodynamic properties of the gas.

## Compiling / Running the app
To compile the app, it should be as easy as downloading the repository, opening the project in Xcode, and hitting run.
Because the app is written using Swift (mostly), make sure you have the latest version of Xcode (currently 6.2) installed.

## Explanation of Code Structure
The 3D graphics for the gas visualization use [SceneKit] (https://developer.apple.com/library/mac//documentation/SceneKit/Reference/SceneKit_Framework/index.html).  To disassociate the graphics code from the numerical simulation code, the code for both a particle and rectangular container of gas is split up into:
- `Particle` and `ParticleNode`
- `RectangularContainer` and `RectangularContainerNode`

respectively.

So then, the same source code can be used in both a GUI and non-GUI environment.  For example, to display conservation of internal energy is as easy as:
```swift
let c = RectangularContainer(numDims: 3, squareSideLength: 1)
let dt = 0.02
for i in 0..<100 {
  c.update(dt)
  println(c.totalKE)
}
```

In addition, many helpful vector operations are implemented in Utils.swift
