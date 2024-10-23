import Foundation
import Publish
import Plot

struct Homepage: Website {
    enum SectionID: String, WebsiteSectionID {
        case home
        case posts
        case about
    }

    struct ItemMetadata: WebsiteItemMetadata {}

    // Update these properties to configure your website:
    var url = URL(string: "https://jasonaagaard.com")!
    var name = "Jason Aagaard"
    var description = "Get in touch!"
    var language: Language { .english }
    var imagePath: Path? { nil }
}

try Homepage().publish(withTheme: .foundation)
