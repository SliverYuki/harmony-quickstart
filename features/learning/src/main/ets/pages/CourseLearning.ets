import { webview } from "@kit.ArkWeb";

@Component
export struct CourseLearning {
  private webviewController: webview.WebviewController = new webview.WebviewController()

  build() {
    Column() {
      // 加载网络页面
      // Web({ src: 'https://www.huawei.com', controller: this.webviewController })
      //   .domStorageAccess(true)

      // 加载本地页面
      Web({ src: $rawfile('course_learning/index.html'), controller: this.webviewController })
        .domStorageAccess(true)
    }
  }
}