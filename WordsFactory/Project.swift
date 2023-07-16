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
    "UIAppFonts": .array(["Rubik-Black.ttf",
                          "Rubik-BlackItalic.ttf",
                          "Rubik-Bold.ttf",
                          "Rubik-BoldItalic.ttf",
                          "Rubik-ExtraBold.ttf",
                          "Rubik-ExtraBoldItalic.ttf",
                          "Rubik-Italic.ttf",
                          "Rubik-Light.ttf",
                          "Rubik-LightItalic.ttf",
                          "Rubik-Medium.ttf",
                          "Rubik-MediumItalic.ttf",
                          "Rubik-Regular.ttf",
                          "Rubik-SemiBold.ttf",
                          "Rubik-SemiBoldItalic.ttf"
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
                                "WordsFactory/Assets.xcassets/",
                                "WordsFactory/Fonts/Rubik-Black.ttf",
                                "WordsFactory/Fonts/Rubik-BlackItalic.ttf",
                                "WordsFactory/Fonts/Rubik-Bold.ttf",
                                "WordsFactory/Fonts/Rubik-BoldItalic.ttf",
                                "WordsFactory/Fonts/Rubik-ExtraBold.ttf",
                                "WordsFactory/Fonts/Rubik-ExtraBoldItalic.ttf",
                                "WordsFactory/Fonts/Rubik-Italic.ttf",
                                "WordsFactory/Fonts/Rubik-Light.ttf",
                                "WordsFactory/Fonts/Rubik-LightItalic.ttf",
                                "WordsFactory/Fonts/Rubik-Medium.ttf",
                                "WordsFactory/Fonts/Rubik-MediumItalic.ttf",
                                "WordsFactory/Fonts/Rubik-Regular.ttf",
                                "WordsFactory/Fonts/Rubik-SemiBold.ttf",
                                "WordsFactory/Fonts/Rubik-SemiBoldItalic.ttf",
                               ],
                    dependencies: [
                        .external(name: "Alamofire"),
                    ],
                    coreDataModels: [.init("WordsFactory/Model.xcdatamodeld")]
)


let project = Project(name: "WordsFactory",
                      targets: [target])

