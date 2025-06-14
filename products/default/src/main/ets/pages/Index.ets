import { CourseLearning } from 'learning'
import { KnowledgeMap } from 'map'
import { QuickStartPage } from 'quickstart'

@Entry
@Component
struct Index {
  build() {
    Column() {
      // QuickStartPage()
      // CourseLearning()
      KnowledgeMap()
    }
    .backgroundColor('#F3F5F7')
    .padding({ top: 36, bottom: 28 })
  }
}