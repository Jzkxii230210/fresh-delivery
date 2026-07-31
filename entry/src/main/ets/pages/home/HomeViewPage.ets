import router from '@ohos.router';
import promptAction from '@ohos.promptAction';
import { CategoryItem, NearbyShop, RecommendProduct, CATEGORY_LIST, NEARBY_SHOPS, RECOMMEND_PRODUCTS, QUICK_SEARCH_TAGS } from '../../common/HomeData';

@Entry
@Component
export struct HomeViewPage {
  @State currentRecTab: number = 0; // 当前推荐Tab索引

  // 使用公共数据
  private quickSearchTags: string[] = QUICK_SEARCH_TAGS;
  private categoryList: CategoryItem[] = CATEGORY_LIST;
  private nearbyShops: NearbyShop[] = NEARBY_SHOPS;
  private recommendProducts: RecommendProduct[] = RECOMMEND_PRODUCTS;
  build() {
    Column() {
      // 1. 顶部绿色沉浸式头部 (定位 + 搜索 + 快捷标签)
      this.HeaderModule()

      Scroll() {
        Column() {
          // 2. 金刚区 (分类导航)
          this.CategoryModule()

          // 3. 一公里商家 (横向滑动)
          this.NearbyShopsModule()

          // 4. 好物推荐 (Tab切换 + 双列瀑布流)
          this.RecommendationModule()
        }
        .width('100%')
      }
      .scrollBar(BarState.Off)
      .layoutWeight(1)
      .backgroundColor('#F5F5F5')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.Transparent)
    // 关键配置：允许整个页面在顶部侵入系统状态栏区域
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP])
  }

  // ==================== 模块拆分 ====================

  // 1. 头部模块 (背景绿 #10C8A7)
  @Builder HeaderModule() {
    Column() {
      // 定位与消息栏
      Row() {
        Row({ space: 4 }) {
          Image($r('app.media.dingwei')).width(16).height(16).fillColor(Color.White)
            .onClick(() => {
              router.pushUrl({ url: 'pages/mine/SelectAddressPage' })
            })
          Text('碧桂园凤凰城').fontSize(16).fontWeight(FontWeight.Bold).fontColor(Color.White)
          Image($r('app.media.xiala')).width(12).height(12).fillColor(Color.White) // 下拉箭头
            .onClick(() => {
              router.pushUrl({ url: 'pages/mine/SelectAddressPage' })
            })
        }
        Blank()
        Image($r('app.media.message')).width(24).height(24).fillColor(Color.White)
          .onClick(() => {
            router.pushUrl({ url: 'pages/message/ProblemCenterPage' })
          })// 消息图标
      }
      .width('100%')
      // top: 44 是为系统状态栏（时间、电量）预留的高度，防止文字重叠
      .padding({ left: 16, right: 16, top: 44, bottom: 12 })

      // 搜索框
      Row() {
        Image($r('app.media.search')).width(16).height(16).margin({ right: 8 })
        Text('搜索商品').fontSize(14).fontColor('#999999')
      }
      .width('92%')
      .height(36)
      .backgroundColor(Color.White)
      .borderRadius(18)
      .padding({ left: 16, right: 16 })
      .margin({ bottom: 12 })
      .onClick(() => {
        router.pushUrl({ url: 'pages/home/SearchPage' })
      })

      // 新增：快捷标签导航栏
      List({ space: 12 }) {
        ForEach(this.quickSearchTags, (tag: string) => {
          ListItem() {
            Text(tag)
              .fontSize(12)
              .fontColor(Color.White)
              .backgroundColor('rgba(255, 255, 255, 0.25)') // 半透明背景衬托白色文字
              .padding({ left: 12, right: 12, top: 4, bottom: 4 })
              .borderRadius(12)
          }
          .onClick(() => {
            router.pushUrl({ url: 'pages/home/SearchPage', params: { keyword: tag } });
          })
        })
      }
      .listDirection(Axis.Horizontal)
      .scrollBar(BarState.Off)
      .width('100%')
      .height(32)
      .padding({ left: 16, right: 16, bottom: 12 })
    }
    .width('100%')
    .backgroundColor('#10C8A7')
  }

  // 2. 金刚区分类模块
  @Builder CategoryModule() {
    Column() {
      Grid() {
        ForEach(this.categoryList, (item: CategoryItem) => {
          GridItem() {
            Column() {
              Image(item.icon)
                .width(48).height(48)
                .borderRadius(24)
                .margin({ bottom: 6 })
              Text(item.title).fontSize(12).fontColor('#333333')
            }
            .onClick(() => {
              router.pushUrl({ url: 'pages/home/CategoryListPage' })
            })
          }
        })
      }
      .columnsTemplate('1fr 1fr 1fr 1fr 1fr')
      .rowsTemplate('1fr 1fr')
      .height(160) // 控制两行的高度
      .padding({ top: 16, bottom: 8 })

      // 模拟底部分页指示器
      Row({ space: 4 }) {
        Rect({ width: 12, height: 4 }).radius(2).fill('#10C8A7')
        Circle({ width: 4, height: 4 }).fill('#E0E0E0')
      }
      .margin({ bottom: 12 })
    }
    .width('100%')
    .backgroundColor(Color.White)
  }

  // 3. 一公里商家模块
  @Builder NearbyShopsModule() {
    Column() {
      // 模块标题
      Row() {
        Text('一公里商家').fontSize(16).fontWeight(FontWeight.Bold).fontColor('#333333')
        Blank()
        Row({ space: 2 }) {
          Text('更多').fontSize(12).fontColor('#999999')
          Image($r('app.media.more')).width(12).height(12)
        }
        .onClick(() => { router.pushUrl({ url: 'pages/home/NearbyShopPage' }) })
      }
      .width('100%')
      .padding(12)

      // 横向商家列表
      List({ space: 12 }) {
        ForEach(this.nearbyShops, (shop: NearbyShop, index: number) => {
          ListItem() {
            Column() {
              // 商家 Logo 与 标签
              Stack({ alignContent: Alignment.BottomStart }) {
                Image(shop.icon)
                  .width(80).height(80)
                  .borderRadius(8)
                  .backgroundColor('#F0F0F0')

                if (shop.tags && shop.tags.length > 0) {
                  Text(shop.tags[0])
                    .fontSize(10).fontColor(Color.White)
                    .backgroundColor('rgba(0,0,0,0.4)')
                    .padding({ left: 4, right: 4, top: 2, bottom: 2 })
                    .borderRadius({ bottomLeft: 8, topRight: 8 })
                }
              }
              .margin({ bottom: 8 })

              // 商家名称
              Text(shop.name)
                .fontSize(13).fontColor('#333333').fontWeight(FontWeight.Medium)
                .maxLines(1).textOverflow({ overflow: TextOverflow.Ellipsis })
                .width(80).margin({ bottom: 4 })

              // 距离信息
              Text(`${shop.type}·${shop.distance}`)
                .fontSize(11).fontColor('#999999')
            }
          }
          .onClick(() => {
            router.pushUrl({ url: 'pages/store/StoreHomePage', params: { shopIndex: index } });
          })
        })
      }
      .listDirection(Axis.Horizontal)
      .scrollBar(BarState.Off)
      .width('100%')
      .padding({ left: 12, right: 12, bottom: 16 })
    }
    .width('94%')
    .backgroundColor(Color.White)
    .borderRadius(12)
    .margin({ top: 12 })
  }

  // 4. 底部推荐模块
  @Builder RecommendationModule() {
    Column() {
      // 推荐 Tabs
      Row() {
        this.RecTabItem('好物推荐', '人气甄选', 0)
        this.RecTabItem('新品尝鲜', '新品抢购', 1)
        this.RecTabItem('优惠折扣', '就是便宜', 2)
        this.RecTabItem('猜你喜欢', '经常购买', 3)
      }
      .width('100%')
      .padding({ top: 16, bottom: 16, left: 12, right: 12 })

      // 双列商品网格
      Grid() {
        ForEach(this.recommendProducts, (product: RecommendProduct, index: number) => {
          GridItem() {
            Column() {
              Image(product.image)
                .width('100%').aspectRatio(1)
                .borderRadius({ topLeft: 8, topRight: 8 })
                .backgroundColor('#F9F9F9')

              Column() {
                Text(product.name)
                  .fontSize(14).fontWeight(FontWeight.Medium).fontColor('#333333')
                  .margin({ bottom: 6 })

                Text(product.desc)
                  .fontSize(10).fontColor('#999999')
                  .margin({ bottom: 4 })

                Row() {
                  Text(`¥${product.price}`)
                    .fontSize(14).fontWeight(FontWeight.Bold).fontColor('#FF6B35')
                  Text(`¥${product.oldPrice}`)
                    .fontSize(10).fontColor('#999999')
                    .decoration({ type: TextDecorationType.LineThrough })
                    .margin({ left: 4 })
                }
                .margin({ bottom: 4 })

                Row() {
                  Image(product.storeIcon).width(14).height(14).borderRadius(2).margin({ right: 4 })
                  Text(product.storeName)
                    .fontSize(10).fontColor('#666666')
                    .maxLines(1)
                    .textOverflow({ overflow: TextOverflow.Ellipsis })
                    .layoutWeight(1)
                }
              }
              .width('100%')
              .padding(8)
              .alignItems(HorizontalAlign.Start)
            }
            .backgroundColor(Color.White)
            .borderRadius(8)
            .onClick(() => {
              router.pushUrl({ 
                url: 'pages/store/ProductDetailPage',
                params: { productIndex: index }
              })
            })
          }
        })
      }
      .columnsTemplate('1fr 1fr')
      .columnsGap(10)
      .rowsGap(10)
      .padding({ left: 12, right: 12, bottom: 20 })
    }
    .width('100%')
  }

  // 自定义 Tab 样式组件
  @Builder RecTabItem(title: string, subTitle: string, index: number) {
    Column() {
      Text(title)
        .fontSize(15)
        .fontWeight(this.currentRecTab === index ? FontWeight.Bold : FontWeight.Normal)
        .fontColor(this.currentRecTab === index ? '#333333' : '#666666')
        .margin({ bottom: 4 })

      Text(subTitle)
        .fontSize(11)
        .fontColor(this.currentRecTab === index ? '#10C8A7' : '#999999')

      // 激活状态的底部绿线指示器
      if (this.currentRecTab === index) {
        Rect({ width: 24, height: 2 }).fill('#10C8A7').radius(1).margin({ top: 4 })
      }
    }
    .layoutWeight(1)
    .alignItems(HorizontalAlign.Center)
    .onClick(() => {
      this.currentRecTab = index;
    })
  }
}