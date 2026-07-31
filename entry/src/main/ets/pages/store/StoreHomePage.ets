import router from '@ohos.router';
import { NEARBY_SHOPS, NearbyShop, RECOMMEND_PRODUCTS, RecommendProduct } from '../../common/HomeData';

// 路由参数接口
interface RouterParams {
  shopIndex?: number;
}

@Entry
@Component
struct StoreHomePage {
  @State currentCategoryIndex: number = 0;

  // 当前商家索引
  private shopIndex: number = 0;
  private shop: NearbyShop = NEARBY_SHOPS[0];

  // 模拟分类数据
  private categories: string[] = ['年货节', '蔬菜豆品', '肉禽蛋', '海鲜水产', '水果鲜花', '乳品烘焙', '冷冻食品', '粮油调味', '酒水饮料', '休闲零食', '生活用品'];

  aboutToAppear() {
    const params = router.getParams() as RouterParams;
    if (params && params.shopIndex !== undefined) {
      this.shopIndex = params.shopIndex;
      if (this.shopIndex >= 0 && this.shopIndex < NEARBY_SHOPS.length) {
        this.shop = NEARBY_SHOPS[this.shopIndex];
      }
    }
  }

  build() {
    // 外层 Stack 用于把底部购物车悬浮在整个页面之上
    Stack({ alignContent: Alignment.Bottom }) {

      // 主体内容区
      Column() {
        // === 1. 顶部 Header 区 (背景图 + 导航 + 店铺卡片) ===
        Stack({ alignContent: Alignment.Top }) {
          // 1.1 店铺背景图 (用深色占位)
          Image($r('app.media.beijing'))
            .width('100%')
            .height(160)
            .objectFit(ImageFit.Cover)
            .opacity(0.8)

          Column() {
            // 1.2 顶部导航栏
            Row() {
              Image($r('app.media.back')) // 返回按钮
                .width(20).height(20).margin({ right: 12 })
                .onClick(() => { router.back(); })

              // 店内搜索框
              Row() {
                Image($r('app.media.search')).width(16).height(16).margin({ right: 6 })
                Text('搜索店内商品').fontSize(13).fontColor('#999999')
              }
              .layoutWeight(1)
              .height(32)
              .backgroundColor(Color.White)
              .borderRadius(16)
              .padding({ left: 12 })

              // 关注按钮
              Row() {
                Text('已关注').fontSize(12).fontColor(Color.White)
              }
              .backgroundColor('rgba(0,0,0,0.4)')
              .padding({ left: 10, right: 10, top: 6, bottom: 6 })
              .borderRadius(14)
              .margin({ left: 12, right: 12 })

              // 分享图标
              Image($r('app.media.fenxiang')).width(20).height(20)
            }
            .width('100%')
            .padding({ left: 16, right: 16, top: 16 })

            // 1.3 悬浮的店铺信息卡片
            Column() {
              // 头部：Logo + 店名
              Row() {
                Image(this.shop.icon) // 商家 Logo
                  .width(40).height(40).borderRadius(4).margin({ right: 10 })

                Column() {
                  Row() {
                    Text(this.shop.name).fontSize(16).fontWeight(FontWeight.Bold).fontColor('#333333')
                    Image($r('app.media.more')).width(12).height(12).margin({ left: 4 }) // 箭头
                  }.margin({ bottom: 6 })

                  Row() {
                    Text(`${this.shop.rating}分`).fontSize(11).fontColor('#007DFF').backgroundColor('#E5F2FF').padding({ left: 4, right: 4 }).borderRadius(2).margin({ right: 8 })
                    Text('达达快送  运费 ￥4').fontSize(11).fontColor('#666666')
                  }
                }
                .alignItems(HorizontalAlign.Start)
              }
              .width('100%')
              .margin({ bottom: 12 })

              // 优惠券横向列表
              List({ space: 8 }) {
                ForEach(['￥2 店铺券', '￥4 店铺券', '￥7 店铺券', '￥50'], (coupon: string) => {
                  ListItem() {
                    Row() {
                      Text(coupon).fontSize(11).fontColor('#FF4D4F').margin({ right: 4 })
                      Text('领取').fontSize(11).fontColor('#FF4D4F')
                    }
                    .padding({ left: 6, right: 6, top: 2, bottom: 2 })
                    .backgroundColor('#FFF0F0')
                    .border({ width: 0.5, color: '#FF4D4F' })
                    .borderRadius(2)
                  }
                })
              }
              .listDirection(Axis.Horizontal)
              .scrollBar(BarState.Off)
              .width('100%')
              .height(28)
              .margin({ bottom: 10 })

              // 满减信息
              Row() {
                Text('满减').fontSize(10).fontColor('#FF8C00').border({ width: 1, color: '#FF8C00' }).borderRadius(2).padding({ left: 2, right: 2 }).margin({ right: 6 })
                Text('维达纸巾满49减5，满79减10，满99减15').fontSize(11).fontColor('#FF8C00').maxLines(1).textOverflow({ overflow: TextOverflow.Ellipsis }).layoutWeight(1)
              }
              .width('100%')
              .constraintSize({ minWidth: 0 })
            }
            .width('92%')
            .backgroundColor(Color.White)
            .borderRadius(12)
            .padding(12)
            .margin({ top: 16 })
            .shadow({ radius: 10, color: 'rgba(0,0,0,0.05)', offsetY: 4 })
          }
        }
        .width('100%')
        // 设置 Header 的固定高度，保证下面的双列列表能正常滚动
        .height(200)

        // === 2. 下半部分：双级联动列表 ===
        Row() {
          // --- 左侧：分类菜单 ---
          List() {
            ForEach(this.categories, (item: string, index: number) => {
              ListItem() {
                Row() {
                  Column().width(4).height(16).backgroundColor(this.currentCategoryIndex === index ? '#10C8A7' : Color.Transparent).borderRadius(2)
                  Text(item)
                    .fontSize(13)
                    .fontWeight(this.currentCategoryIndex === index ? FontWeight.Bold : FontWeight.Normal)
                    .fontColor(this.currentCategoryIndex === index ? '#333333' : '#666666')
                    .layoutWeight(1)
                    .textAlign(TextAlign.Center)
                }
                .width('100%')
                .height(50)
                .backgroundColor(this.currentCategoryIndex === index ? Color.White : '#F8F8F8')
                .onClick(() => { this.currentCategoryIndex = index; })
              }
            })
          }
          .width(90)
          .height('100%')
          .backgroundColor('#F8F8F8')
          .scrollBar(BarState.Off)

          // --- 右侧：商品列表 ---
          Column() {
            // 右侧顶部过滤栏
            Row() {
              Text('综合排序').fontSize(11).fontColor('#666666')
              Image($r('app.media.xiala')).width(10).height(10).margin({ left: 2, right: 12 }) // 下拉箭头
              Text('减免运费').fontSize(11).fontColor('#666666')
            }
            .width('100%')
            .padding({ left: 12, right: 12, top: 12, bottom: 12 })
            .backgroundColor(Color.White)

            // 滚动商品列表
            List() {
              ForEach(RECOMMEND_PRODUCTS, (product: RecommendProduct, index: number) => {
                ListItem() {
                  this.StoreProductCard(product)
                }
                .onClick(() => {
                  router.pushUrl({
                    url: 'pages/store/ProductDetailPage',
                    params: { productIndex: index }
                  });
                })
              })
              // 底部留出空间，防止被悬浮的购物车挡住
              ListItem() { Row().height(70).width('100%') }
            }
            .layoutWeight(1)
            .width('100%')
            .scrollBar(BarState.Off)
          }
          .layoutWeight(1)
          .height('100%')
          .backgroundColor(Color.White)
        }
        .layoutWeight(1)
        .width('100%')
      }
      .width('100%')
      .height('100%')

      // === 3. 底部悬浮购物车栏 ===
      Row() {
        Column() {
          Text('￥19.99').fontSize(18).fontColor('#333333').fontWeight(FontWeight.Bold)
        }.layoutWeight(1).alignItems(HorizontalAlign.Start)

        // 起送按钮 (未满起送价时的灰色状态)
        Button('9 元起送')
          .width(100)
          .height(40)
          .backgroundColor('#D3D3D3') // 灰色
          .fontColor(Color.White)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .borderRadius(20)
      }
      .width('100%')
      .height(60)
      .backgroundColor(Color.White)
      .padding({ left: 20, right: 16 })
      // 顶部阴影，与商品列表区分开
      .shadow({ radius: 8, color: 'rgba(0,0,0,0.05)', offsetY: -2 })
    }
    .width('100%')
    .height('100%')
  }

