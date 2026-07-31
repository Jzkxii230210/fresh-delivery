import router from '@ohos.router';

@Entry
@Component
struct MessageDetailPage {
  // 页面类型: 'order' | 'system' | 'activity'
  @State notificationType: string = 'order';
  @State pageTitle: string = '订单通知';

  aboutToAppear() {
    // 接收上级页面传参以动态切换视图 (例如：router.pushUrl({ url: '...', params: { type: 'system' } }))
    const params = router.getParams() as Record<string, string>;
    if (params && params.type) {
      this.notificationType = params.type;
      if (this.notificationType === 'order') {
        this.pageTitle = '订单通知';
      } else if (this.notificationType === 'system') {
        this.pageTitle = '系统通知';
      } else if (this.notificationType === 'activity') {
        this.pageTitle = '活动通知';
      }
    }
  }

  build() {
    Column() {
      // === 1. 顶部标题栏 ===
      Row() {
        Image($r('app.media.back'))
          .width(20).height(20).margin({ right: 12 })
          .onClick(() => { router.back(); })

        Text(this.pageTitle)
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Row().width(20) // 占位平衡右侧
      }
      .width('100%')
      .height(50)
      .padding({ left: 16, right: 16 })
      .backgroundColor(Color.White)

      // === 2. 列表内容区 (根据通知类型动态渲染) ===
      Scroll() {
        Column() {
          if (this.notificationType === 'order') {
            // --- 视图A: 订单通知列表 ---
            this.OrderNotificationItem('2099-05-28 16:52', '订单已完成', '你的订单已配送完成，欢迎再次购买。', '2112476163000231',$r('app.media.more') ,true)
            this.OrderNotificationItem('2099-05-28 16:26', '配送员已取货', '你的订单已经开始配送，配送员：张三送，联系电话：13612345678，请耐心等候。', '2112476163000231', $r('app.media.more'),false)
            this.OrderNotificationItem('2099-05-28 16:24', '商品拣货完成', '你的商品已完成拣货，请等待配送。', '2112476163000231', $r('app.media.more') ,false)
            this.OrderNotificationItem('2099-05-28 16:10', '商家已接单', '你的订单已被商家接收，请等待拣货。', '2112476163000231', $r('app.media.more') ,false)

          } else if (this.notificationType === 'system') {
            // --- 视图B: 系统通知列表 ---
            this.SystemNotificationItem('04-26', '系统升级通知', '为了提供更好的服务，系统将于今晚进行例行维护升级。', false)
            this.SystemNotificationItem('9天前', '账号安全提醒', '您的账号近期在新的设备上登录，如非本人操作请及时修改密码。', false)
            this.SystemNotificationItem('昨天', '实名认证通过', '你提交的个人信息修改申请审核已通过。', false)
            this.SystemNotificationItem('2小时前', '新版本上线', '小默买菜 V2.1.0 已发布，快来体验全新流畅的购物交互吧！', true)

          } else {
            // --- 视图C: 活动通知列表 (带大图 Banner) ---
            this.ActivityNotificationItem(
              '2小时前',
              '端午优惠活动，食品类全场八折！',
              '端午大放“粽”，品尝鲜美粽子，弘扬传统文化！',
              $r('app.media.duanwu'),
              true
            )
            this.ActivityNotificationItem(
              '04-29',
              '主标题主标题，主标题主标题主标题！',
              '副标题副标题 *副标题副标题副标题！*',
              $r('app.media.shuiguo'),
              false
            )
          }
        }
        .width('100%')
        .padding({ top: 12, bottom: 30 })
      }
      .scrollBar(BarState.Off)
      .layoutWeight(1)
      .backgroundColor('#F8F8F8')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8F8F8')
  }

  // --- 局部复用组件：订单通知卡片 ---
  @Builder OrderNotificationItem(time: string, title: string, desc: string, orderNo: string, icon: Resource, hasRedDot: boolean) {
    Column() {
      // 时间戳
      Text(time)
        .fontSize(11)
        .fontColor('#999999')
        .margin({ bottom: 10, top: 4 })

      // 卡片主体
      Column() {
        Row() {
          Text(title)
            .fontSize(15)
            .fontWeight(FontWeight.Bold)
            .fontColor('#333333')

          if (hasRedDot) {
            Circle({ width: 6, height: 6 }).fill('#FF4D4F').margin({ left: 4 })
          }
        }
        .width('100%')
        .margin({ bottom: 8 })

        Text(desc)
          .fontSize(13)
          .fontColor('#666666')
          .lineHeight(18)
          .margin({ bottom: 12 })

        Divider().color('#F0F0F0').strokeWidth(0.5).margin({ bottom: 10 })

        // 底部订单号行
        Row() {
          Text(`订单: ${orderNo}`)
            .fontSize(12)
            .fontColor('#999999')
          Blank()
          Image(icon).width(12).height(12)
        }
        .width('100%')
      }
      .width('92%')
      .backgroundColor(Color.White)
      .borderRadius(12)
      .padding(14)
      .shadow({ radius: 4, color: 'rgba(0,0,0,0.03)', offsetY: 2 })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Center)
    .margin({ bottom: 8 })
  }

  // --- 局部复用组件：系统通知卡片 ---
  @Builder SystemNotificationItem(time: string, title: string, desc: string, hasRedDot: boolean) {
    Column() {
      Text(time)
        .fontSize(11)
        .fontColor('#999999')
        .margin({ bottom: 10, top: 4 })

      Column() {
        Row() {
          // 左侧系统蓝底铃铛图标
          Image($r('app.media.notice'))
            .width(36).height(36)
            .borderRadius(18)
            .margin({ right: 12 })

          Column() {
            Row() {
              Text(title)
                .fontSize(15)
                .fontWeight(FontWeight.Bold)
                .fontColor('#333333')
              if (hasRedDot) {
                Circle({ width: 6, height: 6 }).fill('#FF4D4F').margin({ left: 4 })
              }
            }
            .width('100%')
            .margin({ bottom: 4 })

            Text(desc)
              .fontSize(13)
              .fontColor('#666666')
              .maxLines(2)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
          }
          .layoutWeight(1)
          .alignItems(HorizontalAlign.Start)
        }
        .width('100%')
      }
      .width('92%')
      .backgroundColor(Color.White)
      .borderRadius(12)
      .padding(14)
      .shadow({ radius: 4, color: 'rgba(0,0,0,0.03)', offsetY: 2 })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Center)
    .margin({ bottom: 8 })
  }

  // --- 局部复用组件：活动通知卡片 (含图文大图) ---
  @Builder ActivityNotificationItem(time: string, title: string, desc: string, bannerImage: Resource, hasRedDot: boolean) {
    Column() {
      Text(time)
        .fontSize(11)
        .fontColor('#999999')
        .margin({ bottom: 10, top: 4 })

      Column() {
        Row() {
          Text(title)
            .fontSize(15)
            .fontWeight(FontWeight.Bold)
            .fontColor('#333333')
          if (hasRedDot) {
            Circle({ width: 6, height: 6 }).fill('#FF4D4F').margin({ left: 4 })
          }
        }
        .width('100%')
        .margin({ bottom: 6 })

        Text(desc)
          .fontSize(12)
          .fontColor('#666666')
          .width('100%')
          .margin({ bottom: 10 })

        // 活动图片 Banner
        Image(bannerImage)
          .width('100%')
          .height(150)
          .borderRadius(8)
          .objectFit(ImageFit.Cover)
          .onClick(() => {
            router.pushUrl({ url: 'pages/message/ActivityDetailPage' });
          })
      }
      .width('92%')
      .backgroundColor(Color.White)
      .borderRadius(12)
      .padding(14)
      .shadow({ radius: 4, color: 'rgba(0,0,0,0.03)', offsetY: 2 })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Center)
    .margin({ bottom: 8 })
  }
}