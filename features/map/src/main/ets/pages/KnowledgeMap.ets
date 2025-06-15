import { bufferToString } from "utils/src/main/ets/helpers/BufferUtil"
import { Section } from "../model/KnowledgeClass";
import { NavBarItemType } from "../model/NavBarClass";
import { NavBarItem } from "../view/NavBarItem";

@Component
export struct KnowledgeMap {
  @State title: string = '知识地图';
  @State brief: string = '通过循序渐进的学习路径，无经验和有经验的开发者都可以轻松掌握ArkTS语言声明式开发范式，体验更简洁、更友好的HarmonyOS应用开发旅程。'

  @State navBarList: Array<NavBarItemType> = [
    { order: '01', title: '准备与学习' },
    { order: '02', title: '构建应用' },
    { order: '03', title: '应用测试' },
    { order: '04', title: '上架' },
    { order: '05', title: '运营增长' },
    { order: '06', title: '商业变现' },
    { order: '07', title: '更多' }
  ]

  @State sections: Array<Section> = []

  aboutToAppear(): void {
    this.getSectionsDataFromJson()
  }

  build() {
    Scroll() {
      Column() {
        Text(this.title)
          .width('100%')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontFamily("HarmonyHeiTi-Bold")
          .fontColor(Color.Black)
          .textAlign(TextAlign.Start)
          .lineHeight(32)

        Image($r('app.media.knowledge_map_banner'))
          .width('100%')
          .borderRadius(16)
          .margin({ top: 18, bottom: 8 })

        Text(this.brief)
          .width('100%')
          .fontSize(14)
          .fontWeight(FontWeight.Regular)
          .fontFamily("HarmonyHeiTi")
          .fontColor('rgba(0, 0, 0, 0.6)')
          .textAlign(TextAlign.Start)

        List({ space: 12 }) {
          ForEach(this.navBarList, (item: NavBarItemType) => {
            ListItem() {
              NavBarItem({ navBarItem: item })
            }
            .width('100%')
          }, (item: NavBarItemType) => item.order)
        }
        .width('100%')
        .margin({ top: 24 })
      }
      .width('100%')
      .padding({ top: 12, right: 16, bottom: 12, left: 16 })
    }
    .width('100%')
    .align(Alignment.TopStart)
    .constraintSize({ minHeight: '100%' })
    .edgeEffect(EdgeEffect.Spring)
    .backgroundColor('#F3F5F7')
  }

  getSectionsDataFromJson() {
    const context = this.getUIContext().getHostContext()
    context?.resourceManager.getRawFileContent('MapData.json')
      .then(value => {
        let res = bufferToString(value)

        this.sections = JSON.parse(res) as Array<Section>
      })
  }
}
