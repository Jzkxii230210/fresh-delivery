import router from '@ohos.router';
import { CategoryItem, NearbyShop, RecommendProduct, CATEGORY_LIST, NEARBY_SHOPS, RECOMMEND_PRODUCTS, QUICK_SEARCH_TAGS } from '../../common/HomeData';

@Entry
@Component
export struct HomeUnloginPage {
  // 当前Tab索引（首页是第1个Tab，索引为0）
  private readonly TAB_INDEX: number = 0;
  
  // 使用公共数据
  private categories: string[] = CATEGORY_LIST.map(item => item.title);
  private tags: string[] = QUICK_SEARCH_TAGS;
  private recommendProducts: RecommendProduct[] = RECOMMEND_PRODUCTS;
  private nearbyShops: NearbyShop[] = NEARBY_SHOPS;

  build() {
    Stack({ alignContent: Alignment.Bottom }) {

      Column() {
        // === 1. 顶部绿色头部 ===
        Column() {
          // 定位与消息栏
          Row() {
            Image($r('app.media.dingwei')).width(16).height(16).margin({ right: 4 })
            Text('碧桂园凤凰城').fontSize(16).fontColor(Color.White).fontWeight(FontWeight.Bold)
            Image($r('app.media.xiala')).width(12).height(12).margin({ left: 4 })
            Blank()
            Image($r('app.media.message')).width(24).height(24)
              .onClick(() => { router.pushUrl({ url: 'pages/login/LoginPage', params: { tabIndex: this.TAB_INDEX } }) })
          }
          .width('100%')
          .padding({ left: 16, right: 16, top: 44, bottom: 12 })
          .onClick(() => { router.pushUrl({ url: 'pages/login/LoginPage', params: { tabIndex: this.TAB_INDEX } }) })

          // 搜索框
          Row() {
            Image($r('app.media.search')).width(16).height(16).margin({ right: 8 })
            Text('搜索商品').fontSize(14).fontColor('#999999')
          }
          .width('92%')
          .height(36)
          .backgroundColor(Color.White)
          .borderRadius(18)
          .padding({ left: 16 })
          .margin({ bottom: 8 })
          .onClick(() => { router.pushUrl({ url: 'pages/login/LoginPage', params: { tabIndex: this.TAB_INDEX } }) })
        }
        .backgroundColor('#10C8A7') // 品牌绿
        .width('100%')
        .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP]) // 延伸到状态栏区域

        // === 2. 核心滚动区 ===
        List() {
          ListItem() {
            Column() {
              // --- 绿色的热搜词条区 ---
              Column() {
                List({ space: 12 }) {
                  ForEach(this.tags, (tag: string) => {
                    ListItem() {
                      Text(tag)
                        .fontSize(12)
                        .fontColor(Color.White)
                        .backgroundColor('rgba(255, 255, 255, 0.2)')
                        .padding({ left: 10, right: 10, top: 4, bottom: 4 })
                        .borderRadius(12)
                    }
                    .onClick(() => { router.pushUrl({ url: 'pages/login/LoginPage', params: { tabIndex: this.TAB_INDEX } }) })
                  })
                }
                .listDirection(Axis.Horizontal)
                .scrollBar(BarState.Off)
                .width('92%')
                .margin({ bottom: 12 })
              }
              .backgroundColor('#10C8A7')
              .width('100%')

              // --- 十宫格分类区 (修复：补充原型底部指示器) ---
              Column() {
                Grid() {
                  ForEach(CATEGORY_LIST, (item: CategoryItem) => {
                    GridItem() {
                      Column() {
                        Image(item.icon).width(44).height(44).borderRadius(22).margin({ bottom: 6 })
                        Text(item.title).fontSize(12).fontColor('#333333')
                      }
                    }
                    .onClick(() => { router.pushUrl({ url: 'pages/login/LoginPage', params: { tabIndex: this.TAB_INDEX } }) })
                  })
                }
                .columnsTemplate('1fr 1fr 1fr 1fr 1fr')
                .rowsTemplate('1fr 1fr')
                .rowsGap(16)
                .width('100%')
                .height(160)
                .padding({ top: 16, bottom: 8 })

                // 底部轮播指示器
                Row({ space: 4 }) {
                  Rect({ width: 16, height: 4 }).fill('#10C8A7').radius(2)
                  Circle({ width: 4, height: 4 }).fill('#E0E0E0')
                }
                .justifyContent(FlexAlign.Center)
                .width('100%')
                .margin({ bottom: 12 })
              }
              .backgroundColor(Color.White)

              // --- 一公里商家区 (修复：外层增加原型白色卡片) ---
              Column() {
                Row() {
                  Text('一公里商家').fontSize(16).fontWeight(FontWeight.Bold).fontColor('#333333')
                  Blank()
                  Text('更多 >').fontSize(12).fontColor('#999999')
                    .onClick(() => { router.pushUrl({ url: 'pages/login/LoginPage', params: { tabIndex: this.TAB_INDEX } }) })
                }
                .width('100%')
                .padding({ left: 12, right: 12, top: 16, bottom: 12 })

                List({ space: 12 }) {
                  ForEach(this.nearbyShops, (shop: NearbyShop, index: number) => {
                    ListItem() { this.MerchantCard(shop, index === 0) }
                    .onClick(() => { router.pushUrl({ url: 'pages/login/LoginPage', params: { tabIndex: this.TAB_INDEX } }) })
                  })
                }
                .listDirection(Axis.Horizontal)
                .scrollBar(BarState.Off)
                .width('100%')
                .padding({ left: 12, right: 12, bottom: 16 })
              }
              .width('94%')
              .backgroundColor(Color.White)
              .borderRadius(12) // 白色外卡片包裹
              .margin({ top: 12 })
            }
            .backgroundColor('#F5F5F5')
            .padding({ bottom: 12 })
          }

          // --- 瀑布流推荐区 ---
          ListItemGroup({ header: this.StickyTabHeader() }) {
            ForEach([0, 2, 4], (startIndex: number) => {
              ListItem() {
                Row({ space: 10 }) {
                  // 【修复】：layoutWeight(1) 必须写在 Row 的直接子组件上，否则排版会乱
                  Column() { this.HomeProductCard(this.recommendProducts[startIndex]) }
                  .layoutWeight(1)
                  .onClick(() => { router.pushUrl({ url: 'pages/login/LoginPage', params: { tabIndex: this.TAB_INDEX } }) })

                  Column() { this.HomeProductCard(this.recommendProducts[startIndex + 1]) }
                  .layoutWeight(1)
                  .onClick(() => { router.pushUrl({ url: 'pages/login/LoginPage', params: { tabIndex: this.TAB_INDEX } }) })
                }
                .width('92%')
                .margin({ left: '4%', right: '4%', bottom: 10 })
              }
            })
            // 底部留白避开 TabBar
            ListItem() { Row().height(100).width('100%') }
          }
        }
        .sticky(StickyStyle.Header)
        .scrollBar(BarState.Off)
        .layoutWeight(1)
        .backgroundColor('#F5F5F5')
      }
      .width('100%')
      .height('100%')

