import router from '@ohos.router';
import promptAction from '@ohos.promptAction';

@Entry
@Component
struct PhoneCodeLoginPage {
  @State phoneNum: string = '';
  @State smsCode: string = '';
  @State isAgreed: boolean = false;
  // 从路由参数获取来源Tab索引
  private fromTabIndex: number = 0;

  aboutToAppear() {
    const params = router.getParams() as Record<string, Object>;
    if (params && params['tabIndex'] !== undefined) {
      this.fromTabIndex = Number(params['tabIndex']);
    }
  }

  build() {
    Column() {
      // === 1. 顶部标题栏 ===
      Row() {
        Image($r('app.media.back'))
          .width(20).height(20)
          .onClick(() => { router.back(); })

        Blank()

        Text('随便逛逛')
          .fontSize(14)
          .fontColor('#333333')
          .onClick(() => {
            promptAction.showToast({ message: '以游客身份随便逛逛' });
          })
      }
      .width('100%')
      .height(50)
      .padding({ left: 16, right: 16 })
      .backgroundColor(Color.White)

      // === 2. 核心表单区域 ===
      Column() {
        // 标题与副标题
        Text('验证码登录')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')
          .width('100%')
          .margin({ top: 20, bottom: 8 })

        Text('未注册的手机号验证通过后将自动注册')
          .fontSize(12)
          .fontColor('#999999')
          .width('100%')
          .margin({ bottom: 40 })

        // 手机号输入行 (+86)
        Row() {
          Row({ space: 4 }) {
            Text('+86').fontSize(14).fontColor('#333333')
            Image($r('app.media.startIcon')).width(10).height(10)
          }
          .margin({ right: 16 })
          .padding({ right: 16 })
          .border({ width: { right: 0.5 }, color: '#EFEFEF' })

          TextInput({ text: this.phoneNum, placeholder: '请输入手机号' })
            .layoutWeight(1)
            .height(44)
            .backgroundColor(Color.Transparent)
            .fontSize(14)
            .padding(0)
            .onChange((val) => { this.phoneNum = val; })
        }
        .width('100%')
        .border({ width: { bottom: 0.5 }, color: '#EFEFEF' })
        .margin({ bottom: 20 })

        // 验证码输入行
        Row() {
          TextInput({ text: this.smsCode, placeholder: '请输入验证码' })
            .layoutWeight(1)
            .height(44)
            .backgroundColor(Color.Transparent)
            .fontSize(14)
            .padding(0)
            .onChange((val) => { this.smsCode = val; })

          Button('获取验证码')
            .height(34)
            .backgroundColor('#F5F5F5')
            .fontColor('#10C8A7')
            .fontSize(13)
            .borderRadius(6)
            .onClick(() => {
              promptAction.showToast({ message: '验证码已发送' });
            })
        }
        .width('100%')
        .border({ width: { bottom: 0.5 }, color: '#EFEFEF' })
        .margin({ bottom: 40 })

        // 登录按钮
        Button('立即登录')
          .width('100%')
          .height(46)
          .backgroundColor('#10C8A7')
          .fontColor(Color.White)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .borderRadius(23)
          .margin({ bottom: 100 })
          .onClick(() => {
            if (!this.isAgreed) {
              promptAction.showToast({ message: '请先勾选用户协议与隐私政策' });
              return;
            }
            if (this.phoneNum.trim() === '' || this.smsCode.trim() === '') {
              promptAction.showToast({ message: '请完整填写手机号与验证码' });
              return;
            }
            promptAction.showToast({ message: '登录成功' });
            // 登录成功，跳转到主页首页
            router.replaceUrl({ 
              url: 'pages/main/MainPage',
              params: { tabIndex: 0 }
            });
          })

        // 其他登录方式
        Text('其他登录方式')
          .fontSize(12)
          .fontColor('#999999')
          .margin({ bottom: 20 })

        Row({ space: 32 }) {
          Image($r('app.media.qqdl')).width(36).height(36)
          Image($r('app.media.weixinzhifu')).width(36).height(36)

        }
        .margin({ bottom: 30 })

        // 底部协议勾选
        Row({ space: 4 }) {
          Checkbox({ name: 'checkbox', group: 'group2' })
            .select(this.isAgreed)
            .selectedColor('#10C8A7')
            .onChange((val) => { this.isAgreed = val; })

          Row() {
            Text('我已阅读并同意签署 ').fontSize(11).fontColor('#666666')
            Text('用户协议').fontSize(11).fontColor('#2F80ED')
            Text(' 和 ').fontSize(11).fontColor('#666666')
            Text('隐私政策').fontSize(11).fontColor('#2F80ED')
          }
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
      }
      .width('92%')
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8F8F8')
  }
}