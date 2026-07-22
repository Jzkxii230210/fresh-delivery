import router from '@ohos.router';
import promptAction from '@ohos.promptAction';

@Entry
@Component
struct LoginPage {
  @State isAgreed: boolean = false;

  build() {
    Stack({ alignContent: Alignment.Top }) {

      // === 1. 顶部绿色渐变背景区块 ===
      Column() {
        Row() {
          // 左上角关闭按钮
          Image($r('app.media.startIcon'))
            .width(20).height(20)
            .onClick(() => { router.back(); })

          Blank()

          // 右上角随便逛逛
          Text('随便逛逛')
            .fontSize(14)
            .fontColor('#333333')
            .onClick(() => {
              // 游客模式进入主页
              router.replaceUrl({ url: 'pages/main/MainPage' });
            })
        }
        .width('100%')
        .padding({ left: 16, right: 16, top: 12 })
      }
      .width('100%')
      .height(240)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [['#85E3B8', 0.0], ['#52C48A', 1.0]]
      })

      // === 2. 核心内容表单卡片区 ===
      Column() {
        // 品牌 Logo 与名称
        Image($r('app.media.startIcon'))
          .width(72).height(72)
          .borderRadius(36)
          .margin({ top: 120, bottom: 12 })
          .shadow({ radius: 8, color: 'rgba(0,0,0,0.08)', offsetY: 4 })

        Text('小默买菜')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')
          .margin({ bottom: 45 })

        // 掩码手机号
        Text('136****5678')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')
          .letterSpacing(2)
          .margin({ bottom: 20 })

        // 本机号码一键登录按钮
        Button('本机号码一键登录')
          .width('92%')
          .height(46)
          .backgroundColor('#10C8A7')
          .fontColor(Color.White)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .borderRadius(23)
          .margin({ bottom: 60 })
          .onClick(() => {
            if (!this.isAgreed) {
              promptAction.showToast({ message: '请先阅读并勾选服务协议与隐私政策' });
              return;
            }
            // 登录成功，跳转到主页
            router.replaceUrl({ url: 'pages/main/MainPage' });
          })

        // 其他登录方式分隔文案
        Text('其他登录方式')
          .fontSize(12)
          .fontColor('#999999')
          .margin({ bottom: 20 })

        // 第三方/其他登录方式图标行 (手机号验证码、QQ/微信/Apple)
        Row({ space: 32 }) {
          // 验证码登录入口
          Image($r('app.media.startIcon'))
            .width(36).height(36)
            .onClick(() => {
              router.pushUrl({ url: 'pages/login/SmsLoginPage' });
            })

          // 微信登录
          Image($r('app.media.startIcon'))
            .width(36).height(36)
            .onClick(() => {
              router.pushUrl({ url: 'pages/login/ThirdPartyAuthPage' });
            })

          // Apple 登录
          Image($r('app.media.startIcon'))
            .width(36).height(36)
            .onClick(() => {
              router.pushUrl({ url: 'pages/login/ThirdPartyAuthPage' });
            })
        }
        .margin({ bottom: 40 })

        // 底部协议勾选栏
        Row({ space: 4 }) {
          Checkbox({ name: 'checkbox', group: 'checkboxGroup' })
            .select(this.isAgreed)
            .selectedColor('#10C8A7')
            .onChange((value: boolean) => {
              this.isAgreed = value;
            })

          Row() {
            Text('我已阅读并同意签署 ').fontSize(11).fontColor('#666666')
            Text('中国移动服务协议、用户协议').fontSize(11).fontColor('#2F80ED')
            Text(' 和 ').fontSize(11).fontColor('#666666')
            Text('隐私政策').fontSize(11).fontColor('#2F80ED')
          }
          .flexShrink(1)
        }
        .width('92%')
        .justifyContent(FlexAlign.Center)
      }
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8F8F8')
  }
}