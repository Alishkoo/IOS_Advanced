
import Foundation
struct PostModel: Identifiable {
    var id = UUID()
    var image: String
    var title: String
    var by: String
    var avatar: String
}

struct TrendModel: Identifiable {
    var id = UUID()
    var image: String
    var avatar: String
    var count: String
}

struct Gallery: Identifiable {
    var id = UUID()
    var imageName: String
}

struct MacData {
    static var pSimple = PostModel(image: "A9FEBA1E-B967-46F9-B36C-8BC574BBBC94_1_105_c", title: "About me", by: "Alibek Baisholanov", avatar: "75513A37-3624-4DD6-B711-056B02555A73_1_105_c")
    static var tSimple = TrendModel(image: "A9FEBA1E-B967-46F9-B36C-8BC574BBBC94_1_105_c", avatar: "75513A37-3624-4DD6-B711-056B02555A73_1_105_c", count: "10k")
    static var gallery: [Gallery] = [
        Gallery(imageName: "A9FEBA1E-B967-46F9-B36C-8BC574BBBC94_1_105_c"),
        Gallery(imageName: "BF7EB2A7-4CAA-4AB7-9B26-D7D3107BA3A1_1_105_c"),
        Gallery(imageName: "A542319B-EEE8-4F52-BE45-BC12DA670A03_1_105_c"),
        Gallery(imageName: "75513A37-3624-4DD6-B711-056B02555A73_1_105_c"),
        Gallery(imageName: "945D3DEC-0668-41FA-A314-880F242C7DEB"),
        Gallery(imageName: "41CD5A82-9435-4BC3-B768-EB740C39E34A_1_105_c"),
        Gallery(imageName: "39D5BC17-2D3A-4550-BFF0-5E75EE9FDBE3"),
        Gallery(imageName: "4A6ECC21-006D-4ACA-8E87-B511E75DF95B_1_105_c"),
        Gallery(imageName: "1BC400B5-2E02-4E47-9B51-3F85E75FDB48_1_105_c"),
        Gallery(imageName: "1A6F656E-8DB6-4AE6-81DE-A3EE61395B06_1_105_c")
    ]
    
    static var pItems: [PostModel] = [
        PostModel(image: "BF7EB2A7-4CAA-4AB7-9B26-D7D3107BA3A1_1_105_c", title: "With little brother", by: "Alibek Baisholanov", avatar: "75513A37-3624-4DD6-B711-056B02555A73_1_105_c"),
        PostModel(image: "4A6ECC21-006D-4ACA-8E87-B511E75DF95B_1_105_c", title: "Chill Guy", by: "Alibek Baisholanov", avatar: "75513A37-3624-4DD6-B711-056B02555A73_1_105_c"),
        PostModel(image: "39D5BC17-2D3A-4550-BFF0-5E75EE9FDBE3", title: "Karate Kudo times", by: "Alibek Baisholanov", avatar: "75513A37-3624-4DD6-B711-056B02555A73_1_105_c"),
        PostModel(image: "945D3DEC-0668-41FA-A314-880F242C7DEB", title: "Paternik", by: "Alibek Baisholanov", avatar: "A9FEBA1E-B967-46F9-B36C-8BC574BBBC94_1_105_c"),
        PostModel(image: "1BC400B5-2E02-4E47-9B51-3F85E75FDB48_1_105_c", title: "My birthdayy", by: "Alibek Baisholanov", avatar: "A9FEBA1E-B967-46F9-B36C-8BC574BBBC94_1_105_c"),
        PostModel(image: "A542319B-EEE8-4F52-BE45-BC12DA670A03_1_105_c", title: "Gangsta bro", by: "Alibek Baisholanov", avatar: "A9FEBA1E-B967-46F9-B36C-8BC574BBBC94_1_105_c")
    ]
    static var tItems: [TrendModel] = [
        TrendModel(image: "1A6F656E-8DB6-4AE6-81DE-A3EE61395B06_1_105_c", avatar: "A9FEBA1E-B967-46F9-B36C-8BC574BBBC94_1_105_c", count: "34k"),
        TrendModel(image: "A542319B-EEE8-4F52-BE45-BC12DA670A03_1_105_c", avatar: "A9FEBA1E-B967-46F9-B36C-8BC574BBBC94_1_105_c", count: "19k"),
        TrendModel(image: "75513A37-3624-4DD6-B711-056B02555A73_1_105_c", avatar: "A9FEBA1E-B967-46F9-B36C-8BC574BBBC94_1_105_c", count: "5k")
    ]
}

