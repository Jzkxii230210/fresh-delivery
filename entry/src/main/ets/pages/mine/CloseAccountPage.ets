import router from '@ohos.router';
import promptAction from '@ohos.promptAction';

@Entry
@Component
struct CloseAccountPage {
  // 核心状态机：1-注销须知页, 2-安全验证页, 3-注销成功页
  @State step: number = 1;
  @State isAgreed: boolean = false;
  @State smsCode: string = '';

  build() {
    Column() {
      // === 1. 顶部标题栏 ===
      Row() {
        Image($r('app.media.startIcon'))
          .width(20).height(20).margin({ right: 12 })
          .onClick(() => {
            if (this.step === 2) {
              this.step = 1;
            } else if (this.step === 1) {
              router.back();
            }
          })

        Text(this.step === 3 ? '注销成功' : (this.step === 2 ? '安全验证' : '注销账号'))
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Row().width(20)
      }
      .width('100%')
      .height(50)
      .padding({ left: 16, right: 16 })
      .backgroundColor(Color.White)

      // === 2. 多步骤视图切换 ===
      if (this.step === 1) {
        // --- 步骤一：注销须知说明页 ---
        Stack({ alignContent: Alignment.Bottom }) {
          Scroll() {
            Column() {
              Text('账号注销后，以下信息将被清空且无法找回：')
                .fontSize(13)
                .fontColor('#333333')
                .width('100%')
                .margin({ top: 16, bottom: 12 })

              // 提示细则卡片
              Column() {
                this.NoticeItem('身份、账号信息、隐私信息、用户权益等')
                this.NoticeItem('交易记录')
                this.NoticeItem('红包、优惠券、积分等')
                this.NoticeItem('银行卡的快捷支付服务')

                Divider().color('#F0F0F0').strokeWidth(0.5).margin({ top: 6, bottom: 12 })

                Text('请确保所有交易已完结且无纠纷，账号注销后的历史交易可能产生的资金退回权益等将视作自动放弃。')
                  .fontSize(11)
                  .fontColor('#999999')
                  .lineHeight(16)
              }
              .width('100%')
              .backgroundColor(Color.White)
              .borderRadius(12)
              .padding(16)
              .margin({ bottom: 40 })
              .shadow({ radius: 4, color: 'rgba(0,0,0,0.03)', offsetY: 2 })

              // 底部按钮
              Button('注销账号')
                .width('100%')
                .height(44)
                .backgroundColor(this.isAgreed ? '#10C8A7' : '#A0E8D7')
                .fontColor(Color.White)
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .borderRadius(22)
                .margin({ bottom: 20 })
                .onClick(() => {
                  if (!this.isAgreed) {
                    promptAction.showToast({ message: '请先阅读并勾选用户注销协议' });
                    return;
                  }
                  this.step = 2; // 进入安全验证
                })
            }
            .width('92%')
          }
          .scrollBar(BarState.Off)
          .layoutWeight(1)

          // 底部协议勾选栏
          Row({ space: 6 }) {
            Circle({ width: 16, height: 16 })
              .fill(this.isAgreed ? '#10C8A7' : Color.Transparent)
              .border({ width: 1, color: this.isAgreed ? '#10C8A7' : '#CCCCCC' })
              .onClick(() => {
                this.isAgreed = !this.isAgreed;
              })

            Row({ space: 2 }) {
              Text('我已阅读并同意签署').fontSize(12).fontColor('#666666')
              Text('《用户注销协议》').fontSize(12).fontColor('#10C8A7')
            }
          }
          .width('100%')
          .height(50)
          .justifyContent(FlexAlign.Center)
          .backgroundColor(Color.White)
          .shadow({ radius: 8, color: 'rgba(0,0,0,0.05)', offsetY: -2 })
        }
        .layoutWeight(1)

      } else if (this.step === 2) {
        // --- 步骤二：安全验证短信页 ---
        Column() {
          Text('请输入 136****5678 收到的短信验证码，以完成安全验证~')
            .fontSize(13)
            .fontColor('#666666')
            .width('100%')
            .margin({ top: 20, bottom: 30 })

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
          .border({ bottom: { width: 0.5, color: '#EFEFEF' } })
          .margin({ bottom: 40 })

          Button('下一步')
            .width('100%')
            .height(44)
            .backgroundColor('#10C8A7')
            .fontColor(Color.White)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .borderRadius(22)
            .onClick(() => {
              if (this.smsCode.trim() === '') {
                promptAction.showToast({ message: '请输入验证码' });
                return;
              }
              this.step = 3; // 进入注销成功页
            })
        }
        .width('92%')
        .layoutWeight(1)
        .backgroundColor('#F8F8F8')

      } else {
        // --- 步骤三：注销成功页 ---
        Column() {
          Blank()

          Circle({ width: 70, height: 70 })
            .fill(Color.Transparent)
            .border({ width: 2, color: '#10C8A7' })
            .overlay('✓', { align: Alignment.Center }) // 模拟大对勾
            .margin({ bottom: 20 })

          Text('账号注销成功')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#10C8A7')
            .margin({ bottom: 40 })

          Button('完成')
            .width('92%')
            .height(44)
            .backgroundColor('#10C8A7')
            .fontColor(Color.White)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .borderRadius(22)
            .onClick(() => {
              // 返回登录或首页
              router.clear();
            })

          Blank()
        }
        .width('100%')
        .layoutWeight(1)
        .backgroundColor('#F8F8F8')
        .alignItems(HorizontalAlign.Center)
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8F8F8')
  }

  // --- 辅助 Builder ---
  @Builder NoticeItem(text: string) {
    Row({ space: 8 }) {
      Circle({ width: 6, height: 6 }).fill('#10C8A7')
      Text(text).fontSize(13).fontColor('#333333')
    }
    .width('100%')
    .margin({ bottom: 10 })
  }
}