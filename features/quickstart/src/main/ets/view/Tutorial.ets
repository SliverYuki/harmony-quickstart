import { ArticleClass } from "../model/ArticleClass"
import { bufferToString } from "utils/src/main/ets/helpers/BufferUtil"

@Component
struct TutorialItem {
  @Prop tutorialItem: ArticleClass

  build() {
    Row() {
      Column() {
        Text(this.tutorialItem.title)
          .width('100%')
          .height(18)
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .textAlign(TextAlign.Start)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .maxLines(1)
        Text(this.tutorialItem.brief)
          .width('100%')
          .height(32)
          .margin({ top: 10 })
          .fontSize(12)
          .fontWeight(400)
          .lineHeight(16)
          .fontColor('rgba(0, 0, 0, 0.6)')
          .textAlign(TextAlign.Start)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .maxLines(2)
      }
      .height('100%')
      .margin({ right: 12 })
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      Image($r(this.tutorialItem.imageSrc))
        .objectFit(ImageFit.Cover)
        .width(108)
        .height(64)
        .borderRadius(16)
    }
    .width('100%')
    .height(88)
    .padding(12)
    .borderRadius(16)
    .backgroundColor(Color.White)
    .alignItems(VerticalAlign.Top)
  }
}

@Component
export struct TutorialView {
  @State tutorialList: Array<ArticleClass> = []

  aboutToAppear(): void {
    this.getTutorialDataFromJson()
  }

  build() {
    Column() {
      Text('入门教程')
        .width('100%')
        .fontColor('#182421')
        .fontWeight(500)
        .fontFamily('HarmonyHeiTi-Bold')
        .textAlign(TextAlign.Start)
        .padding({ left: 16, right: 16 })
        .margin({ bottom: 10 })
      List({ space: 12 }) {
        ForEach(this.tutorialList, (item: ArticleClass, index: number) => {
          ListItem() {
            TutorialItem({ tutorialItem: item })
          }
        }, (item: ArticleClass, index: number) => item.id)
      }
      .scrollBar(BarState.Off)
      .padding({ left: 16, right: 16 })
    }
    .width('100%')
    .margin({ top: 16 })
  }

  getTutorialDataFromJson() {
    const context = this.getUIContext().getHostContext()

    context?.resourceManager.getRawFileContent('TutorialData.json')
      .then(value => {
        const res:string = bufferToString(value)

        this.tutorialList = JSON.parse(res) as Array<ArticleClass>
      })
  }
}