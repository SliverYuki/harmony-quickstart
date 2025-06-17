import { BannerClass } from "../model/BannerClass"
import { bufferToString } from "utils/src/main/ets/helpers/BufferUtil"

@Preview
@Component
export struct Banner {
  @State BannerList: Array<BannerClass> = []

  @Consume('ArticlePathStack') articlePathStack: NavPathStack

  // 组件实例创建后，渲染前执行
  aboutToAppear(): void {
    this.getBannerDataFromJson()
  }

  build() {
    Swiper() {
      ForEach(this.BannerList, (item:BannerClass, index: number) => {
        Image($r(item.imageSrc))
          .objectFit(ImageFit.Contain)
          .width('100%')
          .padding({ left: 16, right: 16, top: 10 })
          .borderRadius(16)
          .onClick(() => {
            this.articlePathStack.pushPathByName('bannerDetail', item)
          })
      }, (item: BannerClass) => item.id)
    }
    .autoPlay(true)
    .loop(true)
    .indicator(
      new DotIndicator()
        .color('#1a000000')
        .selectedColor('#0A59F7')
    )
  }

  getBannerDataFromJson() {
    const context = this.getUIContext().getHostContext()
    context?.resourceManager.getRawFileContent('BannerData.json')
      .then(value => {
        let res:string = bufferToString(value)

        this.BannerList = JSON.parse(res) as Array<BannerClass>
      })
  }
}