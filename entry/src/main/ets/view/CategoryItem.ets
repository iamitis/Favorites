import { ArticleData } from '../viewModel/ArticleData'
import { CategoryData } from '../viewModel/CategoryData'
import { resource2Str } from '../util/TransferUtils'
import { AppFontSize, ColorMode } from '../common/constant/ThemeConstants'

@Component
export struct CategoryItem {
  @Prop categoryData: CategoryData = new CategoryData()
  @Consume('articlePathStack') articlePS: NavPathStack
  @Consume('colorMode') colorMode: ColorMode;

  build() {
    Column({ space: 16 }) {
      Row({ space: 8 }) {
        Text() {
          SymbolSpan($r('sys.symbol.folder_fill'))
        }
        .fontColor(this.colorMode === ColorMode.LIGHT
          ? $r('app.color.text_shallow')
          : $r('app.color.text_shallow_dark'))
        .fontWeight(FontWeight.Bold)
        .fontSize(AppFontSize.LARGE)

        Text(this.categoryData.categoryName)
          .fontColor(this.colorMode === ColorMode.LIGHT
            ? $r('app.color.text_shallow')
            : $r('app.color.text_shallow_dark'))
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
    .backgroundColor(this.colorMode === ColorMode.LIGHT
      ? $r('app.color.background_card')
      : $r('app.color.background_card_dark'))
  }

  @Builder
  CategoryArticleItem(articleData: ArticleData) {
    Row({ space: 8 }) {
      Text() {
        SymbolSpan($r('sys.symbol.doc_plaintext'))
      }
      .fontColor(this.colorMode === ColorMode.LIGHT
        ? $r('app.color.text')
        : $r('app.color.text_dark'))
      .padding({ left: 16 })
      .fontSize(AppFontSize.MIDDLE)

      Text(articleData.articleName)
        .fontColor(this.colorMode === ColorMode.LIGHT
          ? $r('app.color.text')
          : $r('app.color.text_dark'))
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