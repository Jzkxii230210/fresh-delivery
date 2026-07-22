@Entry
@Component
export struct ProfilePage {
  build() {
    // === 整体页面滚动容器 ===
    Scroll() {
      Column() {
        // --- 头部：渐变背景 + 个人信息区 ---
        Stack({ alignContent: Alignment.Top }) {
          // 背景渐变
          Column()
            .width('100%')
            .height(180)
            .linearGradient({
              direction: GradientDirection.Bottom,
              colors: [['#BCE6FF', 0.0], ['#F5F8FA', 1.0]]
            })

          Column() {
            // 右上角图标栏 (消息通知 + 设置)
            Row() {
              Blank()

              // 消息通知图标带红点
              Stack({ alignContent: Alignment.TopEnd }) {
                Image($r('app.media.startIcon')).width(22).height(22).margin({ top: 4, right: 4 })
                Circle({ width: 8, height: 8 }).fill('#FF4D4F')
              }
              .margin({ right: 16 })

              // 设置图标
              Image($r('app.media.startIcon')).width(22).height(22)
            }
            .width('100%')
            .padding({ left: 16, right: 16, top: 12, bottom: 12 })

            // 头像、昵称与编辑资料
            Row() {
              Image($r('app.media.startIcon'))
                .width(64)
                .height(64)
                .borderRadius(32)
                .margin({ right: 12 })

              Column() {
                Text('张小乙是吃货')
                  .fontSize(18)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#333333')
                  .margin({ bottom: 4 })

                Text('ID：220520012')
                  .fontSize(12)
                  .fontColor('#666666')
              }
              .alignItems(HorizontalAlign.Start)
              .layoutWeight(1)

              // 编辑资料入口
              Row() {
                Text('编辑资料').fontSize(12).fontColor('#666666').margin({ right: 2 })
                Image($r('app.media.startIcon')).width(12).height(12)
              }
            }
            .width('100%')
            .padding({ left: 16, right: 16, top: 8 })
          }
        }
        .width('100%')

        // --- 2. 资产卡片 (我的钱包、红包、优惠券、积分) ---
        Row() {
          this.AssetItem('我的钱包', '', true)
          this.AssetItem('10', '红包', false)
          this.AssetItem('5', '优惠券', false)
          this.AssetItem('100', '积分', false)
        }
        .width('92%')
        .backgroundColor(Color.White)
        .borderRadius(12)
        .padding({ top: 16, bottom: 16 })
        .margin({ top: -15, bottom: 12 })
        .shadow({ radius: 4, color: 'rgba(0,0,0,0.03)', offsetY: 2 })

        // --- 3. 常用功能卡片 (两行四列网格) ---
        Column() {
          Text('常用功能')
            .fontSize(15)
            .fontWeight(FontWeight.Bold)
            .fontColor('#333333')
            .width('100%')
            .margin({ bottom: 16 })

          Grid() {
            GridItem() { this.FunctionItem('浏览足迹') }
            GridItem() { this.FunctionItem('我的关注') }
            GridItem() { this.FunctionItem('我的评价') }
            GridItem() { this.FunctionItem('收货地址') }
            GridItem() { this.FunctionItem('购物车') }
            GridItem() { this.FunctionItem('发票助手') }
            GridItem() { this.FunctionItem('售后退款') }
            GridItem() { this.FunctionItem('帮助与客服') }
          }
          .columnsTemplate('1fr 1fr 1fr 1fr')
          .rowsTemplate('1fr 1fr')
          .rowsGap(16)
          .height(150)
        }
        .width('92%')
        .backgroundColor(Color.White)
        .borderRadius(12)
        .padding(16)
        .margin({ bottom: 12 })
        .shadow({ radius: 4, color: 'rgba(0,0,0,0.03)', offsetY: 2 })

        // --- 4. 更多推荐卡片 (签到、领券、商家入驻等) ---
        Column() {
          Text('更多推荐')
            .fontSize(15)
            .fontWeight(FontWeight.Bold)
            .fontColor('#333333')
            .width('100%')
            .margin({ bottom: 16 })

          Row() {
            this.RecommendItem('签到领积分', true)
            this.RecommendItem('领券中心', true)
            this.RecommendItem('商家入驻', false)
            this.RecommendItem('配送商合作', false)
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceAround)
        }
        .width('92%')
        .backgroundColor(Color.White)
        .borderRadius(12)
        .padding(16)
        .margin({ bottom: 16 })
      }
    }
    .scrollBar(BarState.Off)
    .width('100%')
    .height('100%')
    .backgroundColor('#F8F8F8')
  }

  // --- 局部复用组件 ---

  @Builder AssetItem(topText: string, bottomText: string, isIcon: boolean) {
    Column() {
      if (isIcon) {
        Image($r('app.media.startIcon')).width(24).height(24).margin({ bottom: 6 })
        Text(topText).fontSize(12).fontColor('#333333')
      } else {
        Text(topText).fontSize(18).fontWeight(FontWeight.Bold).fontColor('#FF4D4F').margin({ bottom: 4 })
        Text(bottomText).fontSize(12).fontColor('#666666')
      }
    }
    .layoutWeight(1)
    .alignItems(HorizontalAlign.Center)
  }

  @Builder FunctionItem(title: string) {
    Column() {
      Image($r('app.media.startIcon')).width(26).height(26).margin({ bottom: 8 })
      Text(title).fontSize(12).fontColor('#333333')
    }
    .width('100%')
    .alignItems(HorizontalAlign.Center)
  }

  @Builder RecommendItem(title: string, hasTag: boolean) {
    Column() {
      Stack({ alignContent: Alignment.TopStart }) {
        Image($r('app.media.startIcon'))
          .width(36)
          .height(36)
          .margin({ top: 4, left: 4 })

        // 策划中标签
        if (hasTag) {
          Text('策划中')
            .fontSize(8)
            .fontColor(Color.White)
            .backgroundColor('#FF8C00')
            .padding({ left: 3, right: 3, top: 1, bottom: 1 })
            .borderRadius(2)
        }
      }
      .width(44)
      .height(40)
      .margin({ bottom: 4 })

      Text(title)
        .fontSize(12)
        .fontColor('#333333')
    }
    .alignItems(HorizontalAlign.Center)
  }
}
