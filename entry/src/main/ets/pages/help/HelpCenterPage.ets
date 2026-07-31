import router from '@ohos.router';

@Entry
@Component
export struct HelpCenterPage {
  // 热门问题数据源
  private hotQuestions: string[] = [
    '优惠券无法使用？',
    '取消订单后货款怎么返还？',
    '刚下单发现信息填错了怎么办？',
    '订单能不能自提？',
    '账号密码怎么修改？',
    '如何更换绑定手机号？',
    '如何催单？',
    '商品变质如何处理？'
  ];

  build() {
    Column() {
      // === 1. 顶部导航栏 ===
      Row() {
        Image($r('app.media.back')) // 请替换为真实的返回小箭头
          .width(20)
          .height(20)
          .fillColor('#333333')
          .onClick(() => {
            router.back();
          })
        Text('帮助与客服')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#333333')
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
        Blank().width(20) // 右侧对称占位，保证标题绝对居中
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .backgroundColor(Color.White)

      // === 2. 页面主滚动区 ===
      Scroll() {
        Column() {
          // --- 搜索问题框 ---
          Row() {
            Image($r('app.media.search'))
              .width(16)
              .height(16)
              .margin({ right: 8 })
              .fillColor('#999999')
            Text('输入问题关键词')
              .fontSize(14)
              .fontColor('#999999')
          }
          .width('94%')
          .height(40)
          .backgroundColor(Color.White)
          .borderRadius(20)
          .padding({ left: 16, right: 16 })
          .margin({ top: 12, bottom: 12 })
          .onClick(() => {
            // 跳转到问题搜索页面
            router.pushUrl({ url: 'pages/mine/ProblemSearchPage' })
          })

          // --- 自助服务卡片 ---
          Column() {
            Text('自助服务')
              .fontSize(15)
              .fontWeight(FontWeight.Bold)
              .fontColor('#333333')
              .width('100%')
              .padding({ left: 16, top: 16, bottom: 16 })

            Row() {
              this.ToolItem('意见反馈', '#78C4C4', 'pages/mine/FeedbackPage',$r('app.media.yijianfankui')) // 湖蓝
              this.ToolItem('发票中心', '#EAA57E', 'pages/mine/InvoiceHelperPage',$r('app.media.fapiaozhongxin')) // 橘棕
              this.ToolItem('售后退款', '#F6C862', 'pages/order/RefundApplyPage',$r('app.media.shouhuotuikuan')) // 亮黄
              this.ToolItem('账号注销', '#F46875', 'pages/mine/CloseAccountPage',$r('app.media.zhanghaozhuxiao')) // 桃红
            }
            .width('100%')
            .padding({ bottom: 16 })
            .justifyContent(FlexAlign.SpaceAround)
          }
          .width('94%')
          .backgroundColor(Color.White)
          .borderRadius(12)
          .margin({ bottom: 12 })

          // --- 热门问题卡片 ---
          Column() {
            Text('热门问题')
              .fontSize(15)
              .fontWeight(FontWeight.Bold)
              .fontColor('#333333')
              .width('100%')
              .padding({ left: 16, top: 16, bottom: 8 })

            // 循环渲染问题列表
            ForEach(this.hotQuestions, (item: string) => {
              this.QuestionItem(item)
            })
          }
          .width('94%')
          .backgroundColor(Color.White)
          .borderRadius(12)
          .margin({ bottom: 20 })
        }
        .width('100%')
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      // === 3. 底部吸底操作区 ===
      Column() {
        Button('在线咨询', { type: ButtonType.Normal })
          .width('92%')
          .height(44)
          .backgroundColor('#10C8A7') // 品牌主题绿
          .fontColor(Color.White)
          .fontSize(16)
          .borderRadius(8)
          .onClick(() => {
            router.pushUrl({ url: 'pages/message/ChatPage' })
          })
      }
      .width('100%')
      .padding({ top: 12, bottom: 34 }) // 底部 Home 键安全距离
      .backgroundColor('#F5F5F5')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }

  // ==================== 局部自定义组件 ====================

  /**
   * 快捷自助服务入口组件
   */
  @Builder
  ToolItem(title: string, bgColor: string, targetUrl: string, icon: Resource) {
    Column() {
      Stack() {
        Circle({ width: 44, height: 44 }).fill(bgColor)
        Image(icon)
          .width(22)
          .height(22)
          .fillColor(Color.White)
      }
      .margin({ bottom: 8 })

      Text(title)
        .fontSize(12)
        .fontColor('#333333')
    }
    .onClick(() => {
      // 业务跳转逻辑
      if (targetUrl) {
        router.pushUrl({ url: targetUrl });
      }
    })
  }

  /**
   * 常见问题单行列表组件
   */
  @Builder
  QuestionItem(title: string) {
    Column() {
      Row() {
        Text(title)
          .fontSize(14)
          .fontColor('#333333')
          .layoutWeight(1)

        Image($r('app.media.more'))
          .width(12)
          .height(12)
          .opacity(0.3)
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 14, bottom: 14 })

      // 底部分割线
      Divider()
        .color('#F2F2F2')
        .strokeWidth(1)
        .padding({ left: 16, right: 16 })
    }
    .onClick(() => {
      // 点击跳转到问题详情
      router.pushUrl({ url: 'pages/mine/ProblemDetailPage' })
    })
  }
}