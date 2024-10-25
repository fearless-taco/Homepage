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
        "Resources/PaletteTheme/styles.css"
      ]
    )
  }

  // The main index.html page
  private struct HomepageHTMLFactory: HTMLFactory {
    func makeIndexHTML(for index: Publish.Index, context: Publish.PublishingContext<Homepage>) throws -> Plot.HTML {
      HTML(
        .head(for: index, on: context.site),
        .body {
          Div {
            SiteHeader(context: context, selectedSectionID: nil)
            Div {
              H3("Jason Aagaard <App Developer>")
              H1("iOS • Android • Embedded C")
              Paragraph(index.body)
              Image(url: "images/avatar.png", description: "My face")
            }
          }
          .class("background-dark text-white")
        }
      )
    }

    // Sections in the site header
    func makeSectionHTML(for section: Publish.Section<Homepage>, context: Publish.PublishingContext<Homepage>) throws -> Plot.HTML {
      HTML(
        .head(for: section, on: context.site),
        .body {
          SiteHeader(context: context, selectedSectionID: nil)
            .class("background-dark text-white")
          Div {
            switch section.id {
            case .home:
              Paragraph("Not rendered")
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

  private struct SiteHeader<Value: Website>: Component {
    var context: PublishingContext<Value>
    var selectedSectionID: Value.SectionID?

    var body: Component {
      Header {
        Navigation {
          Div {
            Link("<JA>", url: "/")
              .class("display-topleft padding-large font-xxlarge display-position-fixed")
          }

          List(Value.SectionID.allCases) { sectionID in
            let section = context.sections[sectionID]
            return Link(section.title, url: sectionID.rawValue == "home" ?  "/" : section.path.absoluteString)
              .class("nav-bar-item")
          }
          .listStyle(.unordered)
          .class("ul float-right")
        }
        .class("nav-bar")
      }
    }
  }
}
