import router from '@ohos.router';

@Entry
@Component
export struct CartPage {
  // 核心状态：是否处于“管理”编辑模式
  @State isManaging: boolean = false;
  // 当前顶部 Tab 索引 (0: 全部, 1: 降价, 2: 常买)
  @State currentTab: number = 0;

  // 模拟购物车商品列表
  private cartItems: number[] = [1, 2, 3, 4, 5, 6];
  // 模拟猜你喜欢推荐商品
  private recommendProducts: number[] = [1, 2];

  build() {
    Stack({ alignContent: Alignment.Bottom }) {

      // === 主体滚动区域 ===
      Scroll() {
        Column() {
          // --- 1. 顶部标题栏与 Tab 切换 ---
          Column() {
            Row() {
              // 管理模式下显示返回箭头
              if (this.isManaging) {
                Image($r('app.media.startIcon'))
                  .width(20).height(20).margin({ right: 12 })
                  .onClick(() => { this.isManaging = false; })
              }

              Text('购物车')
                .fontSize(18)
                .fontWeight(FontWeight.Bold)
                .fontColor('#333333')

              if (!this.isManaging) {
                // 非管理模式下显示“碧桂园凤凰城”定位与“管理”字样
                Row() {
                  Image($r('app.media.startIcon')).width(14).height(14).margin({ right: 2 })
                  Text('碧桂园凤凰城').fontSize(12).fontColor('#666666')
                  Image($r('app.media.startIcon')).width(10).height(10).margin({ left: 2 })
                }
                .margin({ left: 12 })
                .padding({ left: 8, right: 8, top: 4, bottom: 4 })
                .backgroundColor('#F5F5F5')
                .borderRadius(12)

                Blank()

                Text('管理')
                  .fontSize(14)
                  .fontColor('#333333')
                  .onClick(() => { this.isManaging = true; })
              } else {
                Blank()
                Text('退出管理')
                  .fontSize(14)
                  .fontColor('#333333')
                  .onClick(() => { this.isManaging = false; })
              }
            }
            .width('100%')
            .height(50)
            .padding({ left: 16, right: 16 })

            // 顶部 Tab (全部 / 降价 / 常买)
            Row() {
              this.TabTitle('全部 (6)', 0)
              this.TabTitle('降价 (3)', 1)
              this.TabTitle('常买 (2)', 2)
            }
            .width('100%')
            .padding({ left: 16, right: 16 })
            .justifyContent(FlexAlign.Start)
          }
          .width('100%')
          .backgroundColor(Color.White)

          // --- 2. 商品列表卡片区 ---
          Column() {
            // 如果处于管理模式，显示所属店铺头部
            if (this.isManaging) {
              Row() {
                Circle({ width: 18, height: 18 }).fill('#10C8A7').margin({ right: 8 })
                Image($r('app.media.startIcon')).width(16).height(16).borderRadius(2).margin({ right: 6 })
                Text('天虹商场-凤凰城店').fontSize(14).fontWeight(FontWeight.Bold).fontColor('#333333')
                Image($r('app.media.startIcon')).width(12).height(12).margin({ left: 2 })
              }
              .width('100%')
              .padding({ left: 16, right: 16, top: 12, bottom: 8 })
            }

            // 商品条目循环
            List({ space: 12 }) {
              ForEach(this.cartItems, (item: number) => {
                ListItem() {
                  this.CartItemRow(item)
                }
              })
            }
            .width('100%')
            .scrollBar(BarState.Off)
            .padding(12)
          }
          .width('92%')
          .backgroundColor(Color.White)
          .borderRadius(12)
          .margin({ top: 12, bottom: 16 })
          .shadow({ radius: 4, color: 'rgba(0,0,0,0.03)', offsetY: 2 })

          // --- 3. 更多精选商品标题 ---
          Row() {
            Image($r('app.media.startIcon')).width(14).height(14).margin({ right: 6 })
            Text('更多精选商品').fontSize(14).fontColor('#666666')
            Image($r('app.media.startIcon')).width(14).height(14).margin({ left: 6 })
          }
          .width('100%')
          .justifyContent(FlexAlign.Center)
          .margin({ bottom: 12 })

          // --- 4. 猜你喜欢推荐瀑布流 ---
          Grid() {
            ForEach(this.recommendProducts, () => {
              GridItem() {
                this.RecommendProductCard()
              }
            })
          }
          .columnsTemplate('1fr 1fr')
          .columnsGap(10)
          .rowsGap(10)
          .width('92%')
          .margin({ bottom: 90 }) // 底部留白防止被结算/管理栏遮挡
        }
      }
      .scrollBar(BarState.Off)
      .width('100%')
      .height('100%')
      .backgroundColor('#F8F8F8')

      // === 5. 底部悬浮操作栏 (根据 isManaging 动态切换两套 UI) ===
      if (!this.isManaging) {
        // 正常结算栏
        Row() {
          Row({ space: 6 }) {
            Circle({ width: 18, height: 18 }).fill('#10C8A7')
            Text('全选').fontSize(13).fontColor('#333333')
          }

          Blank()

          Text('总价: ')
            .fontSize(13)
            .fontColor('#333333')
          Text('¥ 62.08')
            .fontSize(18)
            .fontColor('#FF4D4F')
            .fontWeight(FontWeight.Bold)
            .margin({ right: 12 })

          Button('结算 (6)')
            .width(110)
            .height(40)
            .backgroundColor('#10C8A7')
            .fontColor(Color.White)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .borderRadius(20)
            .onClick(() => {
              // 跳转确认订单
              router.pushUrl({ url: 'pages/cart/ConfirmOrderPage' });
            })
        }
        .width('100%')
        .height(65)
        .backgroundColor(Color.White)
        .padding({ left: 16, right: 16 })
        .shadow({ radius: 8, color: 'rgba(0,0,0,0.05)', offsetY: -2 })
      } else {
        // 管理编辑模式下的底部操作栏
        Row() {
          Row({ space: 6 }) {
            Circle({ width: 18, height: 18 }).fill('#10C8A7')
            Text('全选').fontSize(13).fontColor('#333333')
          }

          Blank()

          Row({ space: 10 }) {
            Button('分享')
              .width(76)
              .height(36)
              .backgroundColor(Color.White)
              .fontColor('#10C8A7')
              .border({ width: 1, color: '#10C8A7' })
              .fontSize(13)
              .borderRadius(18)

            Button('移入收藏')
              .width(90)
              .height(36)
              .backgroundColor(Color.White)
              .fontColor('#10C8A7')
              .border({ width: 1, color: '#10C8A7' })
              .fontSize(13)
              .borderRadius(18)

            Button('删除')
              .width(76)
              .height(36)
              .backgroundColor('#10C8A7')
              .fontColor(Color.White)
              .fontSize(13)
              .borderRadius(18)
          }
        }
        .width('100%')
        .height(65)
        .backgroundColor(Color.White)
        .padding({ left: 16, right: 16 })
        .shadow({ radius: 8, color: 'rgba(0,0,0,0.05)', offsetY: -2 })
      }
    }
    .width('100%')
    .height('100%')
  }

