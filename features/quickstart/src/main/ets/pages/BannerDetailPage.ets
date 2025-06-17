import { BannerClass } from "../model/BannerClass"
import { webview } from "@kit.ArkWeb"

@Component
export struct BannerDetailPage {
  private controller: webview.WebviewController = new webview.WebviewController()

  @State bannerDetail: BannerClass | null = null

  @Consume('ArticlePathStack') articlePathStack: NavPathStack

  aboutToAppear(): void {
    this.bannerDetail = this.articlePathStack.getParamByName('bannerDetail')[0] as BannerClass
  }

  build() {
    NavDestination() {
      Column() {
        Web({
          src: this.bannerDetail?.url,
          controller: this.controller
        })
          .darkMode(WebDarkMode.Auto)
          .domStorageAccess(true)
          .zoomAccess(true)
          .fileAccess(true)
          .javaScriptAccess(true)
          .mixedMode(MixedMode.All)
          .width('100%')
          .height('100%')
          .layoutWeight(2)
      }
    }
    .width('100%')
    .height('100%')
    .hideTitleBar(true)
  }
}