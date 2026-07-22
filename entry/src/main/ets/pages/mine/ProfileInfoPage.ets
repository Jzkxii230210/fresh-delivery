import router from '@ohos.router';
import promptAction from '@ohos.promptAction';

@Entry
@Component
struct ProfileInfoPage {
  build() {
    Column() {
      // === 1. 顶部标题栏 ===
      Row() {
        Image($r('app.media.startIcon'))
          .width(20).height(20).margin({ right: 12 })
          .onClick(() => { router.back(); })

        Text('个人资料')
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

      // === 2. 资料主体卡片区 ===
      Scroll() {
        Column() {
          Column() {
            // --- 头像行 ---
            Row() {
              Text('头像').fontSize(14).fontColor('#333333')
              Blank()
              Image($r('app.media.startIcon'))
                .width(44).height(44)
                .borderRadius(22)
                .margin({ right: 6 })
              Image($r('app.media.startIcon')).width(12).height(12)
            }
            .width('100%')
            .padding(16)
            .onClick(() => {
              promptAction.showToast({ message: '更换头像' });
            })

            Divider().color('#F0F0F0').strokeWidth(0.5).margin({ left: 16 })

            // --- ID行 (含复制按钮) ---
            Row() {
              Text('ID').fontSize(14).fontColor('#333333')
              Blank()
              Text('220520012').fontSize(13).fontColor('#666666').margin({ right: 8 })

              Row() {
                Text('复制').fontSize(11).fontColor('#666666')
              }
              .padding({ left: 6, right: 6, top: 2, bottom: 2 })
              .border({ width: 0.5, color: '#CCCCCC' })
              .borderRadius(4)
              .onClick(() => {
                promptAction.showToast({ message: 'ID已复制到剪贴板' });
              })
            }
            .width('100%')
            .padding(16)

            Divider().color('#F0F0F0').strokeWidth(0.5).margin({ left: 16 })

            // --- 昵称行 (带审核中标签) ---
            Row() {
              Text('昵称').fontSize(14).fontColor('#333333')
              Blank()

              // 审核中红标
              Text('审核中')
                .fontSize(10)
                .fontColor('#FF4D4F')
                .backgroundColor('#FFF0F0')
                .padding({ left: 4, right: 4, top: 1, bottom: 1 })
                .borderRadius(2)
                .margin({ right: 8 })

              Text('张小乙是吃货').fontSize(13).fontColor('#666666').margin({ right: 6 })
              Image($r('app.media.startIcon')).width(12).height(12)
            }
            .width('100%')
            .padding(16)
            .onClick(() => {
              // router.pushUrl({ url: 'pages/setting/EditNicknamePage' })
            })
          }
          .width('92%')
          .backgroundColor(Color.White)
          .borderRadius(12)
          .margin({ top: 12 })
          .shadow({ radius: 4, color: 'rgba(0,0,0,0.03)', offsetY: 2 })
        }
        .width('100%')
      }
      .scrollBar(BarState.Off)
      .layoutWeight(1)
      .backgroundColor('#F8F8F8')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8F8F8')
  }
}