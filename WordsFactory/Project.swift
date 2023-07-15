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
    ]),
    "UIAppFonts": .array(["Rubik-Italic.ttf", "Rubik.ttf"])
]

let target = Target(name: "WordsFactory",
                    platform: .iOS,
                    product: .app,
                    productName: "WordsFactory",
                    bundleId: "nad.WordsFactory",
                    infoPlist: .extendingDefault(with: infoPlist),
                    sources: ["WordsFactory/**/*.swift"],
                    resources: ["WordsFactory/LaunchScreen.storyboard",
                                "WordsFactory/Assets.xcassets/",
                                "WordsFactory/Fonts/Rubik-Italic.ttf",
                                "WordsFactory/Fonts/Rubik.ttf"],
                    dependencies: [
                        .external(name: "Alamofire"),
                    ],
                    coreDataModels: [.init("WordsFactory/Model.xcdatamodeld")]
)


let project = Project(name: "WordsFactory",
                      targets: [target])

