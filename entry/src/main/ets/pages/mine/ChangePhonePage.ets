import router from '@ohos.router';
import promptAction from '@ohos.promptAction';

@Entry
@Component
struct ChangePhonePage {
  // 核心状态：1 为原手机验证，2 为设置新手机号
  @State currentStep: number = 1;

  // 第一步表单
  @State oldSmsCode: string = '';

  // 第二步表单
  @State newPhoneNum: string = '';
  @State newSmsCode: string = '';

  // 倒计时器模拟
  @State countdown: number = 60;
  @State isCounting: boolean = false;

  build() {
    Column() {
      // === 1. 顶部标题栏 ===
      Row() {
        Image($r('app.media.startIcon'))
          .width(20).height(20).margin({ right: 12 })
          .onClick(() => {
            if (this.currentStep === 2) {
              this.currentStep = 1; // 返回第一步
            } else {
              router.back();
            }
          })

        Text(this.currentStep === 1 ? '更换手机号' : '设置新手机号')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Row().width(20) // 平衡右侧
      }
      .width('100%')
      .height(50)
      .padding({ left: 16, right: 16 })
      .backgroundColor(Color.White)

      // === 2. 表单核心内容区 ===
      Column() {
        if (this.currentStep === 1) {
          // --- 第一步：验证原手机号 ---
          Column() {
            // 提示文案
            Text('请输入 136****5678 收到的短信验证码，以完成安全验证~')
              .fontSize(13)
              .fontColor('#666666')
              .width('100%')
              .margin({ top: 20, bottom: 30 })

            // 验证码输入行
            Row() {
              TextInput({ text: this.oldSmsCode, placeholder: '请输入验证码' })
                .layoutWeight(1)
                .height(44)
                .backgroundColor(Color.Transparent)
                .fontSize(14)
                .padding(0)
                .onChange((val) => { this.oldSmsCode = val; })

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

            // 下一步按钮
            Button('下一步')
              .width('100%')
              .height(44)
              .backgroundColor('#10C8A7')
              .fontColor(Color.White)
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .borderRadius(22)
              .onClick(() => {
                if (this.oldSmsCode.trim() === '') {
                  promptAction.showToast({ message: '请输入验证码' });
                  return;
                }
                // 验证通过，切到第二步
                this.currentStep = 2;
              })
          }
          .width('92%')

        } else {
          // --- 第二步：设置新手机号 ---
          Column() {
            // 提示文案
            Text('更换手机号后，下次登录请使用新手机号')
              .fontSize(13)
              .fontColor('#999999')
              .width('100%')
              .margin({ top: 20, bottom: 30 })

            // 新手机号输入行
            Row() {
              Row({ space: 4 }) {
                Text('+86').fontSize(14).fontColor('#333333')
                Image($r('app.media.startIcon')).width(10).height(10)
              }
              .margin({ right: 16 })
              .padding({ right: 16 })
              .border({ width: { right: 0.5 }, color: '#EFEFEF' })

              TextInput({ text: this.newPhoneNum, placeholder: '请输入手机号' })
                .layoutWeight(1)
                .height(44)
                .backgroundColor(Color.Transparent)
                .fontSize(14)
                .padding(0)
                .onChange((val) => { this.newPhoneNum = val; })
            }
            .width('100%')
            .border({ width: { bottom: 0.5 }, color: '#EFEFEF' })
            .margin({ bottom: 16 })

            // 新验证码输入行
            Row() {
              TextInput({ text: this.newSmsCode, placeholder: '请输入验证码' })
                .layoutWeight(1)
                .height(44)
                .backgroundColor(Color.Transparent)
                .fontSize(14)
                .padding(0)
                .onChange((val) => { this.newSmsCode = val; })

              Button('获取验证码')
                .height(34)
                .backgroundColor('#F5F5F5')
                .fontColor('#10C8A7')
                .fontSize(13)
                .borderRadius(6)
                .onClick(() => {
                  promptAction.showToast({ message: '新手机验证码已发送' });
                })
            }
            .width('100%')
            .border({ width: { bottom: 0.5 }, color: '#EFEFEF' })
            .margin({ bottom: 40 })

            // 确定按钮
            Button('确定')
              .width('100%')
              .height(44)
              .backgroundColor('#10C8A7')
              .fontColor(Color.White)
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .borderRadius(22)
              .onClick(() => {
                if (this.newPhoneNum.trim() === '' || this.newSmsCode.trim() === '') {
                  promptAction.showToast({ message: '请完整填写新手机号及验证码' });
                  return;
                }
                promptAction.showToast({ message: '手机号更换成功！' });
                router.back();
              })
          }
          .width('92%')
        }
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor('#F8F8F8')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8F8F8')
  }
}