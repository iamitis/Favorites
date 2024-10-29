import { ArticleData } from '../viewModel/ArticleData'
import { webview } from '@kit.ArkWeb'
import { resource2Str } from '../utils/utils';

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
        WebComponent({webUrl: this.articleData?.webUrl, webController: this.webController})
      }
    }
  }

  rsrc2Str(resource: Resource): string {
    return resource2Str(getContext(this), resource)
  }
}

@Component
struct WebComponent {
  @Prop webUrl: string | null;
  @Prop webController: WebviewController;

  build() {
    Column() {
      Web({ src: this.webUrl, controller: this.webController })
    }
  }
}