      // === 3. 底部悬浮登录条 (修复：改为半透明小圆角矩形) ===
      Row() {
        Text('登录小毕买菜，解锁更多功能~')
          .fontSize(13)
          .fontColor(Color.White)
          .layoutWeight(1)

        Button('立即登录')
          .type(ButtonType.Normal)
          .height(30)
          .backgroundColor('#10C8A7')
          .fontColor(Color.White)
          .fontSize(13)
          .borderRadius(15)
          .padding({ left: 12, right: 12 })
          .onClick(() => { router.pushUrl({ url: 'pages/login/LoginPage', params: { tabIndex: this.TAB_INDEX } }) })
      }
      .width('92%')
      .height(48)
      .backgroundColor('rgba(0, 0, 0, 0.6)') // 恢复原型图的半透明灰色
      .borderRadius(8) // 恢复原型图的小圆角矩形
      .padding({ left: 16, right: 12 })
      .margin({ bottom: 16 })
    }
    .width('100%')
    .height('100%')
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP])
  }


  // ================= 局部复用组件 =================

  @Builder StickyTabHeader() {
    Row() {
      this.TabTitle('好物推荐', '人气甄选', true)
      this.TabTitle('新品尝鲜', '新品抢购', false)
      this.TabTitle('优惠折扣', '就是便宜', false)
      this.TabTitle('猜你喜欢', '经常购买', false)
    }
    .width('100%')
    .padding({ top: 16, bottom: 16 })
    .backgroundColor('#F5F5F5')
  }

  @Builder MerchantCard(shop: NearbyShop, isFirst: boolean) {
    Column() {
      Stack({ alignContent: Alignment.BottomStart }) {
        Image(shop.icon).width(80).height(80).borderRadius(8).backgroundColor('#F0F0F0')
        if (isFirst && shop.tags && shop.tags.length > 0) {
          Text(shop.tags[0])
            .fontSize(10).fontColor(Color.White).backgroundColor('rgba(0,0,0,0.4)')
            .padding({ left: 4, right: 4, top: 2, bottom: 2 }).borderRadius({ bottomLeft: 8, topRight: 8 })
        }
      }
      .margin({ bottom: 8 })
      Text(shop.name).fontSize(12).fontColor('#333333').fontWeight(FontWeight.Medium).maxLines(1).textOverflow({ overflow: TextOverflow.Ellipsis }).width(80)
      Text(`${shop.type}·${shop.distance}`).fontSize(11).fontColor('#999999').margin({ top: 4 })
    }
    .alignItems(HorizontalAlign.Start)
  }

  // (修复：使用原型图的下划线作为指示器)
  @Builder TabTitle(title: string, subTitle: string, isSelected: boolean) {
    Column() {
      Text(title).fontSize(15).fontWeight(isSelected ? FontWeight.Bold : FontWeight.Normal).fontColor(isSelected ? '#333333' : '#666666').margin({ bottom: 4 })
      Text(subTitle).fontSize(11).fontColor(isSelected ? '#10C8A7' : '#999999')

      // 底部翠绿色下划线
      if (isSelected) {
        Rect({ width: 24, height: 2 }).fill('#10C8A7').radius(1).margin({ top: 4 })
      } else {
        Rect({ width: 24, height: 2 }).fill(Color.Transparent).margin({ top: 4 }) // 占位防抖动
      }
    }
    .layoutWeight(1)
    .alignItems(HorizontalAlign.Center)
    .onClick(() => { router.pushUrl({ url: 'pages/login/LoginPage', params: { tabIndex: this.TAB_INDEX } }) })
  }

  @Builder HomeProductCard(product: RecommendProduct) {
    Column() {
      Image(product.image).width('100%').aspectRatio(1).borderRadius({ topLeft: 8, topRight: 8 }).backgroundColor('#F9F9F9')
      Column() {
        Text(product.name).fontSize(14).fontColor('#333333').fontWeight(FontWeight.Medium).margin({ bottom: 4 })
        Text(product.desc).fontSize(11).fontColor('#999999').margin({ bottom: 12 })
        Row() {
          Text(`¥${product.price}`).fontSize(16).fontColor('#FF4D4F').fontWeight(FontWeight.Bold).margin({ right: 4 })
          Text(`¥${product.oldPrice}`).fontSize(12).fontColor('#999999').decoration({ type: TextDecorationType.LineThrough })
        }.margin({ bottom: 12 })
        Row() {
          Image(product.storeIcon).width(14).height(14).borderRadius(2).margin({ right: 4 })
          Text(product.storeName).fontSize(10).fontColor('#666666').maxLines(1).textOverflow({ overflow: TextOverflow.Ellipsis }).layoutWeight(1)
        }
      }
      .padding(10).alignItems(HorizontalAlign.Start).width('100%')
    }
    .width('100%')
    .backgroundColor(Color.White)
    .borderRadius(8)
  }
}