import { OrderData } from '../../common/HomeData';

// 取消订单确认弹窗
@CustomDialog
export struct CancelOrderDialog {
  // 弹窗控制器
  controller: CustomDialogController;
  // 订单数据
  order: OrderData | null = null;
  // 确认取消回调
  onConfirm?: () => void;

  build() {
    Column() {
      // 提示文字
      Text('你确定要取消该订单吗？')
        .fontSize(16)
        .fontColor('#333333')
        .fontWeight(FontWeight.Medium)
        .margin({ top: 24, bottom: 24 })

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

        // 右侧按钮：取消订单
        Button('取消订单')
          .width(120)
          .height(40)
          .backgroundColor('#FF4D4F')
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
