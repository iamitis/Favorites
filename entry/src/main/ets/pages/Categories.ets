import { CategoryItem } from '../view/CategoryItem'
import { ArticleData } from '../viewModel/ArticleData'
import { CategoryData } from '../viewModel/CategoryData'
import CategoryModel from '../viewModel/CategoryModel'
import { ArticleDetail } from './ArticleDetail'

let categoryModel = new CategoryModel()

@Component
export struct Categories {
  @Provide('articlePathStack') articlePS: NavPathStack = new NavPathStack()
  @State categoriesList: CategoryData[] = []

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
      .setDivider()
    }
    .navDestination(this.CategoriesRouter)
    .backgroundColor(Color.Black)
  }

  @Builder
  PagesMap(name: string) {

  }

}

@Extend(List)
function setDivider() {
  .divider({
    startMargin: 10,
    endMargin: 10,
    strokeWidth: 2,
    color: Color.Gray
  })
}
