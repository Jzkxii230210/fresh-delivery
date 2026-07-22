import router from '@ohos.router';
import promptAction from '@ohos.promptAction';

/**
 * 验证码登录 / 账号密码登录
 */
@Entry
@Component
struct SmsLoginPage {
  @State phoneNumber: string = '';
  @State verifyCode: string = '';
  @State countdown: number = 0;
  @State isAgreed: boolean = false;

  build() {
    Column() {
      // 顶部导航栏
      Row() {
        Image($r('app.media.startIcon'))
          .width(20)
          .height(20)
          .onClick(() => {
            router.back();
          })

        Text('验证码登录')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        // 占位，保持标题居中
        Text('')
          .width(20)
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 12, bottom: 12 })

      // 手机号输入
      Column() {
        Text('手机号')
          .fontSize(12)
          .fontColor('#999999')
          .width('100%')
          .margin({ bottom: 8 })

        TextInput({ placeholder: '请输入手机号', text: this.phoneNumber })
          .type(InputType.Number)
          .maxLength(11)
          .height(44)
          .backgroundColor('#F5F5F5')
          .borderRadius(8)
          .onChange((value: string) => {
            this.phoneNumber = value;
          })
      }
      .width('100%')
      .padding({ left: 16, right: 16 })
      .margin({ top: 24 })

      // 验证码输入
      Column() {
        Text('验证码')
          .fontSize(12)
          .fontColor('#999999')
          .width('100%')
          .margin({ bottom: 8 })

        Row() {
          TextInput({ placeholder: '请输入验证码', text: this.verifyCode })
            .type(InputType.Number)
            .maxLength(6)
            .height(44)
            .backgroundColor('#F5F5F5')
            .borderRadius(8)
            .layoutWeight(1)
            .onChange((value: string) => {
              this.verifyCode = value;
            })

          // 获取验证码按钮
          Button(this.countdown > 0 ? `${this.countdown}s` : '获取验证码')
            .width(100)
            .height(44)
            .fontSize(13)
            .fontColor(this.countdown > 0 ? '#999999' : '#10C8A7')
            .backgroundColor('#F5F5F5')
            .borderRadius(8)
            .margin({ left: 12 })
            .enabled(this.countdown === 0 && this.phoneNumber.length === 11)
            .onClick(() => {
              if (this.phoneNumber.length === 11) {
                // 发送验证码
                promptAction.showToast({ message: '验证码已发送' });
                this.countdown = 60;
                // 倒计时
                let timer = setInterval(() => {
                  this.countdown--;
                  if (this.countdown <= 0) {
                    clearInterval(timer);
                  }
                }, 1000);
              }
            })
        }
        .width('100%')
      }
      .width('100%')
      .padding({ left: 16, right: 16 })
      .margin({ top: 16 })

      // 用户协议
      Row() {
        Checkbox()
          .select(this.isAgreed)
          .selectedColor('#10C8A7')
          .onChange((isChecked: boolean) => {
            this.isAgreed = isChecked;
          })
          .width(16)
          .height(16)

        Text() {
          Span('我已阅读并同意')
            .fontSize(11)
            .fontColor('#999999')
          Span('《用户协议》')
            .fontSize(11)
            .fontColor('#10C8A7')
          Span('和')
            .fontSize(11)
            .fontColor('#999999')
          Span('《隐私政策》')
            .fontSize(11)
            .fontColor('#10C8A7')
        }
      }
      .width('100%')
      .padding({ left: 16, right: 16 })
      .margin({ top: 16 })

      // 登录按钮
      Button('登录')
        .width('92%')
        .height(44)
        .backgroundColor(this.isAgreed && this.phoneNumber.length === 11 && this.verifyCode.length >= 4 ? '#10C8A7' : '#CCCCCC')
        .fontColor(Color.White)
        .fontSize(15)
        .fontWeight(FontWeight.Medium)
        .borderRadius(22)
        .margin({ top: 32 })
        .enabled(this.isAgreed && this.phoneNumber.length === 11 && this.verifyCode.length >= 4)
        .onClick(() => {
          // 登录成功，跳转到主页
          router.replaceUrl({ url: 'pages/main/MainPage' });
        })

      // 其他登录方式
      Column() {
        Text('其他登录方式')
          .fontSize(12)
          .fontColor('#999999')
          .margin({ bottom: 16 })

        Row({ space: 32 }) {
          // 微信登录
          Image($r('app.media.startIcon'))
            .width(36)
            .height(36)
            .onClick(() => {
              router.pushUrl({ url: 'pages/login/ThirdPartyAuthPage' });
            })

          // QQ登录
          Image($r('app.media.startIcon'))
            .width(36)
            .height(36)
            .onClick(() => {
              router.pushUrl({ url: 'pages/login/ThirdPartyAuthPage' });
            })
        }
      }
      .margin({ top: 40 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}
