import router from '@ohos.router';

@Entry
@Component
struct ProductDetailPage {
  // 模拟搭配购买数据
  private matchProducts: number[] = [1, 2, 3, 4];

  build() {
    // 根节点使用 Stack，把底部悬浮结算栏固定在最上层
    Stack({ alignContent: Alignment.Bottom }) {

      // === 主体滚动区域 ===
      Scroll() {
        Column() {
          // --- 1. 顶部大图与返回/分享按钮 ---
          Stack({ alignContent: Alignment.TopStart }) {
            Image($r('app.media.startIcon'))
              .width('100%')
              .height(300)
              .objectFit(ImageFit.Cover)
              .backgroundColor('#EEEEEE')

            // 顶部返回与分享
            Row() {
              Circle({ width: 32, height: 32 }).fill('rgba(0,0,0,0.3)')
              Image($r('app.media.startIcon')).width(16).height(16).position({ x: 8, y: 8 })
                .onClick(() => { router.back(); })

              Blank()

              Circle({ width: 32, height: 32 }).fill('rgba(0,0,0,0.3)')
              Image($r('app.media.startIcon')).width(16).height(16).position({ x: 312, y: 8 })
            }
            .width('100%')
            .padding({ left: 16, right: 16, top: 16 })
          }
          .width('100%')
          .height(300)

          // --- 2. 商品核心信息卡片 ---
          Column() {
            // 标题
            Text('水嫩豆腐 约500g/份')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor('#333333')
              .width('100%')
              .margin({ bottom: 6 })

            // 副标题
            Text('本地直供，水嫩新鲜')
              .fontSize(13)
              .fontColor('#999999')
              .width('100%')
              .margin({ bottom: 12 })

            // 价格与加入购物车同行
            Row() {
              Row() {
                Text('¥').fontSize(14).fontColor('#FF4D4F').fontWeight(FontWeight.Bold)
                Text('2.60').fontSize(24).fontColor('#FF4D4F').fontWeight(FontWeight.Bold).margin({ right: 4 })
                Text('/份').fontSize(12).fontColor('#FF4D4F').margin({ right: 10 })
                Text('¥3.90').fontSize(13).fontColor('#999999').decoration({ type: TextDecorationType.LineThrough })
              }

              Blank()

              Button('加入购物车')
                .width(110)
                .height(36)
                .backgroundColor('#10C8A7')
                .fontColor(Color.White)
                .fontSize(14)
                .borderRadius(18)
                .onClick(() => {
                  // TODO: 加入购物车逻辑
                })
            }
            .width('100%')
            .margin({ bottom: 16 })

            // 标签栏 (值得回购、包装完整等)
            Row({ space: 8 }) {
              this.TagItem('值得回购')
              this.TagItem('包装完整')
              this.TagItem('品质保障')
              this.TagItem('强烈推荐')
            }
            .width('100%')
          }
          .width('100%')
          .backgroundColor(Color.White)
          .padding(16)
          .margin({ bottom: 10 })

          // --- 3. 所属商家入口卡片 ---
          Row() {
            Image($r('app.media.startIcon')).width(24).height(24).borderRadius(4).margin({ right: 10 })
            Text('天虹商场-凤凰城店').fontSize(14).fontWeight(FontWeight.Medium).fontColor('#333333')
            Blank()
            Image($r('app.media.startIcon')).width(14).height(14) // 右侧箭头
          }
          .width('100%')
          .height(50)
          .backgroundColor(Color.White)
          .padding({ left: 16, right: 16 })
          .margin({ bottom: 10 })

          // --- 4. 规格参数卡片 ---
          Row() {
            this.ParamItem('产地', '本地')
            this.ParamItem('规格', '约500g')
            this.ParamItem('储存方式', '常温')
          }
          .width('100%')
          .backgroundColor(Color.White)
          .padding({ top: 16, bottom: 16 })
          .margin({ bottom: 10 })

          // --- 5. 商品评价入口卡片 ---
          Column() {
            Row() {
              Text('商品评价 (534)').fontSize(15).fontWeight(FontWeight.Bold).fontColor('#333333')
              Blank()
              Text('好评 97.3%').fontSize(13).fontColor('#FF4D4F').margin({ right: 4 })
              Image($r('app.media.startIcon')).width(14).height(14)
            }
            .width('100%')
            .margin({ bottom: 12 })

            Row({ space: 8 }) {
              this.TagItem('值得回购')
              this.TagItem('包装完整')
              this.TagItem('品质保障')
            }
            .width('100%')
          }
          .width('100%')
          .backgroundColor(Color.White)
          .padding(16)
          .margin({ bottom: 10 })

          // --- 6. 搭配购买模块 ---
          Column() {
            Text('搭配购买')
              .fontSize(15)
              .fontWeight(FontWeight.Bold)
              .fontColor('#333333')
              .width('100%')
              .padding({ left: 16, top: 16, bottom: 12 })

            List({ space: 10 }) {
              ListItem().margin({ left: 16 })
              ForEach(this.matchProducts, () => {
                ListItem() {
                  this.MatchProductCard()
                }
              })
              ListItem().margin({ right: 6 })
            }
            .listDirection(Axis.Horizontal)
            .scrollBar(BarState.Off)
            .width('100%')
            .height(180)
          }
          .width('100%')
          .backgroundColor(Color.White)
          .margin({ bottom: 10 })

          // --- 7. 价格说明模块 ---
          Column() {
            Text('价格说明')
              .fontSize(15)
              .fontWeight(FontWeight.Bold)
              .fontColor('#333333')
              .width('100%')
              .margin({ bottom: 12 })

            Text('划线价格')
              .fontSize(13)
              .fontWeight(FontWeight.Medium)
              .fontColor('#333333')
              .width('100%')
              .margin({ bottom: 4 })
            Text('划线价格系参考价，可能是商品（含服务）的线下实体门店销售价、网络零售指导价等，仅供参考。')
              .fontSize(11)
              .fontColor('#666666')
              .lineHeight(16)
              .margin({ bottom: 12 })

            Text('未划线价格')
              .fontSize(13)
              .fontWeight(FontWeight.Medium)
              .fontColor('#333333')
              .width('100%')
              .margin({ bottom: 4 })
            Text('未划线价格系商品在小默买菜平台的实时标价，不含餐具费、包装费等，最终以订单结算页展示的实际成交价为准。')
              .fontSize(11)
              .fontColor('#666666')
              .lineHeight(16)
          }
          .width('100%')
          .backgroundColor(Color.White)
          .padding(16)
          .margin({ bottom: 80 }) // 底部留白防止被结算栏遮挡
        }
      }
      .scrollBar(BarState.Off)
      .width('100%')
      .height('100%')
      .backgroundColor('#F8F8F8')

      // === 8. 底部悬浮结算栏 ===
      Row() {
        // 购物车图标 (带徽标)
        Stack({ alignContent: Alignment.TopEnd }) {
          Image($r('app.media.startIcon')).width(28).height(28).margin({ top: 6 })
          Text('1')
            .fontSize(10)
            .fontColor(Color.White)
            .backgroundColor('#FF4D4F')
            .padding({ left: 4, right: 4, top: 1, bottom: 1 })
            .borderRadius(8)
        }
        .margin({ right: 12 })

        Text('¥21')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')

        Blank()

        Button('去结算')
          .width(110)
          .height(38)
          .backgroundColor('#10C8A7')
          .fontColor(Color.White)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .borderRadius(19)
          .onClick(() => {
            // 跳转结算确认单
            router.pushUrl({ url: 'pages/cart/ConfirmOrderPage' });
          })
      }
      .width('100%')
      .height(60)
      .backgroundColor(Color.White)
      .padding({ left: 16, right: 16 })
      .shadow({ radius: 8, color: 'rgba(0,0,0,0.05)', offsetY: -2 })
    }
    .width('100%')
    .height('100%')
  }

