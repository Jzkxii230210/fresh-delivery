@Component
export struct MineUnloginView {
  build() {
    Scroll() {
      Column() {
        // --- 1. 顶部操作栏 (客服、设置图标) ---
        Row() {
          Blank() // 撑开左侧空间
          Image($r('app.media.startIcon')) // 使用 startIcon 占位客服
            .width(24).height(24).margin({ right: 16 })
          Image($r('app.media.startIcon')) // 使用 startIcon 占位设置
            .width(24).height(24)
        }
        .width('100%')
        .padding({ left: 20, right: 20, top: 20 })
        .height(60)

        // --- 2. 快捷登录引导区 ---
        Column() {
          Text('登录小默买菜，解锁更多功能')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#333333')
            .margin({ bottom: 20 })

          // 第三方登录图标组 (统一使用 startIcon)
          Row({ space: 24 }) {
            Image($r('app.media.startIcon')).width(48).height(48).borderRadius(24)
            Image($r('app.media.startIcon')).width(48).height(48).borderRadius(24)
            Image($r('app.media.startIcon')).width(48).height(48).borderRadius(24)
            Image($r('app.media.startIcon')).width(48).height(48).borderRadius(24)
          }
          .justifyContent(FlexAlign.Center)
          .width('100%')
        }
        .margin({ top: 20, bottom: 30 })

        // --- 3. 我的钱包卡片 ---
        Row() {
          this.WalletItem('我的钱包', $r('app.media.startIcon'))
          this.WalletItem('红包', null, '-')
          this.WalletItem('优惠券', null, '-')
          this.WalletItem('积分', null, '-')
        }
        .width('92%')
        .backgroundColor(Color.White)
        .borderRadius(12)
        .padding({ top: 20, bottom: 20 })
        .margin({ bottom: 16 })
        .shadow({ radius: 8, color: 'rgba(0,0,0,0.03)', offsetY: 4 })

        // --- 4. 常用功能卡片 (使用 Grid 布局) ---
        Column() {
          Text('常用功能')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .width('100%')
            .margin({ bottom: 16 })

          Grid() {
            this.GridMenuItem('浏览足迹')
            this.GridMenuItem('我的关注')
            this.GridMenuItem('我的评价')
            this.GridMenuItem('收货地址')
            this.GridMenuItem('购物车')
            this.GridMenuItem('发票助手')
            this.GridMenuItem('售后退款')
            this.GridMenuItem('帮助与客服')
          }
          .columnsTemplate('1fr 1fr 1fr 1fr') // 4列
          .rowsGap(20)
          .height(140) // 设定两行的高度
        }
        .width('92%')
        .backgroundColor(Color.White)
        .borderRadius(12)
        .padding(16)
        .margin({ bottom: 16 })
        .shadow({ radius: 8, color: 'rgba(0,0,0,0.03)', offsetY: 4 })

        // --- 5. 更多推荐卡片 ---
        Column() {
          Text('更多推荐')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .width('100%')
            .margin({ bottom: 16 })

          Grid() {
            this.GridMenuItem('签到领积分')
            this.GridMenuItem('领券中心')
            this.GridMenuItem('商家入驻')
            this.GridMenuItem('配送商合作')
          }
          .columnsTemplate('1fr 1fr 1fr 1fr')
          .height(60) // 设定一行的高度
        }
        .width('92%')
        .backgroundColor(Color.White)
        .borderRadius(12)
        .padding(16)
        .margin({ bottom: 30 })
        .shadow({ radius: 8, color: 'rgba(0,0,0,0.03)', offsetY: 4 })

      }
      .width('100%')
    }
    .scrollBar(BarState.Off)
    .width('100%')
    .height('100%')
    // 全局渐变背景，从浅蓝过渡到灰色底
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [['#D4F0FF', 0.0], ['#F8F8F8', 0.25], ['#F8F8F8', 1.0]]
    })
  }

  // --- 局部复用组件 (Builder) 简化代码 ---

  @Builder WalletItem(title: string, icon: Resource | null, value?: string) {
    Column() {
      if (icon) {
        Image(icon).width(28).height(28).margin({ bottom: 8 })
      } else if (value) {
        Text(value).fontSize(20).fontWeight(FontWeight.Bold).fontColor('#FF4D4F').margin({ bottom: 8 })
      }
      Text(title).fontSize(12).fontColor('#666666')
    }
    .layoutWeight(1) // 等分 Row 空间
  }

  @Builder GridMenuItem(title: string) {
    GridItem() {
      Column() {
        // 统一使用 startIcon 占位
        Image($r('app.media.startIcon'))
          .width(32)
          .height(32)
          .margin({ bottom: 8 })
          .borderRadius(16) // 添加圆角使其更好看
        Text(title).fontSize(12).fontColor('#333333')
      }
    }
  }
}