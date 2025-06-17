import { ArticleClass } from '../model/ArticleClass';
import { BannerClass } from '../model/BannerClass';
import { Banner } from '../view/Banner';
import { EnablementView } from '../view/Enablement';
import { TutorialView } from '../view/Tutorial';
import { ArticleDetailPage } from './ArticleDetailPage';
import { BannerDetailPage } from './BannerDetailPage';

@Entry
@Component
export struct QuickStartPage {
  @State message: string = '快速入门';

  @Provide('ArticlePathStack') articlePathStack: NavPathStack = new NavPathStack()

  @Builder
  quickStartPageMap(name: string, param?: ArticleClass | BannerClass) {
    if (name === 'articleDetail') {
      ArticleDetailPage()
    } else if (name === 'bannerDetail') {
      BannerDetailPage()
    }
  }

  build() {
    Navigation(this.articlePathStack) {
      Column() {
        Text(this.message)
          .width('100%')
          .height(32)
          .textAlign(TextAlign.Start)
          .padding({ left: 16 })
          .fontSize(24)
          .fontWeight(700)
          .fontFamily('HarmonyHeiTi-Bold')
          .lineHeight(32)
          .onClick(() => {
            this.message = 'Welcome';
          })
        Scroll() {
          Column() {
            Banner()
            EnablementView()
            TutorialView()
          }
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
        .align(Alignment.TopStart)
      }
      .height('100%')
      .width('100%')
      .backgroundColor('#F3F5F7')
    }
    .navDestination(this.quickStartPageMap)
    .hideTitleBar(true)
    .mode(NavigationMode.Auto)
  }
}






