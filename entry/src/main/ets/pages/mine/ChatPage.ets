import router from '@ohos.router';
import promptAction from '@ohos.promptAction';

@Entry
@Component
struct ChatPage {
  // 核心状态：true 为人工客服模式，false 为机器人客服模式
  @State isHumanService: boolean = false;
  @State inputMessage: string = '';

  build() {
    Column() {
      // === 1. 顶部导航栏 ===
      Row() {
        Image($r('app.media.startIcon'))
          .width(20).height(20).margin({ right: 12 })
          .onClick(() => { router.back(); })

        // 头像与昵称
        Row({ space: 8 }) {
          Image($r('app.media.startIcon'))
            .width(28).height(28)
            .borderRadius(14)

          Text(this.isHumanService ? '小默-9527' : '小默机器人')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor('#333333')
        }
        .layoutWeight(1)
        .justifyContent(FlexAlign.Center)

        // 右上角热线电话
        Row({ space: 4 }) {
          Image($r('app.media.startIcon')).width(14).height(14)
          Text('热线').fontSize(13).fontColor('#333333')
        }
        .onClick(() => {
          promptAction.showToast({ message: '正在拨打客服热线...' });
        })
      }
      .width('100%')
      .height(50)
      .padding({ left: 16, right: 16 })
      .backgroundColor(Color.White)

      // === 2. 人工客服工作时间提示条 (仅在人工模式下显示) ===
      if (this.isHumanService) {
        Row() {
          Image($r('app.media.startIcon')).width(14).height(14).margin({ right: 6 })
          Text('工作时间：9:00~21:00').fontSize(12).fontColor('#D97706')
          Blank()
          Image($r('app.media.startIcon')).width(12).height(12)
        }
        .width('100%')
        .padding({ left: 16, right: 16, top: 8, bottom: 8 })
        .backgroundColor('#FEF3C7')
      }

      // === 3. 聊天消息滚动流区 ===
      Scroll() {
        Column() {
          // 欢迎语
          this.RobotMessageItem(
            this.isHumanService
              ? '你好，客服小默-9527很高兴为你服务！'
              : 'Hi~ 小默机器人客服为你服务！'
          )

          // 猜你想问/常见问题推荐卡片
          Column() {
            Text('猜你想问')
              .fontSize(13)
              .fontWeight(FontWeight.Bold)
              .fontColor('#333333')
              .width('100%')
              .margin({ bottom: 12 })

            List({ space: 12 }) {
              ListItem() { this.QuestionRow('刚下单发现信息填错了怎么办？') }
              ListItem() { this.QuestionRow('订单能不能自提？') }
              ListItem() { this.QuestionRow('账号密码怎么修改？') }
              ListItem() { this.QuestionRow('如何更换绑定手机号？') }
              ListItem() { this.QuestionRow('如何催单？') }
            }
            .width('100%')
          }
          .width('92%')
          .backgroundColor(Color.White)
          .borderRadius(12)
          .padding(16)
          .margin({ top: 12, bottom: 12 })
          .shadow({ radius: 4, color: 'rgba(0,0,0,0.03)', offsetY: 2 })

          // 用户发送的查询关键词气泡示例
          Row() {
            Blank()
            Text('密码')
              .fontSize(14)
              .fontColor(Color.White)
              .backgroundColor('#10C8A7')
              .padding({ left: 14, right: 14, top: 10, bottom: 10 })
              .borderRadius({ topLeft: 12, topRight: 2, bottomLeft: 12, bottomRight: 12 })
          }
          .width('92%')
          .margin({ bottom: 12 })

          // 机器人推荐的关联解答卡片
          Column() {
            Text('你是想咨询以下问题么：')
              .fontSize(13)
              .fontColor('#666666')
              .width('100%')
              .margin({ bottom: 10 })

            Row() {
              Text('账号密码怎么修改？').fontSize(14).fontColor('#333333')
              Blank()
              Image($r('app.media.startIcon')).width(12).height(12)
            }
            .width('100%')
            .padding({ top: 8, bottom: 8 })
            .border({ bottom: { width: 0.5, color: '#F0F0F0' } })

            Row() {
              Text('忘记登录密码怎么办？').fontSize(14).fontColor('#333333')
              Blank()
              Image($r('app.media.startIcon')).width(12).height(12)
            }
            .width('100%')
            .padding({ top: 8, bottom: 8 })
          }
          .width('92%')
          .backgroundColor(Color.White)
          .borderRadius(12)
          .padding(16)
          .margin({ bottom: 12 })
          .shadow({ radius: 4, color: 'rgba(0,0,0,0.03)', offsetY: 2 })

          // 如果是人工模式，显示接通提示与结束咨询按钮
          if (this.isHumanService) {
            Row() {
              Text('[在线客服] 小默-9527 为你提供服务')
                .fontSize(11)
                .fontColor('#999999')
                .backgroundColor('#EFEFEF')
                .padding({ left: 10, right: 10, top: 4, bottom: 4 })
                .borderRadius(4)
            }
            .width('100%')
            .justifyContent(FlexAlign.Center)
            .margin({ bottom: 12 })

            Row() {
              Button('结束咨询')
                .width(100)
                .height(34)
                .backgroundColor('#FEF3C7')
                .fontColor('#D97706')
                .fontSize(13)
                .borderRadius(17)
                .onClick(() => {
                  this.isHumanService = false;
                  promptAction.showToast({ message: '已结束人工咨询，为您转回机器人' });
                })
            }
            .width('92%')
            .margin({ bottom: 20 })
          }
        }
        .width('100%')
      }
      .scrollBar(BarState.Off)
      .layoutWeight(1)
      .backgroundColor('#F8F8F8')

      // === 4. 底部输入与操作栏 ===
      Row({ space: 12 }) {
        // 左侧切换按钮 (机器人模式下显示“转人工”，人工模式下可扩展其他快捷功能)
        if (!this.isHumanService) {
          Column() {
            Image($r('app.media.startIcon')).width(20).height(20).margin({ bottom: 2 })
            Text('转人工').fontSize(10).fontColor('#333333')
          }
          .onClick(() => {
            this.isHumanService = true;
            promptAction.showToast({ message: '正在为您转接人工客服...' });
          })
        }

        // 文本输入框
        TextInput({ text: this.inputMessage, placeholder: '用一句话描述你的问题' })
          .layoutWeight(1)
          .height(40)
          .backgroundColor('#F5F5F5')
          .fontSize(13)
          .padding({ left: 12, right: 12 })
          .borderRadius(20)
          .onChange((val) => {
            this.inputMessage = val;
          })

        // 发送按钮
        Button('发送')
          .width(70)
          .height(36)
          .backgroundColor('#10C8A7')
          .fontColor(Color.White)
          .fontSize(14)
          .borderRadius(18)
          .onClick(() => {
            if (this.inputMessage.trim() !== '') {
              this.inputMessage = '';
              promptAction.showToast({ message: '发送成功' });
            }
          })
      }
      .width('100%')
      .backgroundColor(Color.White)
      .padding({ left: 16, right: 16, top: 10, bottom: 12 })
      .shadow({ radius: 8, color: 'rgba(0,0,0,0.05)', offsetY: -2 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8F8F8')
  }

  // --- 辅助 Builder：机器人/客服消息气泡 ---
  @Builder RobotMessageItem(content: string) {
    Row() {
      Text(content)
        .fontSize(14)
        .fontColor('#333333')
        .backgroundColor(Color.White)
        .padding({ left: 14, right: 14, top: 10, bottom: 10 })
        .borderRadius({ topLeft: 2, topRight: 12, bottomLeft: 12, bottomRight: 12 })
        .shadow({ radius: 2, color: 'rgba(0,0,0,0.02)', offsetY: 1 })
      Blank()
    }
    .width('92%')
    .margin({ top: 12, bottom: 4 })
  }

  // --- 辅助 Builder：常见问题行 ---
  @Builder QuestionRow(question: string) {
    Row() {
      Text(question).fontSize(14).fontColor('#333333')
      Blank()
      Image($r('app.media.startIcon')).width(12).height(12)
    }
    .width('100%')
  }
}