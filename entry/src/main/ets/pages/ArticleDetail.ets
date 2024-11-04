import { ArticleData } from '../viewModel/ArticleData'
import { webview } from '@kit.ArkWeb'
import { resource2Str } from '../util/TransferUtil';
import { ColorMode } from '../common/constant/ThemeConstants';

@Component
export struct ArticleDetail {
  @State articleData: ArticleData | null = null;
  @State webController: webview.WebviewController = new webview.WebviewController();
  @Consume('articlePathStack') articlePS: NavPathStack

  aboutToAppear(): void {
    this.articleData = this.articlePS.getParamByName('articleDetail')[0] as ArticleData;
  }

  build() {
    NavDestination() {
      Column() {
        WebComponent({ webUrl: this.articleData?.webUrl, webController: this.webController })
      }
    }
  }
}

@Component
struct WebComponent {
  @Prop webUrl: string | null;
  @Prop webController: WebviewController;
  @Consume('colorMode') colorMode: ColorMode;

  build() {
    Column() {
      Web({ src: this.webUrl, controller: this.webController })
        .darkMode(this.colorMode === ColorMode.LIGHT
          ? WebDarkMode.Off
          : WebDarkMode.On)
        .forceDarkAccess(true)
    }
  }
}