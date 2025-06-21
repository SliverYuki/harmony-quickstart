import { http } from '@kit.NetworkKit'
import { image } from '@kit.ImageKit'
import { BusinessError } from '@kit.BasicServicesKit'

@Component
export struct NetworkImgAccess {
  @State image: PixelMap | undefined = undefined

  aboutToAppear(): void {
    console.log('NetworkImgAccess', 'appear')
  }

  build() {
    NavDestination() {
      Column() {
        Image(this.image)
          .width(100)
          .height(100)

        Button('获取网络图片')
          .onClick(() => {
            this.getHttpImage()
          })
          .width(200)
      }
        .width('100%')
        .height('100%')
    }
    .hideTitleBar(false)
    .width('100%')
    .height('100%')
  }

  getHttpImage = () => {
    let outputData: http.HttpResponse
    // 请求网络图片数据
    http.createHttp().request(
      'https://images.unsplash.com/photo-1749838065282-32db54bed154?q=80&w=3029&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
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

            class tempSize {
              width: number = 100
              height: number = 100
            }

            let options: Record<string, number | boolean | tempSize> = {
              'alphaType': 0, // 透明度
              'editable': false, // 是否可编辑
              'pixelFormat': 3, // 像素格式
              'scaleMode': 1, // 缩略值
              'size': { width: 100, height: 100 }
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