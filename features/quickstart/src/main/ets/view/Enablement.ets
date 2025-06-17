import { ArticleClass } from '../model/ArticleClass'
import { bufferToString } from 'utils/src/main/ets/helpers/BufferUtil'

@Component
struct EnablementItem {
  @Prop enablementItem: ArticleClass

  build() {
    Column() {
      Image($r(this.enablementItem.imageSrc))
        .width('100%')
        .height(96)
        .borderRadius({
          topLeft: 16,
          topRight: 16,
        })
        .objectFit(ImageFit.Cover)
      Text(this.enablementItem.title)
        .width('100%')
        .height(18)
        .padding({ left: 12, right: 12 })
        .margin({ top: 8 })
        .fontSize(14)
        .fontWeight(FontWeight.Bold)
        .textAlign(TextAlign.Start)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .maxLines(1)
      Text(this.enablementItem.brief)
        .width('100%')
        .height(32)
        .fontSize(12)
        .fontWeight(400)
        .fontColor('rgba(0, 0, 0, 0.6)')
        .padding({ left: 12, right: 12 })
        .margin({ top: 2 })
        .textAlign(TextAlign.Start)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .maxLines(2)
    }
    .width(160)
    .height(169)
    .borderRadius(16)
    .backgroundColor('#ffffff')
  }
}

@Component
export struct EnablementView {
  @State EnablementList:Array<ArticleClass> = []

  @Consume('ArticlePathStack') articlePathStack: NavPathStack

  aboutToAppear(): void {
    this.getEnablementDataFromJson()
  }

  build() {
    Column() {
      Text('赋能套件')
        .width('100%')
        .fontColor('#182431')
        .fontSize(16)
        .fontWeight(500)
        .fontFamily('HarmonyHeiTi-Bold')
        .textAlign(TextAlign.Start)
        .padding({ left: 16, right: 16 })
        .margin({ bottom: 8 })
      Grid() {
        ForEach(this.EnablementList, (item: ArticleClass, index: number) => {
          GridItem() {
            EnablementItem({ enablementItem: item })
          }
          .onClick(() => {
            this.articlePathStack.pushPathByName('articleDetail', item)
          })
        }, (item: ArticleClass, index: number) => item.id)
      }
      .width('100%')
      .height(169)
      .padding({ top: 2, left: 16, right: 16 })
      .rowsTemplate('1fr')
      .columnsGap(8)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .margin({ top: 16 })
  }

  getEnablementDataFromJson() {
    const context = this.getUIContext().getHostContext()
    context?.resourceManager.getRawFileContent('EnablementData.json')
      .then(value => {
        const res:string = bufferToString(value)

        this.EnablementList = JSON.parse(res) as Array<ArticleClass>
      })
  }
}