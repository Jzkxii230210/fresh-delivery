import router from '@ohos.router';
import promptAction from '@ohos.promptAction';

@Entry
@Component
export struct ProblemDetailPage {
  // 记录用户的反馈状态：0-未操作，1-已解决，2-未解决
  @State feedbackStatus: number = 0;

  // 模拟从上个页面路由传过来的问题标题与内容
  private problemTitle: string = '无法修改昵称/头像';
  private problemContent: string =
    '你好，可能是以下原因导致无法修改昵称或头像：\n\n' +
      '1、“用户资料审核中，不可修改”，你之前修改的资料正在审核中，请耐心等待，我们将尽快完成审核；\n\n' +
      '2、“该昵称已存在”，目前不支持昵称重名，请更换其他合适昵称；\n\n' +
      '3、“头像无法更换”，请更换较小的图片重新上传；\n\n' +
      '4、“无错误提示”，请打开消息推送设置，再尝试修改。\n\n' +
      '如仍无法解决，请点击「帮助与客服」首页的「意见反馈」，提供发生问题的界面截屏，我们会尽快处理。';

  build() {
    Column() {
      // === 1. 顶部导航栏 ===
      Row() {
        Image($r('app.media.back')) // 替换为真实的返回箭头
          .width(20)
          .height(20)
          .fillColor('#333333')
          .onClick(() => {
            router.back();
          })

        Text('问题详情')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#333333')
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Image($r('app.media.search')) // 替换为真实的搜索图标 (Search)
          .width(20)
          .height(20)
          .fillColor('#333333')
          .onClick(() => {
            router.pushUrl({ url: 'pages/mine/ProblemSearchPage' });
          })
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16, top: 44 }) // 适配顶部状态栏
      .backgroundColor(Color.White)

      // === 2. 页面主滚动区 ===
      Scroll() {
        Column() {
          // --- 标题 ---
          Text(this.problemTitle)
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor('#333333')
            .width('100%')
            .margin({ top: 16, bottom: 20 })

          // --- 正文内容 ---
          Text(this.problemContent)
            .fontSize(15)
            .fontColor('#444444')
            .lineHeight(26) // 增加行高，提升长文本阅读体验
            .width('100%')
            .margin({ bottom: 40 })

          // --- 反馈按钮区 ---
          Row({ space: 16 }) {
            // “已解决”按钮
            Row({ space: 8 }) {
              Image($r('app.media.dianzan')) // 替换为点赞/大拇指向上图标
                .width(16)
                .height(16)
                .fillColor(this.feedbackStatus === 1 ? '#10C8A7' : '#999999') // 选中时变绿

              Text('已解决')
                .fontSize(14)
                .fontColor(this.feedbackStatus === 1 ? '#10C8A7' : '#666666')
            }
            .layoutWeight(1)
            .height(44)
            .backgroundColor('#F7F7F7')
            .borderRadius(8)
            .justifyContent(FlexAlign.Center)
            .onClick(() => {
              this.feedbackStatus = 1;
              promptAction.showToast({ message: '感谢您的反馈，很高兴能帮到您' });
            })

            // “未解决”按钮
            Row({ space: 8 }) {
              Image($r('app.media.budianzan')) // 替换为踩/大拇指向下图标
                .width(16)
                .height(16)
                .fillColor(this.feedbackStatus === 2 ? '#FF4D4F' : '#999999') // 选中时变红

              Text('未解决')
                .fontSize(14)
                .fontColor(this.feedbackStatus === 2 ? '#FF4D4F' : '#666666')
            }
            .layoutWeight(1)
            .height(44)
            .backgroundColor('#F7F7F7')
            .borderRadius(8)
            .justifyContent(FlexAlign.Center)
            .onClick(() => {
              this.feedbackStatus = 2;
              promptAction.showToast({ message: '抱歉未能解决您的问题，我们将持续优化' });
            })
          }
          .width('100%')
        }
        .padding({ left: 20, right: 20, top: 10, bottom: 20 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      // === 3. 底部吸底提示区 ===
      Row() {
        Text('仍未解决？ 试试 ')
          .fontSize(14)
          .fontColor('#999999')

        Text('在线咨询')
          .fontSize(14)
          .fontColor('#10C8A7') // 品牌绿
          .onClick(() => {
             router.pushUrl({ url: 'pages/message/ChatPage' })
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .padding({ top: 16, bottom: 34 }) // bottom 34 给底部横条(Home Indicator)留出安全距离
      .backgroundColor(Color.White)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}