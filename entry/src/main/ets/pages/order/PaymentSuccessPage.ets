import router from '@ohos.router';

// 商品数据接口
interface Product {
  image: Resource;
  name: string;
  description: string;
  currentPrice: string;
  originalPrice: string;
  productIndex: number; // 对应RECOMMEND_PRODUCTS中的索引
}

@Entry
@Component
struct PaymentSuccessPage {
  // 推荐商品数据
  private recommendProducts: Product[] = [
    {
      image: $r('app.media.huacai'),
      name: '花菜 约500g',
      description: '产地直供，营养丰富，多',
      currentPrice: '¥7.99',
      originalPrice: '¥9.90',
      productIndex: 0 // 花菜
    },
    {
      image: $r('app.media.baicai'),
      name: '大白菜 约500g',
      description: '新鲜采摘，口感清甜',
      currentPrice: '¥3.99',
      originalPrice: '¥5.90',
      productIndex: 3 // 大白菜
    },
    {
      image: $r('app.media.jidan'),
      name: '土鸡蛋 30枚',
      description: '农家散养，营养健康',
      currentPrice: '¥18.99',
      originalPrice: '¥25.90',
      productIndex: 2 // 本地鸡蛋
    },
    {
      image: $r('app.media.wuchangdami'),
      name: '五常大米 5kg',
      description: '东北黑土地，香糯可口',
      currentPrice: '¥39.99',
      originalPrice: '¥49.90',
      productIndex: 0 // 没有对应商品，默认跳转到第一个商品
    }
  ];

  build() {
    Scroll() {
      Column() {
        // === 1. 顶部支付成功状态区 ===
        Column() {
          Row({ space: 8 }) {
            Stack() {
              Circle({ width: 24, height: 24 }).fill('#10C8A7')
              Image($r('app.media.select')).width(12).height(12)
            }
            Text('支付成功')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor('#333333')
          }
          .margin({ bottom: 20 })

          // 核心操作按钮 (返回首页 / 查看订单)
          Row({ space: 16 }) {
            Button('返回首页')
              .width(130)
              .height(36)
              .backgroundColor(Color.White)
              .fontColor('#666666')
              .border({ width: 1, color: '#CCCCCC' })
              .fontSize(14)
              .borderRadius(18)
              .onClick(() => {
                // 返回首页
                router.replaceUrl({ url: 'pages/main/MainPage' });
              })

            Button('查看订单')
              .width(130)
              .height(36)
              .backgroundColor(Color.White)
              .fontColor('#10C8A7')
              .border({ width: 1, color: '#10C8A7' })
              .fontSize(14)
              .borderRadius(18)
              .onClick(() => {
                router.pushUrl({ url: 'pages/order/OrderDetailPage' });
              })
          }
        }
        .width('100%')
        .padding({ top: 30, bottom: 30 })
        .backgroundColor(Color.White)
        .margin({ bottom: 12 })

        // === 2. 更多精选商品标题 ===
        Row() {
          Image($r('app.media.xihuan')).width(14).height(14).margin({ right: 6 })
          Text('更多精选商品').fontSize(14).fontColor('#FF4D4F')
          Image($r('app.media.xihuan')).width(14).height(14).margin({ left: 6 })
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
        .margin({ bottom: 12 })

        // === 3. 商品瀑布流推荐 (双列 Grid) ===
        Grid() {
          ForEach(this.recommendProducts, (product: Product) => {
            GridItem() {
              this.ProductCard(product)
            }
          })
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(10)
        .rowsGap(10)
        .width('92%')
        .margin({ bottom: 30 })
      }
      .width('100%')
    }
    .scrollBar(BarState.Off)
    .width('100%')
    .height('100%')
    .backgroundColor('#F8F8F8')
  }

  // --- 局部复用组件：推荐商品卡片 ---
  @Builder ProductCard(product: Product) {
    Column() {
      Image(product.image)
        .width('100%')
        .aspectRatio(1)
        .borderRadius({ topLeft: 8, topRight: 8 })

      Column() {
        Text(product.name)
          .fontSize(14)
          .fontColor('#333333')
          .fontWeight(FontWeight.Medium)
          .margin({ bottom: 4 })

        Text(product.description)
          .fontSize(11)
          .fontColor('#999999')
          .margin({ bottom: 10 })
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Row() {
          Text(product.currentPrice).fontSize(16).fontColor('#FF4D4F').fontWeight(FontWeight.Bold).margin({ right: 4 })
          Text(product.originalPrice).fontSize(12).fontColor('#999999').decoration({ type: TextDecorationType.LineThrough })

          Blank()

          Stack({ alignContent: Alignment.Center }) {
            Circle({ width: 22, height: 22 }).fill('#10C8A7')
            Image($r('app.media.gouwuche')).width(12).height(12)
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
    .onClick(() => {
      // 跳转到商品详情页面
      router.pushUrl({
        url: 'pages/store/ProductDetailPage',
        params: { productIndex: product.productIndex }
      });
    })
  }
}