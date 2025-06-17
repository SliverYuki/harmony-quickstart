import { webview } from "@kit.ArkWeb";
import { ArticleClass } from "../model/ArticleClass";

@Component
export struct ArticleDetailPage {
  @State articleDetail: ArticleClass | null = null

  @Consume('ArticlePathStack') articlePathStack: NavPathStack

  aboutToAppear(): void {
    this.articleDetail = this.articlePathStack.getParamByName('articleDetail')[0] as ArticleClass
    console.debug('articleDetail', this.articleDetail)
  }

  build() {
    NavDestination() {
      Column() {
        Row() {
          Row() {
            Image($r('app.media.ic_back'))
              .width(40)
              .height(40)
              .onClick(() => {
                this.articlePathStack.pop()
              })

            Row() {
              Text(this.articleDetail?.title)
                .fontFamily('HarmonyHeiTi-Bold')
                .fontSize(20)
                .textAlign(TextAlign.Start)
                .textOverflow({ overflow: TextOverflow.Ellipsis })
                .maxLines(1)
                .fontWeight(700)
                .margin({ left: 8 })
            }
          }
          .width('80%')
        }
        .width('100%')
        .height(56)
        .justifyContent(FlexAlign.SpaceBetween)

        Webview({ articleDetail: this.articleDetail })
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .padding({ left: 16, right: 16 })
    }
    .hideTitleBar(true)
  }
}

@Component
struct Webview {
  @Prop articleDetail: ArticleClass | null = null
  private webviewController: webview.WebviewController = new webview.WebviewController()

  build() {
    Column() {
      Web({ src: this.articleDetail?.webUrl, controller: this.webviewController })
        .darkMode(WebDarkMode.Auto)
        .domStorageAccess(true)
        .zoomAccess(true)
        .fileAccess(true)
        .mixedMode(MixedMode.All)
        .cacheMode(CacheMode.None)
        .javaScriptAccess(true)
        .width('100%')
        .layoutWeight(1)
    }
  }
}