  // --- 局部复用组件：店内商品卡片 ---
  @Builder StoreProductCard(product: RecommendProduct) {
    Row() {
      Image(product.image).width(76).height(76).borderRadius(8).margin({ right: 10 })

      Column() {
        Text(product.name)
          .fontSize(14).fontColor('#333333').fontWeight(FontWeight.Medium).margin({ bottom: 6 }).maxLines(1).textOverflow({ overflow: TextOverflow.Ellipsis })

        Text(product.desc)
          .fontSize(11).fontColor('#999999').margin({ bottom: 12 }).maxLines(1).textOverflow({ overflow: TextOverflow.Ellipsis })

        Row() {
          Text(product.price).fontSize(16).fontColor('#FF4D4F').fontWeight(FontWeight.Bold).margin({ right: 6 })
          Text(product.oldPrice).fontSize(12).fontColor('#999999').decoration({ type: TextDecorationType.LineThrough })
          Blank()
          // 亮绿色加购按钮
          Stack({ alignContent: Alignment.Center }) {
            Circle({ width: 24, height: 24 }).fill('#10C8A7')
            Text('+').fontSize(18).fontColor(Color.White).fontWeight(FontWeight.Medium).margin({ bottom: 2 })
          }
        }
        .width('100%')
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .padding({ left: 12, right: 12, top: 12, bottom: 12 })
  }
}