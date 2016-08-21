import PackageDescription

let package = Package(
    name: "VaporSampleBot",
    dependencies: [
        .Package(url: "https://github.com/vapor/tls-provider", majorVersion: 0, minor: 4)
    ],
    exclude: [
        "Config",
        "Database",
        "Localization",
        "Public",
        "Resources",
        "Tests",
    ]
)
