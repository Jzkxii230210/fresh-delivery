import router from '@ohos.router';
import promptAction from '@ohos.promptAction';

@Entry
@Component
struct SettingsPage {
  @State elderMode: boolean = false;
  @State pushEnabled: boolean = true;

  build() {
    Column() {
      // === 1. 顶部标题栏 ===
      Row() {
        Image($r('app.media.startIcon'))
          .width(20).height(20).margin({ right: 12 })
          .onClick(() => { router.back(); })

        Text('设置')
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

      // === 2. 设置选项滚动区 ===
      Scroll() {
        Column() {
          // --- 分组一：个人资料与账号安全 ---
          Column() {
            this.SettingItemRow('个人资料', '', true, () => {
              router.pushUrl({ url: 'pages/mine/PersonalProfilePage' });
            })
            Divider().color('#F0F0F0').strokeWidth(0.5).margin({ left: 16 })
            this.SettingItemRow('账号与安全', '', true, () => {
              router.pushUrl({ url: 'pages/mine/AccountSecurityPage' });
            })
          }
          .width('92%')
          .backgroundColor(Color.White)
          .borderRadius(12)
          .margin({ top: 12, bottom: 12 })
          .shadow({ radius: 4, color: 'rgba(0,0,0,0.03)', offsetY: 2 })

          // --- 分组二：长辈模式 (带说明副标题) ---
          Column() {
            Row() {
              Column() {
                Text('长辈模式').fontSize(14).fontColor('#333333').margin({ bottom: 2 })
                Text('字体更大，使用更简单').fontSize(11).fontColor('#999999')
              }
              .alignItems(HorizontalAlign.Start)

              Blank()

              Toggle({ type: ToggleType.Switch, isOn: this.elderMode })
                .selectedColor('#10C8A7')
                .onChange((isOn) => { this.elderMode = isOn; })
            }
            .width('100%')
            .padding(16)
          }
          .width('92%')
          .backgroundColor(Color.White)
          .borderRadius(12)
          .margin({ bottom: 12 })
          .shadow({ radius: 4, color: 'rgba(0,0,0,0.03)', offsetY: 2 })

          // --- 分组三：通用偏好与帮助 ---
          Column() {
            // 消息推送开关行
            Row() {
              Text('消息推送设置').fontSize(14).fontColor('#333333')
              Blank()
              Toggle({ type: ToggleType.Switch, isOn: this.pushEnabled })
                .selectedColor('#10C8A7')
                .onChange((isOn) => { this.pushEnabled = isOn; })
            }
            .width('100%')
            .padding(16)

            Divider().color('#F0F0F0').strokeWidth(0.5).margin({ left: 16 })
            this.SettingItemRow('隐私管理', '', true, () => {})
            Divider().color('#F0F0F0').strokeWidth(0.5).margin({ left: 16 })
            this.SettingItemRow('用户服务协议', '', true, () => {})
            Divider().color('#F0F0F0').strokeWidth(0.5).margin({ left: 16 })
            this.SettingItemRow('清理本地缓存', '286.50MB', true, () => {
              promptAction.showToast({ message: '缓存已清理' });
            })
            Divider().color('#F0F0F0').strokeWidth(0.5).margin({ left: 16 })
            this.SettingItemRow('关于我们', '', true, () => {})
          }
          .width('92%')
          .backgroundColor(Color.White)
          .borderRadius(12)
          .margin({ bottom: 16 })
          .shadow({ radius: 4, color: 'rgba(0,0,0,0.03)', offsetY: 2 })

          // --- 退出登录按钮 ---
          Column() {
            Text('退出登录')
              .fontSize(15)
              .fontColor('#FF4D4F')
              .fontWeight(FontWeight.Medium)
          }
          .width('92%')
          .height(50)
          .backgroundColor(Color.White)
          .borderRadius(12)
          .justifyContent(FlexAlign.Center)
          .margin({ bottom: 30 })
          .shadow({ radius: 4, color: 'rgba(0,0,0,0.03)', offsetY: 2 })
          .onClick(() => {
            promptAction.showToast({ message: '已安全退出登录' });
          })
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

  @Builder SettingItemRow(title: string, value: string, showArrow: boolean, onClickCallback: () => void) {
    Row() {
      Text(title).fontSize(14).fontColor('#333333')
      Blank()
      if (value) {
        Text(value).fontSize(13).fontColor('#999999').margin({ right: 6 })
      }
      if (showArrow) {
        Image($r('app.media.startIcon')).width(12).height(12)
      }
    }
    .width('100%')
    .padding(16)
    .onClick(onClickCallback)
  }
}