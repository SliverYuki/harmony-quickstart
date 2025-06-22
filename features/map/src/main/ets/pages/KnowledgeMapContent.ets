import { KnowledgeBaseItem, Material, Section } from "../model/KnowledgeClass"

const IconMap:Record<string, string> = {
  '指南': 'app.media.ic_guide',
  '准备': 'app.media.ic_prepare',
  '学习与获取证书': 'app.media.ic_medals',
  '视频教程': 'app.media.ic_video',
}

@Component
export struct KnowledgeMapContent {
  @Prop section:Section

  knowledgeMapPageStack: NavPathStack | null = new NavPathStack()

  scroller: Scroller = new Scroller()

  @Builder
  KnowledgeBlockRow(knowledgeBaseItem: KnowledgeBaseItem) {
    Row() {
      Image($r(IconMap[knowledgeBaseItem.type]))
        .width($r('app.float.base_icon_size'))
        .height($r('app.float.base_icon_size'))

      Column() {
        Text(knowledgeBaseItem.title)
          .fontFamily('HarmonyHeiTi')
          .fontSize(14)
          .fontWeight(400)

        Text(knowledgeBaseItem.type)
          .fontFamily('HarmonyHeiTi')
          .fontSize(14)
          .fontWeight(400)
      }
      .alignItems(HorizontalAlign.Start)
      .margin({ left: 18 })

      Blank()

      Image($r('app.media.ic_arrow'))
        .width(12)
        .height(24)
    }
    .width('100%')
    .height(64)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  KnowledgeBlock(material: Material) {
    Column() {
      Text(material.subtitle)
        .width('100%')
        .fontFamily('HarmonyHeiTi-Medium')
        .fontSize(14)
        .fontWeight(500)
        .margin({ bottom: 8 })

      List({ space: 12 }) {
        ForEach(material.knowledgeBase, (item: KnowledgeBaseItem) => {
          ListItem() {
            this.KnowledgeBlockRow(item)
          }
          .onClick(() => {
            // this.knowledgeMapPageStack?.pushPathByName?.('PhotoAccess', null)
            this.knowledgeMapPageStack?.pushPathByName?.('NetworkImageAccess', null)
          })
        }, (item: KnowledgeBaseItem) => item.title)
      }
      .backgroundColor(Color.White)
      .borderRadius(16)
      .padding({ left: 12, right: 12 })
      .divider({
        strokeWidth: 0.5,
        startMargin: 38,
        endMargin: 0,
        color: '#F2F2F2'
      })
    }
    .margin({ top: 24 })
  }

  build() {
    NavDestination() {
      Scroll(this.scroller) {
        Column() {
          Text(this.section?.title)
            .fontFamily('HarmonyHeiTi-Bold')
            .fontSize(20)
            .fontWeight(700)
            .fontColor(Color.Black)

          Text(this.section?.brief)
            .fontFamily('HarmonyHeiTi')
            .fontSize(12)
            .fontColor('rgba(0,0,0,0.60)')
            .textAlign(TextAlign.JUSTIFY)
            .fontWeight(400)
            .margin({ top: 12 })

          ForEach(this.section.materials, (item: Material) => {
            this.KnowledgeBlock(item)
          }, (item: Material) => item.subtitle)
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)
        .padding({ top: 12, right: 16, bottom: 12, left: 16})
      }
        .align(Alignment.TopStart)
        .constraintSize({ minHeight: '100%' })
        .edgeEffect(EdgeEffect.Spring)
        .scrollable(ScrollDirection.Vertical)
        .scrollBar(BarState.Auto)
        .backgroundColor('#F3F5F7')
    }
    .hideTitleBar(true)
    // 使用 onReady 回调获取 Context
    .onReady((context: NavDestinationContext) => {
      this.knowledgeMapPageStack = context.pathStack
    })
  }
}