@Component
export struct CartBottomSheet {
  // 控制弹层显隐的回调
  onClose: () => void = () => {};
  // 模拟购物车商品列表数据
  private cartItems: number[] = [1, 2, 3];

  build() {
    // 根节点使用 Stack，实现半透明灰色遮罩层
    Stack({ alignContent: Alignment.Bottom }) {

      // 1. 背景半透明遮罩 (点击可关闭弹层)
      Row()
        .width('100%')
        .height('100%')
        .backgroundColor('rgba(0, 0, 0, 0.5)')
        .onClick(() => {
          this.onClose();
        })

      // 2. 底部升起的白色内容面板
      Column() {
        // --- 头部：全选与清空购物车 ---
        Row() {
          Row({ space: 8 }) {
            // 全选勾选框占位
            Circle({ width: 18, height: 18 }).fill('#10C8A7')
            Text('全选 (已选3件, 共11.738kg)')
              .fontSize(13)
              .fontColor('#333333')
          }

          Blank()

          Text('清空购物车')
            .fontSize(12)
            .fontColor('#999999')
        }
        .width('100%')
        .padding({ left: 16, right: 16, top: 16, bottom: 12 })
        .border({ bottom: { width: 0.5, color: '#F0F0F0' } })

        // --- 中部：商品滚动列表 ---
        List({ space: 10 }) {
          ForEach(this.cartItems, (item: number) => {
            ListItem() {
              Row() {
                // 单个商品勾选框
                Circle({ width: 18, height: 18 }).fill('#10C8A7').margin({ right: 10 })

                // 商品缩略图
                Image($r('app.media.startIcon'))
                  .width(60)
                  .height(60)
                  .borderRadius(6)
                  .margin({ right: 10 })

                // 商品名称与价格
                Column() {
                  Text('水嫩豆腐 约500g/份')
                    .fontSize(14)
                    .fontColor('#333333')
                    .fontWeight(FontWeight.Medium)
                    .margin({ bottom: 8 })
                    .maxLines(1)
                    .textOverflow({ overflow: TextOverflow.Ellipsis })

                  Text('¥2.60')
                    .fontSize(16)
                    .fontColor('#FF4D4F')
                    .fontWeight(FontWeight.Bold)
                }
                .layoutWeight(1)
                .alignItems(HorizontalAlign.Start)

                // 步进器 (减、数量、加)
                Row() {
                  Text('-')
                    .fontSize(14)
                    .fontColor('#666666')
                    .width(24)
                    .height(24)
                    .textAlign(TextAlign.Center)
                    .border({ width: 0.5, color: '#E0E0E0' })
                    .borderRadius({ topLeft: 4, bottomLeft: 4 })

                  Text('1')
                    .fontSize(13)
                    .fontColor('#333333')
                    .width(32)
                    .height(24)
                    .textAlign(TextAlign.Center)
                    .border({ width: { top: 0.5, bottom: 0.5 }, color: '#E0E0E0' })

                  Text('+')
                    .fontSize(14)
                    .fontColor('#666666')
                    .width(24)
                    .height(24)
                    .textAlign(TextAlign.Center)
                    .border({ width: 0.5, color: '#E0E0E0' })
                    .borderRadius({ topRight: 4, bottomRight: 4 })
                }
              }
              .width('100%')
              .padding(12)
              .backgroundColor('#FAFAFA')
              .borderRadius(8)
            }
          })
        }
        .width('100%')
        .height(260) // 固定列表高度，防止撑满屏幕
        .scrollBar(BarState.Off)
        .padding({ left: 16, right: 16, top: 12, bottom: 12 })

        // --- 底部结算栏 ---
        Row() {
          // 购物车图标带红点徽标
          Stack({ alignContent: Alignment.TopEnd }) {
            Image($r('app.media.startIcon'))
              .width(32)
              .height(32)
              .margin({ top: 4, right: 4 })

            Text('3')
              .fontSize(10)
              .fontColor(Color.White)
              .backgroundColor('#FF4D4F')
              .padding({ left: 4, right: 4, top: 1, bottom: 1 })
              .borderRadius(8)
          }
          .margin({ right: 12 })

          // 总价与运费提示
          Column() {
            Text('¥ 81.49')
              .fontSize(18)
              .fontColor('#333333')
              .fontWeight(FontWeight.Bold)
              .margin({ bottom: 2 })

            Text('已免运费')
              .fontSize(10)
              .fontColor('#999999')
          }
          .alignItems(HorizontalAlign.Start)

          Blank()

          // 去结算按钮
          Button('去结算')
            .width(110)
            .height(40)
            .backgroundColor('#10C8A7')
            .fontColor(Color.White)
            .fontSize(15)
            .fontWeight(FontWeight.Medium)
            .borderRadius(20)
            .onClick(() => {
              // TODO: 跳转确认订单页
            })
        }
        .width('100%')
        .height(70)
        .backgroundColor(Color.White)
        .padding({ left: 16, right: 16 })
        .border({ top: { width: 0.5, color: '#F0F0F0' } })
      }
      .width('100%')
      .backgroundColor(Color.White)
      .borderRadius({ topLeft: 20, topRight: 20 }) // 顶部圆角，完美还原弹层质感
    }
    .width('100%')
    .height('100%')
  }
}