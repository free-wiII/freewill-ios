// swift-tools-version:5.8
import PackageDescription

let package = Package(
    name: "BuildTools",
    dependencies: [
      .package(url: "https://github.com/mac-cain13/R.swift", branch: "main"),
    ],
    targets: [.target(name: "BuildTools", path: "")]
)
