import ProjectDescription

let infoPlist: [String: InfoPlist.Value] = [
    "CFBundleShortVersionString": "1.0",
    "CFBundleVersion": "1",
//    "UIMainStoryboardFile": "",
    "UILaunchStoryboardName": "LaunchScreen",
    "UIApplicationSceneManifest": .dictionary([
        "UIApplicationSupportsMultipleScenes": .boolean(false),
        "UISceneConfigurations": .dictionary(
            ["UIWindowSceneSessionRoleApplication": .array(
                [.dictionary(
                    [
                        "UISceneConfigurationName": .string("Default Configuration"),
                        "UISceneDelegateClassName": .string("$(PRODUCT_MODULE_NAME).SceneDelegate")
                    ]
                )
                ]
            )])
    ])
]

let target = Target(name: "WordsFactory",
                    platform: .iOS,
                    product: .app,
                    productName: "WordsFactory",
                    bundleId: "nad.WordsFactory",
                    infoPlist: .extendingDefault(with: infoPlist),
                    sources: ["WordsFactory/**/*.swift"],
                    resources: ["WordsFactory/LaunchScreen.storyboard",
                                "WordsFactory/Assets.xcassets/"],
                    dependencies: [
                        .external(name: "Alamofire"),
                    ],
                    coreDataModels: [.init("WordsFactory/Model.xcdatamodeld")]
)


let project = Project(name: "WordsFactory",
                      targets: [target])

