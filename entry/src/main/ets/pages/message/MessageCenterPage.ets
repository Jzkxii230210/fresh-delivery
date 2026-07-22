import router from '@ohos.router';
import promptAction from '@ohos.promptAction';

@Entry
@Component
struct MessageCenterPage {
  // 控制“更多菜单”浮窗的显隐
  @State showMoreMenu: boolean = false;
  // 控制“消息设置”弹窗的显隐
  @State showSettingsDialog: boolean = false;
  // 控制“一键已读”确认弹窗的显隐
  @State showReadDialog: boolean = false;
  // 模拟未读状态
  @State hasUnread: boolean = true;

  build() {
    // 根节点使用 Stack 用于承载各种浮层和弹窗
    Stack({ alignContent: Alignment.TopEnd }) {

      // === 主页面布局 ===
      Column() {
        // --- 1. 顶部标题栏 ---
        Row() {
          Image($r('app.media.startIcon'))
            .width(20).height(20).margin({ right: 12 })
            .onClick(() => { router.back(); })

          Text('消息')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#333333')

          // 扫把图标 (一键已读)
          Image($r('app.media.startIcon'))
            .width(18).height(18)
            .margin({ left: 12 })
            .onClick(() => {
              this.showReadDialog = true; // 唤起一键已读确认弹窗
            })

          Blank()

          // 右上角三个点菜单按钮
          Image($r('app.media.startIcon'))
            .width(20).height(20)
            .onClick(() => {
              this.showMoreMenu = !this.showMoreMenu; // 切换菜单显隐
            })
        }
        .width('100%')
        .height(50)
        .padding({ left: 16, right: 16 })
        .backgroundColor(Color.White)

        // --- 2. 消息列表区 ---
        List() {
          // 消息项 1：订单通知
          ListItem() {
            this.MessageItem(
              '订单通知',
              '你的订单已开始配送',
              '23小时前',
              this.hasUnread
            )
          }
          .onClick(() => {
            this.hasUnread = false; // 点击后消除红点
          })

          // 消息项 2：系统通知
          ListItem() {
            this.MessageItem(
              '系统通知',
              '你提交的个人信息修改申请审核已通...',
              '04-29',
              false
            )
          }

          // 消息项 3：活动通知
          ListItem() {
            this.MessageItem(
              '活动通知',
              '[图文消息]',
              '7天前',
              false
            )
          }
        }
        .width('100%')
        .layoutWeight(1)
        .backgroundColor('#F8F8F8')
        .divider({ strokeWidth: 0.5, color: '#EFEFEF', startMargin: 70, endMargin: 16 })
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F8F8F8')

      // === 3. 右上角“更多菜单”浮窗 (点击三个点展开) ===
      if (this.showMoreMenu) {
        Column() {
          // 屏蔽底层点击遮罩
          Row()
            .width('100%')
            .height('100%')
            .position({ x: 0, y: 0 })
            .backgroundColor(Color.Transparent)
            .onClick(() => { this.showMoreMenu = false; })

          // 菜单实体卡片
          Column() {
            Row() {
              Text('消息设置').fontSize(14).fontColor('#333333')
            }
            .width('100%')
            .height(40)
            .justifyContent(FlexAlign.Center)
            .border({ width: { bottom: 0.5 }, color: '#444444' })
            .onClick(() => {
              this.showMoreMenu = false;
              this.showSettingsDialog = true; // 唤起消息设置弹窗
            })

            Row() {
              Text('联系客服').fontSize(14).fontColor('#333333')
            }
            .width('100%')
            .height(40)
            .justifyContent(FlexAlign.Center)
            .onClick(() => {
              this.showMoreMenu = false;
              promptAction.showToast({ message: '正在呼叫客服...' });
            })
          }
          .width(110)
          .backgroundColor('#2C2C2C') // 适配深色气泡背景
          .borderRadius(8)
          .position({ x: 250, y: 55 }) // 定位在右上角菜单下方
          .zIndex(10)
        }
        .width('100%')
        .height('100%')
      }

      // === 4. 消息设置弹窗 (ActionSheet 效果) ===
      if (this.showSettingsDialog) {
        Stack({ alignContent: Alignment.Bottom }) {
          // 半透明遮罩
          Row().width('100%').height('100%').backgroundColor('rgba(0,0,0,0.4)')
            .onClick(() => { this.showSettingsDialog = false; })

          // 底部弹层面板
          Column() {
            Text('请选择接收范围')
              .fontSize(12)
              .fontColor('#999999')
              .margin({ top: 16, bottom: 16 })

            Divider().color('#F0F0F0').strokeWidth(0.5)

            // 选项 1
            Row() {
              Image($r('app.media.startIcon')).width(14).height(14).margin({ right: 6 }) // 勾选图标
              Text('接收消息推送').fontSize(15).fontColor('#007DFF')
            }
            .width('100%')
            .height(50)
            .justifyContent(FlexAlign.Center)
            .onClick(() => {
              this.showSettingsDialog = false;
              promptAction.showToast({ message: '已开启消息推送' });
            })

            Divider().color('#F0F0F0').strokeWidth(0.5)

            // 选项 2
            Row() {
              Text('不接收消息推送').fontSize(15).fontColor('#333333')
            }
            .width('100%')
            .height(50)
            .justifyContent(FlexAlign.Center)
            .onClick(() => {
              this.showSettingsDialog = false;
              promptAction.showToast({ message: '已关闭消息推送' });
            })

            // 取消按钮
            Column() {
              Text('取消').fontSize(15).fontColor('#333333')
            }
            .width('100%')
            .height(55)
            .backgroundColor('#F8F8F8')
            .justifyContent(FlexAlign.Center)
            .margin({ top: 8 })
            .onClick(() => {
              this.showSettingsDialog = false;
            })
          }
          .width('100%')
          .backgroundColor(Color.White)
          .borderRadius({ topLeft: 16, topRight: 16 })
        }
        .width('100%').height('100%').zIndex(20)
      }

      // === 5. 一键已读确认弹窗 (Dialog 效果) ===
      if (this.showReadDialog) {
        Stack({ alignContent: Alignment.Center }) {
          // 半透明遮罩
          Row().width('100%').height('100%').backgroundColor('rgba(0,0,0,0.4)')
            .onClick(() => { this.showReadDialog = false; })

          // 居中弹窗卡片
          Column() {
            Text('一键标记所有消息为已读？')
              .fontSize(16)
              .fontColor('#333333')
              .fontWeight(FontWeight.Medium)
              .margin({ top: 24, bottom: 24 })

            Divider().color('#EFEFEF').strokeWidth(0.5)

            Row() {
              // 取消
              Row() {
                Text('取消').fontSize(15).fontColor('#666666')
              }
              .layoutWeight(1)
              .height(45)
              .justifyContent(FlexAlign.Center)
              .border({ width: { right: 0.5 }, color: '#EFEFEF' })
              .onClick(() => {
                this.showReadDialog = false;
              })

              // 确定
              Row() {
                Text('确定').fontSize(15).fontColor('#007DFF')
              }
              .layoutWeight(1)
              .height(45)
              .justifyContent(FlexAlign.Center)
              .onClick(() => {
                this.hasUnread = false; // 清除所有未读红点
                this.showReadDialog = false;
                promptAction.showToast({ message: '已全部标记为已读' });
              })
            }
            .width('100%')
          }
          .width('80%')
          .backgroundColor(Color.White)
          .borderRadius(12)
          .zIndex(30)
        }
        .width('100%').height('100%')
      }
    }
    .width('100%')
    .height('100%')
  }

  // --- 局部复用组件：单条消息项 ---
  @Builder MessageItem(title: string, desc: string, time: string, showRedDot: boolean) {
    Row() {
      // 左侧图标（带可选红点）
      Stack({ alignContent: Alignment.TopEnd }) {
        Image($r('app.media.startIcon'))
          .width(44)
          .height(44)
          .borderRadius(8)

        if (showRedDot) {
          Circle({ width: 8, height: 8 })
            .fill('#FF4D4F')
            .margin({ top: -2, right: -2 })
        }
      }
      .margin({ right: 12 })

      // 中间标题与摘要
      Column() {
        Row() {
          Text(title)
            .fontSize(15)
            .fontWeight(FontWeight.Bold)
            .fontColor('#333333')

          Blank()

          Text(time)
            .fontSize(12)
            .fontColor('#999999')
        }
        .width('100%')
        .margin({ bottom: 6 })

        Text(desc)
          .fontSize(13)
          .fontColor('#666666')
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .padding(16)
    .backgroundColor(Color.White)
  }
}