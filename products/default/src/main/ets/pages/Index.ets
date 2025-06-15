import { CourseLearning } from 'learning'
import { KnowledgeMap, KnowledgeMapContent } from 'map'
import { QuickStartPage } from 'quickstart'

@Entry
@Component
struct Index {
  build() {
    Column() {
      // QuickStartPage()
      // CourseLearning()
      // KnowledgeMap()
      KnowledgeMapContent()
    }
    .backgroundColor('#F3F5F7')
    .padding({ top: 36, bottom: 28 })
  }
}