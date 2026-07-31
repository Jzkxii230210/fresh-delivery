import router from '@ohos.router';

@Entry
@Component
export struct OrderUnloginPage {
  // 当前Tab索引（订单是第4个Tab，索引为3）
  private readonly TAB_INDEX: number = 3;
  build() {
    Column() {
      // 顶部标题栏
      Row() {
        Text('订单中心')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#333333')
      }
      .width('100%')
      .height(50)
      .justifyContent(FlexAlign.Center)

      // 居中空状态区域
      Column() {
        // 模拟未登录的单据图标 (替换为你的实际切图)
        Image($r('app.media.dingdan'))
          .width(80)
          .height(80)
          .margin({ bottom: 16 })

        Text('暂未登录')
          .fontSize(16)
          .fontColor('#333333')
          .fontWeight(FontWeight.Medium)
          .margin({ bottom: 8 })

        Text('登录后才可同步你的订单哦~')
          .fontSize(12)
          .fontColor('#999999')
          .margin({ bottom: 24 })

        // 立即登录按钮
        Button('立即登录')
          .width(120)
          .height(36)
          .backgroundColor('#10C8A7') // 原型图的主题绿
          .fontColor(Color.White)
          .fontSize(14)
          .borderRadius(18)
          .onClick(() => {
            router.pushUrl({ 
              url: 'pages/login/LoginPage',
              params: { tabIndex: this.TAB_INDEX }
            });
          })
      }
      .layoutWeight(1) // 占据除标题栏外的剩余所有空间
      .width('100%')
      .justifyContent(FlexAlign.Center) // 垂直居中
      .margin({ top: -50 }) // 视觉上稍微向上偏移一点更好看
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8F8F8')
  }
}