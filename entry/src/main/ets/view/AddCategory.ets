import { AppFontSize } from '../common/constant/ThemeConstants';

@CustomDialog
export default struct AddCategory {
  @State categoryName: string = '';
  private controller?: CustomDialogController;
  onClickOK?: (value: string) => void;

  build() {
    Column() {
      Text("添加新类别")
        .margin('4%')
        .fontSize(AppFontSize.LARGE)
        .fontWeight(FontWeight.Bold)
        .fontColor($r('app.color.text'))

      TextInput({placeholder: "请输入新类别名称"})
        .onChange((value: string) => {
          this.categoryName = value;
        })

      Blank()

      Button("确定")
        .buttonStyle(ButtonStyleMode.TEXTUAL)
        .fontSize(AppFontSize.MIDDLE)
        .alignSelf(ItemAlign.Center)
        .margin({top: '2%'})
        .onClick(() => {
          if (this.onClickOK !== undefined) {
            this.onClickOK(this.categoryName);
          }
        })
    }
    .padding('5%')
    .alignItems(HorizontalAlign.Start)
  }
}