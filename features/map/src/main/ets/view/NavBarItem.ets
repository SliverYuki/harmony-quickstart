import { NavBarItemType } from "../model/NavBarClass"

@Component
export struct NavBarItem {
  @Prop navBarItem:NavBarItemType

  build() {
    Row() {
      Text(this.navBarItem.order)
        .margin({ right: 6 })
        .fontSize(21)
        .fontFamily("HarmonyHeiTi-Bold")
        .fontWeight(FontWeight.Bold)
        .fontColor('#182431')
        .textAlign(TextAlign.Start)
        .lineHeight(22)

      Text(this.navBarItem.title)
        .fontSize(16)
        .fontFamily('HarmonyHeiTi-Medium')
        .fontWeight(FontWeight.Medium)
        .fontColor('#182431')
        .textAlign(TextAlign.Start)
        .lineHeight(22)

      // 自动填充主轴剩余空间
      Blank()

      Image($r('app.media.ic_arrow'))
        .width(12)
        .height(24)
    }
    .width('100%')
    .height(48)
    .borderRadius(16)
    .alignItems(VerticalAlign.Center)
    .padding({ left: 12, right: 12 })
    .backgroundColor('#F1F3F5')
  }
}