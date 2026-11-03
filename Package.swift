// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "CuentasClaras",
    products: [
        .library(name: "CuentasClaras", targets: ["CuentasDomain", "CuentasPresentation"])
    ],
    targets: [
        .target(name: "CuentasDomain"),
        .target(name: "CuentasPresentation", dependencies: ["CuentasDomain"]),
        .testTarget(name: "CuentasTests", dependencies: ["CuentasDomain", "CuentasPresentation"]),
    ]
)
