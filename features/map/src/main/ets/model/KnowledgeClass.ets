export interface KnowledgeBaseItem {
  type: string,
  title: string,
}

export interface Material {
  subtitle: string,
  knowledgeBase: Array<KnowledgeBaseItem>
}

export interface Section {
  title: string,
  brief: string,
  materials: Array<Material>
}