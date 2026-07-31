import router from '@ohos.router';
import { CART_PRODUCTS, RECOMMEND_PRODUCTS, CartProduct, RecommendProduct } from '../../common/HomeData';

@Entry
@Component
export struct CartPage {
  @State isManaging: boolean = false;
  @State currentTab: number = 0;
  @State cartItems: CartProduct[] = CART_PRODUCTS;
  private recommendProducts: RecommendProduct[] = RECOMMEND_PRODUCTS;

  build() {
    Column() {
      // === 主体滚动区域 ===
      Scroll() {
        Column() {
          // --- 1. 顶部标题栏 ---
          Row() {
            if (this.isManaging) {
              Image($r('app.media.back')) // 替换为返回箭头
                .width(20).height(20).margin({ right: 12 })
                .onClick(() => { this.isManaging = false; })
            }

            Text('购物车')
              .fontSize(22)
              .fontWeight(FontWeight.Bold)
              .fontColor('#333333')
              .margin({ right: 12 })

            // 定位药丸标签
            Row() {
              Image($r('app.media.dingwei')).width(12).height(12).margin({ right: 4 }) // 替换为定位Icon
              Text('碧桂园凤凰城').fontSize(12).fontColor('#666666')
              Image($r('app.media.xiala')).width(10).height(10).margin({ left: 4 }) // 替换为下拉箭头Icon
            }
            .padding({ left: 8, right: 8, top: 5, bottom: 5 })
            .backgroundColor('#F5F5F5')
            .borderRadius(14)

            Blank()

            Text(this.isManaging ? '完成' : '管理')
              .fontSize(14)
              .fontColor('#666666')
              .onClick(() => { this.isManaging = !this.isManaging; })
          }
          .width('100%')
          .height(50)
          .padding({ left: 16, right: 16, top: 4 })
          .backgroundColor(Color.White)

          // --- 2. 顶部 Tab 切换 ---
          Row() {
            this.TabTitle('全部 (6)', 0)
            this.TabTitle('降价 (3)', 1)
            this.TabTitle('常买 (2)', 2)
          }
          .width('100%')
          .padding({ left: 16, right: 16, top: 12, bottom: 8 })
          .backgroundColor(Color.White)
          .justifyContent(FlexAlign.SpaceBetween)

          // --- 3. 购物车列表卡片区 (包含店铺头部与商品) ---
          Column() {
            // 店铺头部
            Row() {
              Stack({ alignContent: Alignment.Center }) {
                Circle({ width: 18, height: 18 }).fill('#10C8A7')
                Text('✓').fontSize(12).fontColor(Color.White).fontWeight(FontWeight.Bold)
              }.margin({ right: 10 })

              Image($r('app.media.tianhong')).width(16).height(16).borderRadius(2).margin({ right: 6 }) // 天虹Logo
              Text('天虹商场-凤凰城店').fontSize(14).fontWeight(FontWeight.Bold).fontColor('#333333')
              Image($r('app.media.more')).width(12).height(12).margin({ left: 4 }) // 右箭头
            }
            .width('100%')
            .padding({ left: 12, right: 12, top: 16, bottom: 12 })

            Divider().color('#F5F5F5').strokeWidth(0.5).margin({ left: 12, right: 12 })

            // 商品条目循环
            List() {
              ForEach(this.cartItems, (item: CartProduct, index: number) => {
                ListItem() {
                  this.CartItemRow(item, index)
                }
              })
            }
            .width('100%')
            .scrollBar(BarState.Off)
          }
          .width('94%')
          .backgroundColor(Color.White)
          .borderRadius(12)
          .margin({ top: 12, bottom: 12 })

          // --- 4. 结算/管理操作栏 (随文档流滚动，放置在精选商品上方) ---
          if (!this.isManaging) {
            // 正常结算状态
            Row() {
              Row({ space: 8 }) {
                Text('总价:').fontSize(13).fontColor('#333333')
                Text('¥ 62.08').fontSize(18).fontColor('#FF4D4F').fontWeight(FontWeight.Bold)
              }.layoutWeight(1).justifyContent(FlexAlign.End).margin({ right: 12 })

              Button('结算 (6)')
                .width(110)
                .height(40)
                .backgroundColor('#10C8A7')
                .fontColor(Color.White)
                .fontSize(15)
                .fontWeight(FontWeight.Medium)
                .borderRadius(20)
                .onClick(() => {
                  router.pushUrl({ url: 'pages/cart/ConfirmOrderPage' });
                })
            }
            .width('94%')
            .height(54)
            .backgroundColor(Color.White)
            .borderRadius(12)
            .padding({ left: 16, right: 16 })
            .margin({ bottom: 16 })
          } else {
            // 管理编辑状态
            Row() {
              Row({ space: 6 }) {
                Stack({ alignContent: Alignment.Center }) {
                  Circle({ width: 18, height: 18 }).fill('#10C8A7')
                  Text('✓').fontSize(12).fontColor(Color.White).fontWeight(FontWeight.Bold)
                }
                Text('全选').fontSize(13).fontColor('#333333')
              }
              Blank()
              Row({ space: 12 }) {
                Button('移入收藏').width(80).height(32).backgroundColor(Color.White).fontColor('#10C8A7').border({ width: 1, color: '#10C8A7' }).fontSize(13).borderRadius(16)
                Button('删除').width(60).height(32).backgroundColor('#FF4D4F').fontColor(Color.White).fontSize(13).borderRadius(16)
              }
            }
            .width('94%')
            .height(54)
            .backgroundColor(Color.White)
            .borderRadius(12)
            .padding({ left: 16, right: 16 })
            .margin({ bottom: 16 })
          }

          // --- 5. 更多精选商品标题 ---
          Row() {
            Image($r('app.media.xihuan')).width(16).height(16).margin({ right: 8 }) // 替换为红色空心爱心
            Text('更多精选商品').fontSize(14).fontColor('#FF4D4F')
            Image($r('app.media.xihuan')).width(16).height(16).margin({ left: 8 }) // 替换为红色空心爱心
          }
          .width('100%')
          .justifyContent(FlexAlign.Center)
          .margin({ bottom: 16 })

          // --- 6. 猜你喜欢推荐瀑布流 ---
          Grid() {
            ForEach(this.recommendProducts, (item: RecommendProduct) => {
              GridItem() {
                this.RecommendProductCard(item)
              }
            })
          }
          .columnsTemplate('1fr 1fr')
          .columnsGap(10)
          .rowsGap(10)
          .width('94%')
          .margin({ bottom: 40 }) // 底部适度留白
        }
      }
      .scrollBar(BarState.Off)
      .width('100%')
      .layoutWeight(1) // 占满全屏剩余空间
      .backgroundColor('#F8F8F8')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8F8F8')
  }

  // --- 局部复用组件 ---

  @Builder TabTitle(title: string, index: number) {
    Column() {
      Text(title)
        .fontSize(14)
        .fontWeight(this.currentTab === index ? FontWeight.Bold : FontWeight.Normal)
        .fontColor(this.currentTab === index ? '#333333' : '#999999')
        .margin({ bottom: 6 })

      Divider()
        .color(this.currentTab === index ? '#10C8A7' : Color.Transparent)
        .strokeWidth(3)
        .width(30)
        .lineCap(LineCapStyle.Round)
    }
    .layoutWeight(1)
    .onClick(() => { this.currentTab = index; })
  }

  @Builder CartItemRow(item: CartProduct, index: number) {
    Row() {
      // 勾选框
      Stack({ alignContent: Alignment.Center }) {
        Circle({ width: 18, height: 18 }).fill(item.selected ? '#10C8A7' : '#EAEAEA')
        if (item.selected) {
          Text('✓').fontSize(12).fontColor(Color.White).fontWeight(FontWeight.Bold)
        }
      }
      .margin({ right: 10 })
      .onClick(() => {
        // 切换选中状态
        const newItem: CartProduct = {
          name: item.name,
          price: item.price,
          oldPrice: item.oldPrice,
          tag: item.tag,
          image: item.image,
          quantity: item.quantity,
          selected: !item.selected,
          productIndex: item.productIndex
        };
        this.cartItems[index] = newItem;
        // 触发状态更新
        this.cartItems = this.cartItems.slice();
      })

      // 商品主图
      Image(item.image)
        .width(76)
        .height(76)
        .borderRadius(6)
        .margin({ right: 12 })
        .onClick(() => {
          // 跳转到商品详情页，传递商品索引
          const productIndex = item.productIndex !== undefined ? item.productIndex : 0;
          router.pushUrl({ 
            url: 'pages/store/ProductDetailPage',
            params: { productIndex: productIndex }
          });
        })

      // 商品信息与步进器
      Column() {
        Text(item.name)
          .fontSize(14)
          .fontColor('#333333')
          .fontWeight(FontWeight.Medium)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .width('100%')

        if (item.tag) {
          Text(item.tag)
            .fontSize(10)
            .fontColor('#FF4D4F')
            .border({ width: 0.5, color: '#FF4D4F' })
            .borderRadius(2)
            .padding({ left: 3, right: 3, top: 1, bottom: 1 })
            .margin({ top: 6 })
        }

        Blank() // 推挤价格和步进器到底部

        Row() {
          Row() {
            Text('¥' + item.price).fontSize(15).fontColor('#FF4D4F').fontWeight(FontWeight.Bold).margin({ right: 6 })
            if (item.oldPrice) {
              Text('¥' + item.oldPrice).fontSize(11).fontColor('#999999').decoration({ type: TextDecorationType.LineThrough })
            }
          }

          Blank()

          // 步进器
          Row() {
            Text('－').fontSize(14).fontColor('#999999').width(24).height(24).textAlign(TextAlign.Center).border({ width: 0.5, color: '#EAEAEA' }).borderRadius({ topLeft: 4, bottomLeft: 4 })
            Text(item.quantity.toString()).fontSize(13).fontColor('#333333').width(32).height(24).textAlign(TextAlign.Center).border({ width: { top: 0.5, bottom: 0.5 }, color: '#EAEAEA' })
            Text('＋').fontSize(14).fontColor('#666666').width(24).height(24).textAlign(TextAlign.Center).border({ width: 0.5, color: '#EAEAEA' }).borderRadius({ topRight: 4, bottomRight: 4 })
          }
        }
        .width('100%')
      }
      .height(76) // 与图片等高，确保排版完美对齐
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      .onClick(() => {
        // 跳转到商品详情页，传递商品索引
        const productIndex = item.productIndex !== undefined ? item.productIndex : 0;
        router.pushUrl({ 
          url: 'pages/store/ProductDetailPage',
          params: { productIndex: productIndex }
        });
      })
    }
    .width('100%')
    .padding({ left: 12, right: 12, top: 16, bottom: 16 })
  }

  @Builder RecommendProductCard(item: RecommendProduct) {
    Column() {
      Image(item.image).width('100%').aspectRatio(1).borderRadius({ topLeft: 8, topRight: 8 })

      Column() {
        Text(item.name)
          .fontSize(14).fontColor('#333333').fontWeight(FontWeight.Medium).margin({ bottom: 6 })
        Text(item.desc)
          .fontSize(11).fontColor('#999999').margin({ bottom: 12 }).maxLines(1).textOverflow({ overflow: TextOverflow.Ellipsis })

        Row() {
          Text('¥' + item.price).fontSize(16).fontColor('#FF4D4F').fontWeight(FontWeight.Bold).margin({ right: 4 })
          Text('¥' + item.oldPrice).fontSize(12).fontColor('#999999').decoration({ type: TextDecorationType.LineThrough })
          Blank()
          // 购物车绿色小圆圈
          Stack({ alignContent: Alignment.Center }) {
            Circle({ width: 24, height: 24 }).fill('#10C8A7')
            Image($r('app.media.gouwuche')).width(12).height(12)
          }
        }
        .width('100%')
        .margin({ bottom: 10 })

        // 店铺与运费信息行
        Row() {
          Image(item.storeIcon).width(18).height(18).borderRadius(4).margin({ right: 6 })
          Column() {
            Text(item.storeName).fontSize(10).fontColor('#666666').margin({ bottom: 2 })
            Text('满¥30免基础运费').fontSize(10).fontColor('#FF4D4F')
          }.alignItems(HorizontalAlign.Start)
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