  // --- 局部复用组件 ---

  @Builder TagItem(text: string) {
    Text(text)
      .fontSize(11)
      .fontColor('#FF8C00')
      .backgroundColor('#FFF8EE')
      .padding({ left: 8, right: 8, top: 4, bottom: 4 })
      .borderRadius(4)
  }

  @Builder ParamItem(label: string, value: string) {
    Column() {
      Text(label).fontSize(12).fontColor('#999999').margin({ bottom: 4 })
      Text(value).fontSize(13).fontColor('#333333').fontWeight(FontWeight.Medium)
    }
    .layoutWeight(1)
    .alignItems(HorizontalAlign.Center)
  }

  @Builder MatchProductCard() {
    Column() {
      Image($r('app.media.startIcon')).width(100).height(100).borderRadius(6).margin({ bottom: 6 })
      Text('花菜 约500g').fontSize(12).fontColor('#333333').maxLines(1).textOverflow({ overflow: TextOverflow.Ellipsis }).margin({ bottom: 4 })

      Row() {
        Text('¥7.99').fontSize(14).fontColor('#FF4D4F').fontWeight(FontWeight.Bold)
        Blank()
        Stack({ alignContent: Alignment.Center }) {
          Circle({ width: 20, height: 20 }).fill('#10C8A7')
          Text('+').fontSize(14).fontColor(Color.White).margin({ bottom: 2 })
        }
      }
      .width('100%')
    }
    .width(100)
    .alignItems(HorizontalAlign.Start)
  }
}