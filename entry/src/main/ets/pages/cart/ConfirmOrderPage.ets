import router from '@ohos.router';

/**
 * 确认订单 / 结算单页面
 */
@Entry
@Component
export struct ConfirmOrderPage {
  build() {
    Stack({ alignContent: Alignment.Top }) {

      // === 1. 底层：顶部绿色延伸背景 ===
      Column()
        .width('100%')
        .height(200)
        .backgroundColor('#10C8A7') // 品牌主题绿

      // === 2. 顶层：页面核心内容 ===
      Column() {
        // --- 自定义导航栏 ---
        Row() {
          Image($r('app.media.back')) // 白色返回箭头
            .width(20)
            .height(20)
            .fillColor(Color.White)
            .onClick(() => {
              router.back();
            })

          Text('确认订单')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(Color.White)
            .layoutWeight(1)
            .textAlign(TextAlign.Center)

          Blank().width(20) // 对称占位，保证标题居中
        }
        .width('100%')
        // 【修复关键】：去掉之前固定的 height(56)，使用 top 和 bottom 的 padding 自然撑开，防止文字溢出到滚动区
        .padding({ left: 16, right: 16, top: 44, bottom: 14 })

        // --- 可滚动的主体内容区 ---
        Scroll() {
          Column() {

            // 模块 A：收货地址卡片
            Column() {
              // 地址栏
              Row() {
                Text('公司')
                  .fontSize(10)
                  .fontColor(Color.White)
                  .backgroundColor('#10C8A7')
                  .padding({ left: 4, right: 4, top: 2, bottom: 2 })
                  .borderRadius(4)
                  .margin({ right: 8 })

                Text('龙岭十二区38栋')
                  .fontSize(18)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#333333')
                  .layoutWeight(1)

                Image($r('app.media.more')) // 右侧箭头
                  .width(14)
                  .height(14)
                  .opacity(0.3)
              }
              .width('100%')
              .alignItems(VerticalAlign.Center)
              .margin({ bottom: 8 })

              // 联系人信息
              Text('张小乙  13612345678')
                .fontSize(14)
                .fontColor('#999999')
                .width('100%')
                .margin({ bottom: 16 })

              Divider().color('#F5F5F5').strokeWidth(1).margin({ bottom: 16 })

              // 送达时间
              Row() {
                Text('送达时间')
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#333333')

                Blank()

                Text('立即送达 14:20-15:20')
                  .fontSize(14)
                  .fontColor('#007DFF') // 蓝色强调
                  .margin({ right: 4 })

                Image($r('app.media.more')) // 右侧箭头(蓝色)
                  .width(12)
                  .height(12)
                  .fillColor('#007DFF')
              }
              .width('100%')
            }
            .width('94%')
            .backgroundColor(Color.White)
            .borderRadius(12)
            .padding(16)
            .margin({ top: 12, bottom: 12 })

            // 模块 B：商品与费用明细卡片
            Column() {
              // 门店信息
              Row() {
                Text('天虹商场-凤凰城店')
                  .fontSize(14)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#333333')

                Blank()

                Text('达达快送')
                  .fontSize(10)
                  .fontColor('#007DFF')
                  .border({ width: 1, color: '#007DFF', radius: 2 })
                  .padding({ left: 4, right: 4, top: 2, bottom: 2 })
              }
              .width('100%')
              .margin({ bottom: 16 })

              // 商品列表
              this.ProductItem($r('app.media.wuchangdami'), '东北五常大米 10kg', '68.90', '1') // 替换为大米图
              this.ProductItem($r('app.media.jidan'), '本地鸡蛋8枚 约500g/份', '6.50', '1') // 替换为鸡蛋图

              // 件数重量汇总
              Row() {
                Text('共 2 件 / 20.5kg')
                  .fontSize(12)
                  .fontColor('#999999')
              }
              .width('100%')
              .height(28)
              .backgroundColor('#F9F9F9')
              .borderRadius(14)
              .justifyContent(FlexAlign.Center)
              .margin({ bottom: 24 })

              // 费用明细
              this.CostItem('运费', '￥4')
              this.CostItem('时段运费', '￥2')
              this.CostItem('包装费', '￥1.2')
              this.CostItem('满50元享特惠', '-￥3', true)
              this.CostItem('红包', '-￥5', true, true)

              Divider().color('#F5F5F5').strokeWidth(1).margin({ top: 8, bottom: 16 })

              // 小计
              Row() {
                Blank()
                Text('共节省')
                  .fontSize(12)
                  .fontColor('#999999')
                Text('￥8')
                  .fontSize(12)
                  .fontColor('#FF4D4F')
                  .margin({ right: 12 })

                Text('应付金额：')
                  .fontSize(14)
                  .fontColor('#333333')
                Text('￥74.6')
                  .fontSize(20)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#333333')
              }
              .width('100%')
            }
            .width('94%')
            .backgroundColor(Color.White)
            .borderRadius(12)
            .padding(16)
            .margin({ bottom: 12 })

            // 模块 C：备注、发票等附加选项卡片
            Column() {
              this.OptionItem('备注', '未填写', true)
              this.OptionItem('发票', '未选择', true)
              this.OptionItem('如遇缺货', '缺货时电话与我沟通', false) // 最后一行不展示分割线
            }
            .width('94%')
            .backgroundColor(Color.White)
            .borderRadius(12)
            .padding({ left: 16, right: 16 })
            .margin({ bottom: 24 })

          }
          .width('100%')
        }
        .layoutWeight(1) // 占满中间剩余空间
        .scrollBar(BarState.Off)

        // --- 底部吸底操作栏 ---
        Row() {
          Row() {
            Text('共节省')
              .fontSize(12)
              .fontColor('#999999')
            Text('￥8')
              .fontSize(12)
              .fontColor('#FF4D4F')
              .margin({ right: 12 })
            Text('￥74.6')
              .fontSize(22)
              .fontWeight(FontWeight.Bold)
              .fontColor('#333333')
          }
          .layoutWeight(1)
          .padding({ left: 16 })

          Button('提交订单')
            .width(110)
            .height(44)
            .backgroundColor('#10C8A7')
            .fontColor(Color.White)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .borderRadius(22)
            .margin({ right: 16 })
            .onClick(() => {
              // 跳转到支付页面
              router.pushUrl({ url: 'pages/order/CheckoutPage' });
            })
        }
        .width('100%')
        .height(68)
        .backgroundColor(Color.White)
        .shadow({ radius: 8, color: 'rgba(0,0,0,0.05)', offsetY: -2 })
        .padding({ bottom: 24 }) // 给底部 Home 键横条留出安全距离
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }

  // ================= 局部自定义组件 =================

  /**
   * 商品列表项
   */
  @Builder ProductItem(imageRes: Resource, title: string, price: string, qty: string) {
    Row() {
      Image(imageRes)
        .width(60)
        .height(60)
        .borderRadius(4)
        .backgroundColor('#F9F9F9')
        .margin({ right: 12 })

      Column() {
        Text(title)
          .fontSize(14)
          .fontColor('#333333')
          .fontWeight(FontWeight.Medium)
          .margin({ bottom: 16 })
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Row() {
          Row() {
            Text('￥' + price)
              .fontSize(14)
              .fontColor('#333333')
            Text('  x' + qty)
              .fontSize(12)
              .fontColor('#999999')
          }

          Blank()

          Text('￥' + price)
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .fontColor('#333333')
        }
        .width('100%')
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .margin({ bottom: 16 })
  }

  /**
   * 费用明细列表项
   */
  @Builder CostItem(title: string, value: string, isRed: boolean = false, showArrow: boolean = false) {
    Row() {
      Text(title)
        .fontSize(14)
        .fontColor('#666666')

      Blank()

      Text(value)
        .fontSize(14)
        .fontColor(isRed ? '#FF4D4F' : '#333333')

      if (showArrow) {
        Image($r('app.media.more')) // 请替换为灰色右侧箭头
          .width(12)
          .height(12)
          .opacity(0.3)
          .margin({ left: 4 })
      }
    }
    .width('100%')
    .margin({ bottom: 12 })
  }

  /**
   * 备注与发票选项卡列表项 (新增)
   */
  @Builder OptionItem(title: string, value: string, showDivider: boolean = true) {
    Column() {
      Row() {
        Text(title)
          .fontSize(15)
          .fontColor('#333333')

        Blank()

        Text(value)
          .fontSize(14)
          .fontColor('#999999')
          .margin({ right: 4 })

        Image($r('app.media.more')) // 请替换为灰色右侧箭头
          .width(14)
          .height(14)
          .opacity(0.3)
      }
      .width('100%')
      .padding({ top: 16, bottom: 16 })
      .onClick(() => {
        // 对应项的点击事件，例如跳转到发票选择页
      })

      if (showDivider) {
        Divider().color('#F5F5F5').strokeWidth(1)
      }
    }
    .width('100%')
  }
}