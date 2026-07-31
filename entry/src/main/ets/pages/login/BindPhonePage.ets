import router from '@ohos.router';
const PRIMARY_GREEN = '#00C896'
const TEXT_MAIN = '#333333'
const TEXT_GRAY = '#999999'
const LINK_BLUE = '#2577FF'
const INPUT_BG = '#F7F7F7'
const BG_WHITE = '#FFFFFF'

@Entry
@Component
export struct BindPhonePage {
  @State phone: string = ''
  @State code: string = ''
  @State agreeProtocol: boolean = true
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
      // 返回导航
      Row() {
        Image($r('app.media.back'))
          .width(24)
          .height(24)
          .onClick(() => router.back())
        Blank()
        Rect().width(24).height(24).fillOpacity(0)
      }
      .width('100%')
      .padding({ left: 16, top: 12 })

      Scroll() {
        Column() {
          Text('绑定手机号')
            .fontSize(28)
            .fontWeight(FontWeight.Medium)
            .fontColor('#000')
            .width('100%')
            .margin({ top: 40 })

          Text('未绑定的手机号验证通过后将自动注册')
            .fontSize(16)
            .fontColor(TEXT_GRAY)
            .width('100%')
            .textAlign(TextAlign.Center)
            .margin({ top: 16 })

          Blank().height(60)

          // 手机号输入框
          Row() {
            Row() {
              Text('+86').fontSize(20).fontColor('#000')
            }
            Rect().width(1).height(28).fill('#DDDDDD').margin({ left: 10, right: 10 })
            TextInput({ text: this.phone, placeholder: '请输入手机号' })
              .layoutWeight(1)
              .fontSize(20)
              .fontColor('#000')
              .placeholderFont({ size:20 })
              .placeholderColor(TEXT_GRAY)
              .onChange((v:string)=>this.phone = v)
          }
          .width('100%')
          .height(56)
          .backgroundColor(INPUT_BG)
          .borderRadius(8)
          .padding({ left:14 })

          // 验证码行
          Row() {
            TextInput({ text: this.code, placeholder: '请输入验证码' })
              .layoutWeight(1)
              .fontSize(20)
              .fontColor('#000')
              .placeholderFont({ size:20 })
              .placeholderColor(TEXT_GRAY)
              .onChange((v:string)=>this.code = v)
            Button('获取验证码')
              .height(44)
              .backgroundColor(BG_WHITE)
              .fontSize(16)
              .fontColor(PRIMARY_GREEN)
              .borderRadius(6)
          }
          .width('100%')
          .height(56)
          .backgroundColor(INPUT_BG)
          .borderRadius(8)
          .padding({ left:14, right:14 })
          .margin({ top:20 })

          Blank().height(60)

          // 绑定登录按钮
          Button('绑定并登录')
            .width('100%')
            .height(58)
            .backgroundColor(PRIMARY_GREEN)
            .fontSize(20)
            .fontColor(BG_WHITE)
            .borderRadius(12)
            .onClick(() => {
              // 登录成功跳转首页
              router.replaceUrl({
                url: 'pages/main/MainPage',
                params: { tabIndex: this.fromTabIndex }
              });
            })

          Blank().height(80)

          // 协议勾选
          Row() {
            Checkbox().width(20).height(20).select(this.agreeProtocol)
              .selectedColor(PRIMARY_GREEN)
              .onChange((v:boolean)=>this.agreeProtocol = v)
            Text('我已阅读并同意签署 ')
              .fontSize(15)
              .fontColor(TEXT_GRAY)
            Text('用户协议 ')
              .fontSize(15)
              .fontColor(LINK_BLUE)
            Text('和 ')
              .fontSize(15)
              .fontColor(TEXT_GRAY)
            Text('隐私政策')
              .fontSize(15)
              .fontColor(LINK_BLUE)
          }
          .width('100%')
          .justifyContent(FlexAlign.Center)
        }
        .width('100%')
        .padding({ left: 24, right: 24 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BG_WHITE)
  }
}
