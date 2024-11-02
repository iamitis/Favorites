import { AppFontSize } from '../common/constant/ThemeConstants';

@CustomDialog
export default struct AddArticle {
  @State articleName: string = '';
  @State articleUrl: string = '';
  private controller?: CustomDialogController;
  onClickOK?: (articleName: string, articleUrl: string) => void;

  build() {
    Column() {
      Text("添加新项目")
        .margin('4%')
        .fontSize(AppFontSize.LARGE)
        .fontWeight(FontWeight.Bold)
        .fontColor($r('app.color.text'))

      TextInput({placeholder: "请输入新项目名称"})
        .onChange((value: string) => {
          this.articleName = value;
        })

      TextInput({placeholder: "请输入新项目链接"})
        .onChange((value: string) => {
          this.articleUrl = value;
        })
        .margin({top: '4%'})

      Blank()

      Button("确定")
        .buttonStyle(ButtonStyleMode.TEXTUAL)
        .fontSize(AppFontSize.MIDDLE)
        .alignSelf(ItemAlign.Center)
        .margin({top: '2%'})
        .onClick(() => {
          if (this.onClickOK !== undefined) {
            this.onClickOK(this.articleName, this.articleUrl);
          }
        })
    }
    .padding('5%')
    .alignItems(HorizontalAlign.Start)

  }

}