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

  var url = URL(string: "https://jasonaagaard.com")!
  var name = "Jason Aagaard"
  var description = "Get in touch!"
  var language: Language { .english }
  var imagePath: Path? { nil }
}

try Homepage().publish(using: [
    .copyResources(),
    .addMarkdownFiles(),
    .generateHTML(withTheme: .palette),
    .generateSiteMap()
  ]
)
