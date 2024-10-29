import { ArticleData } from '../viewModel/ArticleData'
import { CategoryData } from '../viewModel/CategoryData'
import { resource2Str } from '../utils/utils'

@Component
export struct CategoryItem {
  @Prop categoryData: CategoryData = new CategoryData()
  @Consume('articlePathStack') articlePS: NavPathStack

  build() {
    Column({space: 8}) {
      Text(this.categoryData.categoryName)
        .fontColor(Color.White)
        .fontWeight(FontWeight.Bold)
        .fontSize(28)
      ForEach(this.categoryData.articles, (item: ArticleData) => {
        this.CategoryArticleItem(item)
      }, (item: ArticleData) => JSON.stringify(item.articleName))
    }
    .width('100%')
    .padding(16)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(Color.Black)
  }

  @Builder
  CategoryArticleItem(articleData: ArticleData) {
    Text(articleData.articleName)
      .fontColor(Color.White)
      .padding({left: 8})
      .fontSize(20)
      .onClick(() => {
        this.articlePS.pushPathByName('articleDetail', articleData)
      })
  }

  rsrc2Str(resource: Resource): string {
    return resource2Str(getContext(this), resource)
  }
}