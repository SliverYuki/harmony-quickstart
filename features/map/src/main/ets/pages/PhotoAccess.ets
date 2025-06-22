import { photoAccessHelper } from "@kit.MediaLibraryKit"
import { BusinessError } from "@kit.BasicServicesKit"

@Component
export struct PhotoAccess {
  @State imageDatas: string[] = []

  build() {
    NavDestination() {
      Column() {
        Button('获取相册图片')
          .margin({ bottom: 20 })
          .onClick(() => {
            this.getAllImage()
          })

        Grid() {
          ForEach(this.imageDatas, (item: string) => {
            GridItem() {
              Image(item)
                .width('100%')
                .aspectRatio(1)
                .objectFit(ImageFit.Cover)
            }
          }, (item: string) => item)
        }
        .rowsGap(2)
        .columnsGap(2)
        .columnsTemplate('1fr 1fr 1fr')
      }
      .width('100%')
      .height('100%')
    }
    .hideTitleBar(false)
  }

  getAllImage = () => {
    try {
      const PhotoSelectOptions: photoAccessHelper.PhotoSelectOptions = new photoAccessHelper.PhotoSelectOptions()
      PhotoSelectOptions.MIMEType = photoAccessHelper.PhotoViewMIMETypes.IMAGE_TYPE
      PhotoSelectOptions.maxSelectNumber = 10

      const photoPicker:photoAccessHelper.PhotoViewPicker = new photoAccessHelper.PhotoViewPicker()

      photoPicker.select(PhotoSelectOptions).then((PhotoSelectResult: photoAccessHelper.PhotoSelectResult) => {
        this.imageDatas = PhotoSelectResult.photoUris
        console.info('PhotoViewPicker.select successfully, PhotoSelectResult uri' + JSON.stringify(PhotoSelectResult))
      })
    }
    catch (err) {
      let message = (err as BusinessError).message
      let code = (err as BusinessError).code

      console.error(`PhotoViewPicker failed with. Code: ${code}, message: ${message}`)
    }
  }
}