import { ColorMode } from '../common/constant/ThemeConstants'
import { CategoryItem } from '../view/CategoryItem'
import { ArticleData } from '../viewModel/ArticleData'
import { CategoryData } from '../viewModel/CategoryData'
import CategoryModel from '../model/CategoryModel'
import { ArticleDetail } from './ArticleDetail'

let categoryModel = new CategoryModel()

@Component
export struct Categories {
  @Provide('articlePathStack') articlePS: NavPathStack = new NavPathStack()
  @State categoriesList: CategoryData[] = []
  @Consume('colorMode') colorMode: ColorMode;

  aboutToAppear(): void {
    this.categoriesList = categoryModel.loadCategories()
  }

  @Builder
  CategoriesRouter(name: string, param?: ArticleData) {
    if (name === 'articleDetail') {
      ArticleDetail()
    }
  }

  build() {
    Navigation(this.articlePS) {
      List() {
        ForEach(this.categoriesList, (item: CategoryData) => {
          CategoryItem({ categoryData: item })
        }, (item: CategoryData) => JSON.stringify(item.categoryName))
      }
      .setDivider(this.colorMode)
    }
    .navDestination(this.CategoriesRouter)
    .backgroundColor(this.colorMode === ColorMode.LIGHT
      ? $r('app.color.background')
      : $r('app.color.background_dark'))
  }

}

@Extend(List)
function setDivider(colorMode: ColorMode) {
  .divider({
    startMargin: 16,
    endMargin: 16,
    strokeWidth: 1,
    color: colorMode === ColorMode.LIGHT
      ? $r('app.color.background')
      : $r('app.color.background_dark')
  })
}
