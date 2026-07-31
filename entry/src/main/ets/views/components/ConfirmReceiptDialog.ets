import { OrderData } from '../../common/HomeData';

// 确认收货弹窗
@CustomDialog
export struct ConfirmReceiptDialog {
  // 弹窗控制器
  controller: CustomDialogController;
  // 订单数据
  order: OrderData | null = null;
  // 确认收货回调
  onConfirm?: () => void;

  build() {
    Column() {
      // 标题
      Text('确认收到货了吗')
        .fontSize(16)
        .fontColor('#333333')
        .fontWeight(FontWeight.Medium)
        .margin({ top: 24, bottom: 12 })

      // 提示文字
      Text('为保证你的售后权益，请收到商品确认无误后再确认收货')
        .fontSize(12)
        .fontColor('#999999')
        .margin({ bottom: 24 })
        .width('240')
        .textAlign(TextAlign.Center)

      // 按钮行
      Row({ space: 12 }) {
        // 左侧按钮：点错了
        Button('点错了')
          .width(120)
          .height(40)
          .backgroundColor(Color.White)
          .fontColor('#666666')
          .border({ width: 1, color: '#CCCCCC' })
          .fontSize(15)
          .borderRadius(20)
          .onClick(() => {
            // 关闭弹窗
            this.controller.close();
          })

        // 右侧按钮：确认收货
        Button('确认收货')
          .width(120)
          .height(40)
          .backgroundColor('#10C8A7')
          .fontColor(Color.White)
          .fontSize(15)
          .borderRadius(20)
          .onClick(() => {
            // 关闭弹窗
            this.controller.close();
            // 执行确认回调
            if (this.onConfirm) {
              this.onConfirm();
            }
          })
      }
      .margin({ bottom: 20 })
    }
    .width('280')
    .backgroundColor(Color.White)
    .borderRadius(12)
  }
}
