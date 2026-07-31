import router from '@ohos.router';
import promptAction from '@ohos.promptAction';

@Entry
@Component
export struct SettingsPage {
  // 状态变量，用于绑定开关的状态
  @State isElderMode: boolean = false; // 长辈模式
  @State isPushEnabled: boolean = true; // 消息推送设置

  build() {
    Column() {
      // === 1. 顶部导航栏 ===
      Row() {
        // 返回按钮
        Row() {
          Image($r('app.media.back')) // 请替换为实际的返回箭头 icon
            .width(20)
            .height(20)
            .fillColor('#333333')
        }
        .width(40)
        .height(40)
        .justifyContent(FlexAlign.Start)
        .onClick(() => {
          router.back();
        })

        // 标题
        Text('设置')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#333333')
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        // 右侧占位，保持标题绝对居中
        Blank().width(40)
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16, top: 44 }) // top: 44 用于沉浸式状态栏留白
      .backgroundColor('#F5F5F5')

      // === 2. 设置项滚动区 ===
      Scroll() {
        Column() {
          // --- 卡片组 1：账号与资料 ---
          Column() {
            this.ArrowItem('个人资料', '', true, () => {
              router.pushUrl({ url: 'pages/mine/ProfileInfoPage' });
            })
            this.ArrowItem('账号与安全', '', false, () => {
              router.pushUrl({ url: 'pages/mine/AccountSecurityPage' });
            })
          }
          .backgroundColor(Color.White)
          .borderRadius(12)
          .margin({ bottom: 16 })

          // --- 卡片组 2：长辈模式 ---
          Column() {
            this.ToggleItem('长辈模式', '字体更大，使用更简单', this.isElderMode, (val) => {
              this.isElderMode = val;
            }, false)
          }
          .backgroundColor(Color.White)
          .borderRadius(12)
          .margin({ bottom: 16 })

          // --- 卡片组 3：系统、缓存与协议 ---
          Column() {
            this.ArrowItem('帮助与客服', '', true, () => {
              console.info('SettingsPage: 帮助与客服 clicked');
              router.pushUrl({ url: 'pages/message/ProblemCenterPage' })
                .then(() => { console.info('SettingsPage: 跳转成功'); })
                .catch((err: Error) => { console.error('SettingsPage: 跳转失败', err.message); });
            })
            this.ToggleItem('消息推送设置', '', this.isPushEnabled, (val) => {
              this.isPushEnabled = val;
            }, true)
            this.ArrowItem('隐私管理', '', true, () => {
              router.pushUrl({ url: 'pages/mine/PrivacyManagementPage' });
            })
            this.ArrowItem('用户服务协议', '', true)
            this.ArrowItem('清理本地缓存', '286.50MB', true, () => {
              promptAction.showToast({ message: '缓存已清理' });
            })
            this.ArrowItem('关于我们', '', false, () => {
              router.pushUrl({ url: 'pages/mine/AboutUsPage' });
            })
          }
          .backgroundColor(Color.White)
          .borderRadius(12)
          .margin({ bottom: 24 })

          // --- 卡片组 4：退出登录按钮 ---
          Column() {
            Text('退出登录')
              .fontSize(16)
              .fontColor('#FF3B30') // 警示红
          }
          .width('100%')
          .height(56)
          .backgroundColor(Color.White)
          .borderRadius(12)
          .justifyContent(FlexAlign.Center)
          .margin({ bottom: 40 })
          .onClick(() => {
            promptAction.showDialog({
              title: '提示',
              message: '确定要退出登录吗？',
              buttons: [
                { text: '取消', color: '#999999' },
                { text: '确定', color: '#FF3B30' }
              ]
            }).then(data => {
              if (data.index === 1) {
                promptAction.showToast({ message: '已退出登录' });
                 router.replaceUrl({ url: 'pages/login/LoginPage' });
              }
            })
          })
        }
        .width('100%')
        .padding({ left: 16, right: 16, top: 16 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP]) // 沉浸式状态栏配置
  }

  // ==================== 局部自定义组件 ====================

  /**
   * 基础列表项：文字 + 右侧副标题(可选) + 箭头
   */
  @Builder
  ArrowItem(title: string, value: string = '', showDivider: boolean = true, onClickAction?: () => void) {
    Column() {
      Row() {
        Text(title)
          .fontSize(16)
          .fontColor('#333333')
        Blank()
        if (value) {
          Text(value)
            .fontSize(14)
            .fontColor('#999999')
            .margin({ right: 8 })
        }
        Image($r('app.media.more')) // 请替换为实际的右侧箭头(chevron_right) icon
          .width(12)
          .height(12)
          .opacity(0.4)
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 16, bottom: 16 })
      .onClick(() => {
        if (onClickAction) {
          onClickAction();
        }
      })

      // 底部分割线
      if (showDivider) {
        Divider()
          .color('#F0F0F0')
          .strokeWidth(1)
          .padding({ left: 16, right: 16 })
      }
    }
  }

  /**
   * 开关列表项：文字 + 副标题(可选) + Toggle开关
   */
  @Builder
  ToggleItem(title: string, subTitle: string = '', isOn: boolean, onChangeAction: (value: boolean) => void, showDivider: boolean = true) {
    Column() {
      Row() {
        Column() {
          Text(title)
            .fontSize(16)
            .fontColor('#333333')
            .margin({ bottom: subTitle ? 4 : 0 })

          if (subTitle) {
            Text(subTitle)
              .fontSize(12)
              .fontColor('#999999')
          }
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        Toggle({ type: ToggleType.Switch, isOn: isOn })
          .selectedColor('#10C8A7') // 品牌主题绿
          .switchPointColor('#FFFFFF')
          .onChange((isOn: boolean) => {
            onChangeAction(isOn);
          })
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: subTitle ? 12 : 16, bottom: subTitle ? 12 : 16 })

      // 底部分割线
      if (showDivider) {
        Divider()
          .color('#F0F0F0')
          .strokeWidth(1)
          .padding({ left: 16, right: 16 })
      }
    }
  }
}