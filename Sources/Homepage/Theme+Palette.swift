//
//  Theme+Palette.swift
//  Homepage
//
//  Created by Jason Aagaard on 2024-10-23.
//

import Publish
import Plot

extension Theme where Site == Homepage {
  static var palette: Self {
    Theme(
      htmlFactory: HomepageHTMLFactory(),
      resourcePaths: [
        "Resources/PaletteTheme/styles.css",
        "Resources/PaletteTheme/homepage.css"
      ]
    )
  }

  // The main index.html page
  private struct HomepageHTMLFactory: HTMLFactory {
    func makeIndexHTML(for index: Publish.Index, context: Publish.PublishingContext<Homepage>) throws -> Plot.HTML {
      HTML(
        .head(for: index, on: context.site),
        .body {
          SiteHeader(context: context, selectedSectionID: nil)
          Wrapper {
            H3("Jason Aagaard <App Develoeper>")
            H1("iOS • Android • Embedded C")
            Paragraph(index.body)
            Image(url: "images/avatar.png", description: "My face")
          }
        }
      )
    }

    // Sections in the site header
    func makeSectionHTML(for section: Publish.Section<Homepage>, context: Publish.PublishingContext<Homepage>) throws -> Plot.HTML {
      HTML(
        .head(for: section, on: context.site),
        .body {
          SiteHeader(context: context, selectedSectionID: nil)
          Wrapper {
            switch section.id {
            case .about:
              Paragraph(section.body)
            case .posts:
              Paragraph(section.body)
            }
          }
        }
      )
    }

    func makePageHTML(for page: Publish.Page, context: Publish.PublishingContext<Homepage>) throws -> Plot.HTML {
      HTML(
        .head(for: page, on: context.site)
      )
    }

    func makeTagListHTML(for page: Publish.TagListPage, context: Publish.PublishingContext<Homepage>) throws -> Plot.HTML? {
      nil
    }

    func makeTagDetailsHTML(for page: Publish.TagDetailsPage, context: Publish.PublishingContext<Homepage>) throws -> Plot.HTML? {
      nil
    }

    func makeItemHTML(
      for item: Item<Homepage>,
      context: PublishingContext<Homepage>
    ) throws -> HTML {
      HTML(
        .head(for: item, on: context.site)
      )
    }
  }

  // MARK: - Helpers

  private struct Wrapper: ComponentContainer {
    @ComponentBuilder var content: ContentProvider

    var body: Component {
      Div(content: content).class("wrapper")
    }
  }

  private struct SiteHeader<Value: Website>: Component {
    var context: PublishingContext<Value>
    var selectedSectionID: Value.SectionID?

    var body: Component {
      Header {
        Wrapper {
          Link(context.site.name, url: "/")
            .class("nav-bar")

          if Value.SectionID.allCases.count > 1 {
            navigation
          }
        }
      }
    }

    private var navigation: Component {
      Navigation {
        List(Value.SectionID.allCases) { sectionID in
          let section = context.sections[sectionID]

          return Link(section.title, url: section.path.absoluteString)
            .class(sectionID == selectedSectionID ? "selected" : "")
        }
      }
    }
  }

  private struct ItemList<Value: Website>: Component {
    var items: [Item<Value>]
    var site: Value

    var body: Component {
      List(items) { item in
        Article {
          H1(Link(item.title, url: item.path.absoluteString))
          ItemTagList(item: item, site: site)
          Paragraph(item.description)
        }
      }
      .class("item-list")
    }
  }

  private struct ItemTagList<Value: Website>: Component {
    var item: Item<Value>
    var site: Value

    var body: Component {
      List(item.tags) { tag in
        Link(tag.string, url: site.path(for: tag).absoluteString)
      }
      .class("tag-list")
    }
  }
}
