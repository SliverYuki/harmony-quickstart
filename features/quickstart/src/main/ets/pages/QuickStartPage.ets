import { Banner } from '../view/Banner';
import { EnablementView } from '../view/Enablement';
import { TutorialView } from '../view/Tutorial';

@Entry
@Component
export struct QuickStartPage {
  @State message: string = '快速入门';

  build() {
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
}






