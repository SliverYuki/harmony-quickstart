import { http } from '@kit.NetworkKit'
import { image } from '@kit.ImageKit'
import { BusinessError } from '@kit.BasicServicesKit'

@Builder
export function NetworkImageAccessBuilder() {
  NetworkImageAccess()
}

@Component
export struct NetworkImageAccess {
  @State image: PixelMap | undefined = undefined

  build() {
    NavDestination() {
      Column() {
        Image(this.image)
          .width('100%')
          .objectFit(ImageFit.Contain)

        Button('获取网络图片', { stateEffect: true })
          .onClick(() => {
            this.getHttpImage()
          })
          .margin({ top: 20 })

      }
      .width('100%')
      .height('100%')
    }
    .hideTitleBar(false)
  }

  getHttpImage = () => {
    let outputData: http.HttpResponse
    // 请求网络图片数据
    http.createHttp().request(
      'https://alliance-communityfile-drcn.dbankcdn.com/FileServer/getFile/cmtyPrivate/011/111/111/0000000000011111111.20250115145226.63916047397033882432035029533674:50001231000000:2800:9E6CBEE018D9A94883E60802B6BCE40659480D2FE9CA545391FCAD53DE407D49.jpg',
      (error: BusinessError, data: http.HttpResponse) => {
        if (error) {
          console.error(`http request failed with. Code: ${error.code}, message: ${error.message}`)
        } else {
          outputData = data

        //  解析返回的图片数据
          const code: http.ResponseCode | number = outputData.responseCode

          if (http.ResponseCode.OK === code) {
            let imageData: ArrayBuffer = outputData.result as ArrayBuffer
            let imageSource: image.ImageSource = image.createImageSource(imageData)

            console.log('get network img', JSON.stringify(imageSource))

            class tempSize {
              width: number = 100
              height: number = 100
            }

            let options: Record<string, number | boolean | tempSize> = {
              'alphaType': 0, // 透明度
              'editable': false, // 是否可编辑
              'pixelFormat': 3, // 像素格式
              'scaleMode': 1, // 缩略值
              'size': { width: 3029, height: 1893 }
            }

            class tempImage {
              image: PixelMap | undefined = undefined
              set(val: PixelMap) {
                this.image = val
              }
            }

            imageSource.createPixelMap(options).then((pixelMap: PixelMap) => {
              let im = new tempImage()
              im.set(pixelMap)
            })
          }
        }
      }
    )
  }
}
