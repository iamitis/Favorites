import { ArticleData } from '../viewModel/ArticleData'
import { CategoryData } from '../viewModel/CategoryData'
import { resource2Str } from '../utils/utils'
import { AppFontSize } from '../common/constants/ThemeConstants'

@Component
export struct CategoryItem {
  @Prop categoryData: CategoryData = new CategoryData()
  @Consume('articlePathStack') articlePS: NavPathStack

  build() {
    Column({ space: 16 }) {
      Row({ space: 8 }) {
        Text() {
          SymbolSpan($r('sys.symbol.folder_fill'))
        }
        .fontColor($r('app.color.text_gray'))
        .fontWeight(FontWeight.Bold)
        .fontSize(AppFontSize.LARGE)

        Text(this.categoryData.categoryName)
          .fontColor($r('app.color.text_gray'))
          .fontWeight(FontWeight.Bold)
          .fontSize(AppFontSize.LARGE)
      }

      ForEach(this.categoryData.articles, (item: ArticleData) => {
        this.CategoryArticleItem(item)
      }, (item: ArticleData) => this.rsrc2Str(item.articleName))
    }
    .width('100%')
    .padding(16)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor($r('app.color.background_card'))
  }

  @Builder
  CategoryArticleItem(articleData: ArticleData) {
    Row({ space: 8 }) {
      Text() {
        SymbolSpan($r('sys.symbol.doc_plaintext'))
      }
      .fontColor($r('app.color.text'))
      .padding({ left: 16 })
      .fontSize(AppFontSize.MIDDLE)

      Text(articleData.articleName)
        .fontColor($r('app.color.text'))
        .fontSize(AppFontSize.MIDDLE)
    }
    .onClick(() => {
      this.articlePS.pushPathByName('articleDetail', articleData)
    })
  }

  rsrc2Str(resource: Resource): string {
    return resource2Str(getContext(this), resource)
  }
}