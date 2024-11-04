import { ArticleData } from '../viewModel/ArticleData'
import { CategoryData } from '../viewModel/CategoryData'
import { resource2Str } from '../util/TransferUtil'
import { AppFontSize, ColorMode } from '../common/constant/ThemeConstants'
import { ConfirmDialog } from '@kit.ArkUI'
import PreferenceModel from '../model/PreferenceModel'
import AddArticle from './AddArticle'

@Component
export struct CategoryItem {
  @Prop categoryData: CategoryData = new CategoryData()
  @Consume('articlePathStack') articlePS: NavPathStack;
  @Consume('colorMode') colorMode: ColorMode;
  removeCategory?: () => void;
  dialogController: CustomDialogController = new CustomDialogController({
    builder: AddArticle({
      onClickOK: (articleName: string, articleUrl: string) => {
        this.addArticle(articleName, articleUrl);
      }
    }),
    alignment: DialogAlignment.Bottom,
  });

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

        Blank()

        Button({ type: ButtonType.Circle }) {
          Text() {
            SymbolSpan($r('sys.symbol.plus'))
          }
          .fontSize(AppFontSize.LARGE)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
        }
        .backgroundColor($r('app.color.text_shallow_dark'))
        .onClick(() => {
          this.dialogController.open();
        })

        Button({ type: ButtonType.Circle }) {
          Text() {
            SymbolSpan($r('sys.symbol.minus'))
          }
          .fontSize(AppFontSize.LARGE)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
        }
        .backgroundColor($r('app.color.text_shallow_dark'))
        .onClick(() => {
          if (this.removeCategory !== undefined) {
            this.removeCategory();
          }
        })

      }
      .width('100%')

      ForEach(this.categoryData.articles, (item: ArticleData, index: number) => {
        this.CategoryArticleItem(item, index)
      }, (item: ArticleData) => item.articleName)
    }
    .width('100%')
    .padding(16)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(this.colorMode === ColorMode.LIGHT
      ? $r('app.color.background_card')
      : $r('app.color.background_card_dark'))
  }

  @Builder
  CategoryArticleItem(articleData: ArticleData, index: number) {
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
        .width('80%')
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .onClick(() => {
          this.articlePS.pushPathByName('articleDetail', articleData)
        })

      Button({ type: ButtonType.Circle }) {
        Text() {
          SymbolSpan($r('sys.symbol.minus'))
        }
        .fontSize(AppFontSize.MIDDLE)
        .fontColor(Color.White)
      }
      .backgroundColor($r('app.color.text_shallow_dark'))
      .onClick(() => {
        this.remove(index);
      })

    }
    .width('100%')
  }

  async remove(index?: number) {
    // remove article
    let newArticleList: ArticleData[] = [];
    for (let i = 0; i < this.categoryData.articles.length; ++i) {
      if (i !== index) {
        newArticleList.push(this.categoryData.articles[i]);
      }
    }
    this.categoryData.articles = newArticleList;
    await PreferenceModel.addCategory(this.categoryData);
    this.categoryData = PreferenceModel.getCategoryByName(this.categoryData.categoryName);
  }

  async addArticle(articleName: string, articleUrl: string) {
    let validName = this.checkArticleName(articleName);
    if (!validName) {
      return;
    }

    let newArticle: ArticleData = new ArticleData();
    newArticle.articleName = articleName;
    newArticle.webUrl = articleUrl;

    this.categoryData.articles.push(newArticle);
    await PreferenceModel.addCategory(this.categoryData);
    this.categoryData = PreferenceModel.getCategoryByName(this.categoryData.categoryName);

    this.dialogController.close();
  }

  checkArticleName(articleName: string) {
    if (articleName === '') {
      PreferenceModel.showToastMessage("名称不能为空");
      return false;
    }

    for (let i = 0; i < this.categoryData.articles.length; ++i) {
      if (this.categoryData.articles[i].articleName === articleName) {
        PreferenceModel.showToastMessage("名称重复");
        return false;
      }
    }

    return true;
  }

}