  // --- 局部复用组件 ---

  @Builder TabTitle(title: string, index: number) {
    Column() {
      Text(title)
        .fontSize(15)
        .fontWeight(this.currentTab === index ? FontWeight.Bold : FontWeight.Normal)
        .fontColor(this.currentTab === index ? '#333333' : '#999999')
        .margin({ bottom: 6 })

      Divider()
        .color(this.currentTab === index ? '#10C8A7' : Color.Transparent)
        .strokeWidth(3)
        .width(20)
        .lineCap(LineCapStyle.Round)
    }
    .margin({ right: 24 })
    .onClick(() => { this.currentTab = index; })
  }

  @Builder CartItemRow(itemIndex: number) {
    Row() {
      // 勾选框
      Circle({ width: 18, height: 18 }).fill('#10C8A7').margin({ right: 10 })

      // 商品主图 (带“买过X次”或“直降”角标)
      Stack({ alignContent: Alignment.Bottom }) {
        Image($r('app.media.startIcon'))
          .width(70)
          .height(70)
          .borderRadius(6)

        if (itemIndex % 2 === 0) {
          Text('买过 2 次')
            .fontSize(9)
            .fontColor(Color.White)
            .backgroundColor('rgba(0,0,0,0.6)')
            .width('100%')
            .textAlign(TextAlign.Center)
            .borderRadius({ bottomLeft: 6, bottomRight: 6 })
        }
      }
      .margin({ right: 10 })

      // 商品信息
      Column() {
        Text('大白菜 约1.5kg')
          .fontSize(14)
          .fontColor('#333333')
          .fontWeight(FontWeight.Medium)
          .margin({ bottom: 4 })
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        // 直降标签
        Text('直降')
          .fontSize(9)
          .fontColor('#FF4D4F')
          .border({ width: 0.5, color: '#FF4D4F' })
          .borderRadius(2)
          .padding({ left: 2, right: 2 })
          .margin({ bottom: 6 })

        Row() {
          Text('¥9.99').fontSize(15).fontColor('#FF4D4F').fontWeight(FontWeight.Bold).margin({ right: 6 })
          Text('¥12.9').fontSize(11).fontColor('#999999').decoration({ type: TextDecorationType.LineThrough })
        }
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      // 右侧操作区：非管理模式显示步进器；管理模式显示红色删除减号
      if (!this.isManaging) {
        Row() {
          Text('-').fontSize(14).fontColor('#666666').width(22).height(22).textAlign(TextAlign.Center).border({ width: 0.5, color: '#E0E0E0' }).borderRadius({ topLeft: 4, bottomLeft: 4 })
          Text('1').fontSize(12).fontColor('#333333').width(28).height(22).textAlign(TextAlign.Center).border({ width: { top: 0.5, bottom: 0.5 }, color: '#E0E0E0' })
          Text('+').fontSize(14).fontColor('#666666').width(22).height(22).textAlign(TextAlign.Center).border({ width: 0.5, color: '#E0E0E0' }).borderRadius({ topRight: 4, bottomRight: 4 })
        }
      } else {
        // 管理模式下的红色删除图标
        Circle({ width: 20, height: 20 }).fill('#FF4D4F')
      }
    }
    .width('100%')
    .padding({ top: 8, bottom: 8 })
    .border({ width: { bottom: 0.5 }, color: '#F0F0F0' })
  }

  @Builder RecommendProductCard() {
    Column() {
      Image($r('app.media.startIcon')).width('100%').aspectRatio(1).borderRadius({ topLeft: 8, topRight: 8 })

      Column() {
        Text('花菜 约500g')
          .fontSize(14).fontColor('#333333').fontWeight(FontWeight.Medium).margin({ bottom: 4 })
        Text('产地直供，营养丰富，多...')
          .fontSize(11).fontColor('#999999').margin({ bottom: 10 }).maxLines(1).textOverflow({ overflow: TextOverflow.Ellipsis })

        Row() {
          Text('¥7.99').fontSize(16).fontColor('#FF4D4F').fontWeight(FontWeight.Bold).margin({ right: 4 })
          Text('¥9.90').fontSize(12).fontColor('#999999').decoration({ type: TextDecorationType.LineThrough })
          Blank()
          Stack({ alignContent: Alignment.Center }) {
            Circle({ width: 22, height: 22 }).fill('#10C8A7')
            Image($r('app.media.startIcon')).width(12).height(12)
          }
        }
        .width('100%')
      }
      .padding(10)
      .alignItems(HorizontalAlign.Start)
      .width('100%')
    }
    .backgroundColor(Color.White)
    .borderRadius(8)
  }
}