import { CourseLearning } from 'learning'
import { KnowledgeMap } from 'map'
import { QuickStartPage } from 'quickstart'
import { TabBar, TabContentType } from '../model/TabBarClass'

@Entry
@Component
struct Index {
  private tabsController: TabsController = new TabsController()

  @State currentIndex: number = 0
  @State tabBarConfig: Array<TabBar> = [
    {
      title: '快速入门',
      type: TabContentType.QuickStart,
      icon: $r('app.media.ic_01_off'),
      activeIcon: $r('app.media.ic_01_on'),
    },
    {
      title: '课程学习',
      type: TabContentType.CourseLearning,
      icon: $r('app.media.ic_02_off'),
      activeIcon: $r('app.media.ic_02_on'),
    },
    {
      title: '知识地图',
      type: TabContentType.KnowledgeMap,
      icon: $r('app.media.ic_03_off'),
      activeIcon: $r('app.media.ic_03_on'),
    }
  ]

  @Builder
  tabBarItemBuilder(title: string, targetIndex: number, icon: ResourceStr, activeIcon: ResourceStr ) {
    Column() {
      Image(this.currentIndex === targetIndex ? activeIcon : icon)
        .width(24)
        .height(24)

      Text(title)
        .fontFamily('HarmonyHeiTi-Medium')
        .fontSize(10)
        .fontColor(this.currentIndex === targetIndex ? '#0A59F7' : 'rgba(0,0,0,0.60)')
        .textAlign(TextAlign.Center)
        .lineHeight(14)
        .fontWeight(500)
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .onClick(() => {
      this.currentIndex = targetIndex
      this.tabsController.changeIndex(targetIndex)
      // 通知 Ability 实例，Tab 页切换
      const context = this.getUIContext().getHostContext()
      context?.eventHub.emit('TabSwitch', targetIndex)
    })
  }

  @Builder
  contentAreaBuilder(type: TabContentType) {
      if (type === TabContentType.QuickStart) {
        QuickStartPage()
      } else if (type === TabContentType.CourseLearning) {
        CourseLearning()
      } else if (type === TabContentType.KnowledgeMap) {
        KnowledgeMap()
      }
  }

  build() {
    Tabs({ barPosition: BarPosition.End, controller: this.tabsController }) {
      ForEach(this.tabBarConfig, (item: TabBar, index: number) => {
        TabContent() {
          this.contentAreaBuilder(item.type)
        }
        .tabBar(this.tabBarItemBuilder(item.title, index, item.icon, item.activeIcon))
      }, (item: TabBar) => item.title)
    }
    .scrollable(false)
    .vertical(false)
    .divider({
      strokeWidth: 0.5,
      color: '#0D182431',
    })
    .backgroundColor('#F3F5F7')
    .padding({ top: 24 })
  }
}