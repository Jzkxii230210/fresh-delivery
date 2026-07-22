import router from '@ohos.router';
import promptAction from '@ohos.promptAction';

@Entry
@Component
struct EditNicknamePage {
  @State nicknameInput: string = '张小乙是吃货';

  build() {
    Column() {
      // === 1. 顶部标题栏 ===
      Row() {
        Image($r('app.media.startIcon'))
          .width(20).height(20).margin({ right: 12 })
          .onClick(() => { router.back(); })

        Text('修改昵称')
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

      // === 2. 编辑表单区 ===
      Column() {
        // 输入框与一键清除
        Row() {
          TextInput({ text: this.nicknameInput })
            .layoutWeight(1)
            .height(48)
            .backgroundColor(Color.Transparent)
            .fontSize(15)
            .padding(0)
            .onChange((val) => { this.nicknameInput = val; })

          if (this.nicknameInput.length > 0) {
            Image($r('app.media.startIcon'))
              .width(16).height(16)
              .onClick(() => { this.nicknameInput = ''; })
          }
        }
        .width('100%')
        .border({ bottom: { width: 0.5, color: '#EFEFEF' } })
        .margin({ bottom: 12 })

        // 规则说明
        Text('每月可修改1次，限2~12个中文、英文或数字，昵称可与兴趣、心情、地域相关')
          .fontSize(12)
          .fontColor('#999999')
          .lineHeight(16)
          .width('100%')
          .margin({ bottom: 30 })

        // 保存按钮
        Button('保存')
          .width('100%')
          .height(44)
          .backgroundColor('#10C8A7')
          .fontColor(Color.White)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .borderRadius(22)
          .onClick(() => {
            if (this.nicknameInput.trim() === '') {
              promptAction.showToast({ message: '昵称不能为空' });
              return;
            }
            promptAction.showToast({ message: '修改成功，进入审核中' });
            router.back();
          })
      }
      .width('92%')
      .padding({ top: 20 })

      Blank()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8F8F8')
  }
}