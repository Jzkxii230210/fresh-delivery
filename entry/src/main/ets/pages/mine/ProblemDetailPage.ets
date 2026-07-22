import router from '@ohos.router';
import promptAction from '@ohos.promptAction';

@Entry
@Component
struct ProblemDetailPage {
  // 满意度状态: 0-未评价, 1-已解决, 2-未解决
  @State resolveStatus: number = 0;

  build() {
    Column() {
      // === 1. 顶部标题栏 ===
      Row() {
        Image($r('app.media.startIcon'))
          .width(20).height(20).margin({ right: 12 })
          .onClick(() => { router.back(); })

        Text('问题详情')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Image($r('app.media.startIcon')).width(20).height(20)
      }
      .width('100%')
      .height(50)
      .padding({ left: 16, right: 16 })
      .backgroundColor(Color.White)

      // === 2. 详情正文滚动区 ===
      Scroll() {
        Column() {
          // --- 问题标题 ---
          Text('无法修改昵称/头像')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#333333')
            .width('100%')
            .margin({ bottom: 16 })

          // --- 解答正文段落 ---
          Text('你好，可能是以下原因导致无法修改昵称或头像：\n\n1、“用户资料审核中，不可修改”，你之前修改的资料正在审核中，请耐心等待，我们将尽快完成审核；\n\n2、“该昵称已存在”，目前不支持昵称重名，请更换其他合适昵称；\n\n3、“头像无法更换”，请更换较小的图片重新上传；\n\n4、“无错误提示”，请打开消息推送设置，再尝试修改。\n\n如仍无法解决，请点击「帮助与客服」首页的「意见反馈」，提供发生问题的界面截图，我们会尽快处理。')
            .fontSize(14)
            .fontColor('#333333')
            .lineHeight(22)
            .width('100%')
            .margin({ bottom: 30 })

          // --- 满意度评价卡片 (已解决 / 未解决) ---
          Row({ space: 16 }) {
            // 已解决按钮
            Row({ space: 6 }) {
              Image($r('app.media.startIcon')).width(16).height(16)
              Text('已解决').fontSize(14).fontColor(this.resolveStatus === 1 ? '#10C8A7' : '#333333')
            }
            .layoutWeight(1)
            .height(44)
            .justifyContent(FlexAlign.Center)
            .backgroundColor(this.resolveStatus === 1 ? '#E6F8F5' : '#F8F8F8')
            .borderRadius(8)
            .border({ width: 0.5, color: this.resolveStatus === 1 ? '#10C8A7' : '#E0E0E0' })
            .onClick(() => {
              this.resolveStatus = 1;
              promptAction.showToast({ message: '感谢您的反馈！' });
            })

            // 未解决按钮
            Row({ space: 6 }) {
              Image($r('app.media.startIcon')).width(16).height(16)
              Text('未解决').fontSize(14).fontColor(this.resolveStatus === 2 ? '#FF4D4F' : '#333333')
            }
            .layoutWeight(1)
            .height(44)
            .justifyContent(FlexAlign.Center)
            .backgroundColor(this.resolveStatus === 2 ? '#FFF0F0' : '#F8F8F8')
            .borderRadius(8)
            .border({ width: 0.5, color: this.resolveStatus === 2 ? '#FF4D4F' : '#E0E0E0' })
            .onClick(() => {
              this.resolveStatus = 2;
              promptAction.showToast({ message: '已为您记录，建议尝试在线咨询' });
            })
          }
          .width('100%')
          .margin({ bottom: 40 })

          // --- 底部转人工引导 ---
          Row({ space: 4 }) {
            Text('仍未解决？试试').fontSize(13).fontColor('#999999')
            Text('在线咨询')
              .fontSize(13)
              .fontColor('#10C8A7')
              .fontWeight(FontWeight.Medium)
              .onClick(() => {
                // router.pushUrl({ url: 'pages/profile/ChatPage' })
              })
          }
          .width('100%')
          .justifyContent(FlexAlign.Center)
        }
        .width('92%')
        .padding({ top: 20, bottom: 30 })
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