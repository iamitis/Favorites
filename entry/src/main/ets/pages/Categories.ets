import { AppFontSize, ColorMode } from '../common/constant/ThemeConstants'
import { CategoryItem } from '../view/CategoryItem'
import { ArticleData } from '../viewModel/ArticleData'
import { CategoryData } from '../viewModel/CategoryData'
import CategoryModel from '../model/CategoryModel'
import { ArticleDetail } from './ArticleDetail'
import AddCategory from '../view/AddCategory'
import PreferenceModel from '../model/PreferenceModel'

let categoryModel = new CategoryModel()

@Component
export struct Categories {
  @Provide('articlePathStack') articlePS: NavPathStack = new NavPathStack();
  @State categoriesList: CategoryData[] = [];
  @Consume('colorMode') colorMode: ColorMode;
  plusIcon: Resource = $r('sys.symbol.plus');
  dialogController: CustomDialogController = new CustomDialogController({
    builder: AddCategory({
      onClickOK: (value: string): void => {this.addCategory(value)}
    }),
    alignment: DialogAlignment.Bottom,
  });

  async aboutToAppear() {
    this.categoriesList = await categoryModel.loadCategories();
  }

  @Builder
  CategoriesRouter(name: string, param?: ArticleData) {
    if (name === 'articleDetail') {
      ArticleDetail();
    }
  }

  build() {
    Navigation(this.articlePS) {
      Column() {
        List() {
          ForEach(this.categoriesList, (item: CategoryData) => {
            CategoryItem({
              categoryData: item,
              removeCategory: () => {this.removeCategory(item.categoryName)}
            })
          }, (item: CategoryData) => JSON.stringify(item.categoryName))
        }
        .setDivider(this.colorMode)
        .height('90%')
        .width('100%')

        Blank()

        Button({ type: ButtonType.Circle }) {
          Text() {
            SymbolSpan(this.plusIcon)
          }
          .fontSize(AppFontSize.XXXLARGE)
          .fontColor(this.colorMode === ColorMode.LIGHT
            ? $r('app.color.text')
            : $r('app.color.text_dark'))
        }
        .width(60)
        .height(60)
        .backgroundColor(this.colorMode === ColorMode.LIGHT
          ? Color.White
          : Color.Black)
        .onClick(() => {
          this.dialogController.open()
        })
      }
      .height('100%')
    }
    .navDestination(this.CategoriesRouter)
    .hideToolBar(true)
    .height('100%')
    .width('100%')
    .backgroundColor(this.colorMode === ColorMode.LIGHT
      ? $r('app.color.background')
      : $r('app.color.background_dark'))
  }


  async addCategory(categoryName: string) {
    let nameIsValid = await this.checkCategoryName(categoryName)
    if (!nameIsValid) {
      return;
    }

    let newCategory: CategoryData = new CategoryData(categoryName);
    await PreferenceModel.addCategory(newCategory);
    this.categoriesList = await categoryModel.loadCategories();
    this.dialogController.close();
  }


  async checkCategoryName(categoryName: string) {
    if (categoryName === '') {
      PreferenceModel.showToastMessage("名称不能为空")
      return false;
    }

    let allCategories = await categoryModel.loadCategories();
    let count = allCategories.length;

    for (let i = 0; i < count; ++i) {
      if (allCategories[i].categoryName === categoryName) {
        PreferenceModel.showToastMessage("此类别已存在")
        return false;
      }
    }

    return true;
  }


  async removeCategory(categoryName: string) {
    await PreferenceModel.deletePreference(categoryName);
    this.categoriesList = await PreferenceModel.getAllCategories();
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
