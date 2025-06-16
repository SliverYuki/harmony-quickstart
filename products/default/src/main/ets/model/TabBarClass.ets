export enum TabContentType {
  QuickStart,
  CourseLearning,
  KnowledgeMap,
}

export interface TabBar {
  title: string,
  type: TabContentType,
  icon: ResourceStr,
  activeIcon: ResourceStr
}