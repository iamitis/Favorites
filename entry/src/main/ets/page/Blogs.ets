import { CategoryItem } from '../view/CategoryItem'
import { CategoryData } from '../viewModel/CategoryData'

@Component
export struct Blogs {
  @Provide('pageInfos') pageInfos: NavPathStack = new NavPathStack()
  @State categoriesList: CategoryData[] = []

  build() {
    Column() {
      Text('Blog')
    }
  }
}