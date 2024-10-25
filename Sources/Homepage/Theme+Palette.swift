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
              Div {
                H3("Jason Aagaard <App Developer>")
                  .class("margin-bottom-24 animate-top")
                H1("iOS • Android • Embedded C")
                  .class("animate-top")
                H6(index.body)
                  .class("margin-bottom-48 animate-right")
                Div {
                  Link(url: "/about") {
                    H4("Get in touch")
                      .class("accent-color text-white capsule")
                  }
                }.class("show-inline-block")
              }
              .class("display-leftmiddle flex-container vstack margin-left")
            }
            .class("bgimg display-container animate-opacity")
          }
          .class("custom-placement background-dark text-white")
        }
      )
    }

    // Sections in the site header
    func makeSectionHTML(for section: Publish.Section<Homepage>, context: Publish.PublishingContext<Homepage>) throws -> Plot.HTML {
      HTML(
        .head(for: section, on: context.site),
        .body {
          Div {
            SiteHeader(context: context, selectedSectionID: nil)

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
          .class("full-screen background-dark text-white")
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
