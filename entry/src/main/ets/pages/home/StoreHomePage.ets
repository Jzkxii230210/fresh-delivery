import router from '@ohos.router';

/**
 * 首页 - 生鲜配送主页
 */
@Entry
@Component
export struct StoreHomePage {
  // 搜索关键词
  @State searchKeyword: string = '';
  // 当前定位
  private location: string = '天虹商场(沙河店)';
  // 模拟轮播图数据
  private bannerList: number[] = [1, 2, 3];
  // 模拟分类数据
  private categories: string[] = ['水果', '蔬菜', '肉禽蛋', '海鲜', '粮油', '乳品', '酒水', '零食'];
  // 模拟推荐商品
  private recommendProducts: number[] = [1, 2, 3, 4, 5, 6];

  build() {
    Column() {
      // === 1. 顶部导航栏 ===
      Row() {
        // 定位信息
        Row() {
          Image($r('app.media.startIcon'))
            .width(16)
            .height(16)
            .margin({ right: 4 })
          
          Text(this.location)
            .fontSize(12)
            .fontColor('#333333')
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
          
          Image($r('app.media.startIcon'))
            .width(12)
            .height(12)
            .margin({ left: 4 })
        }
        .layoutWeight(1)
        .onClick(() => {
          // TODO: 跳转定位选择页
        })

        // 搜索框
        Row() {
          Image($r('app.media.startIcon'))
            .width(16)
            .height(16)
            .margin({ right: 8 })
          
          Text('搜索商品')
            .fontSize(12)
            .fontColor('#999999')
        }
        .layoutWeight(2)
        .height(32)
        .backgroundColor('#F5F5F5')
        .borderRadius(16)
        .padding({ left: 12, right: 12 })
        .onClick(() => {
          router.pushUrl({ url: 'pages/home/SearchPage' });
        })

        // 消息图标
        Badge({ count: 3, position: BadgePosition.RightTop, style: { badgeSize: 16, badgeColor: '#FF4D4F' } }) {
          Image($r('app.media.startIcon'))
            .width(24)
            .height(24)
        }
        .margin({ left: 12 })
        .onClick(() => {
          router.pushUrl({ url: 'pages/message/MessageCenterPage' });
        })
      }
      .width('100%')
      .height(50)
      .padding({ left: 12, right: 12 })
      .backgroundColor(Color.White)

      // === 2. 滚动内容区 ===
      Scroll() {
        Column() {
          // --- 轮播图 ---
          Swiper() {
            ForEach(this.bannerList, (item: number) => {
              Image($r('app.media.startIcon'))
                .width('100%')
                .height(150)
                .objectFit(ImageFit.Cover)
            })
          }
          .autoPlay(true)
          .interval(3000)
          .indicator(true)
          .loop(true)
          .width('100%')
          .height(150)
          .borderRadius(8)
          .margin({ top: 12 })

          // --- 快捷分类入口 ---
          Row() {
            ForEach(this.categories, (category: string, index: number) => {
              Column() {
                Image($r('app.media.startIcon'))
                  .width(40)
                  .height(40)
                  .borderRadius(20)
                
                Text(category)
                  .fontSize(10)
                  .fontColor('#333333')
                  .margin({ top: 4 })
              }
              .layoutWeight(1)
              .onClick(() => {
                router.pushUrl({ url: 'pages/home/CategoryListPage' });
              })
            })
          }
          .width('100%')
          .padding({ top: 16, bottom: 16 })
          .backgroundColor(Color.White)
          .borderRadius(8)
          .margin({ top: 12 })

          // --- 附近商家 ---
          Column() {
            Row() {
              Text('附近商家')
                .fontSize(16)
                .fontWeight(FontWeight.Bold)
                .fontColor('#333333')
              
              Blank()
              
              Row() {
                Text('查看更多')
                  .fontSize(12)
                  .fontColor('#999999')
                
                Image($r('app.media.startIcon'))
                  .width(12)
                  .height(12)
                  .margin({ left: 4 })
              }
              .onClick(() => {
                router.pushUrl({ url: 'pages/home/NearbyShopPage' });
              })
            }
            .width('100%')
            .padding({ left: 12, right: 12, top: 12, bottom: 12 })

            // 商家列表
            ForEach([1, 2, 3], (item: number) => {
              this.ShopItem()
            })
          }
          .width('100%')
          .backgroundColor(Color.White)
          .borderRadius(8)
          .margin({ top: 12 })

          // --- 推荐商品 ---
          Column() {
            Row() {
              Text('为你推荐')
                .fontSize(16)
                .fontWeight(FontWeight.Bold)
                .fontColor('#333333')
            }
            .width('100%')
            .padding({ left: 12, right: 12, top: 12, bottom: 12 })

            // 商品网格
            Grid() {
              ForEach(this.recommendProducts, (item: number) => {
                GridItem() {
                  this.ProductItem()
                }
              })
            }
            .columnsTemplate('1fr 1fr')
            .rowsGap(12)
            .columnsGap(12)
            .width('100%')
            .padding({ left: 12, right: 12, bottom: 12 })
          }
          .width('100%')
          .backgroundColor(Color.White)
          .borderRadius(8)
          .margin({ top: 12, bottom: 12 })
        }
        .width('100%')
        .padding({ left: 12, right: 12 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }

  // 商家卡片组件
  @Builder
  ShopItem() {
    Row() {
      Image($r('app.media.startIcon'))
        .width(60)
        .height(60)
        .borderRadius(8)
        .margin({ right: 12 })

      Column() {
        Text('永辉超市(沙河店)')
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')

        Row() {
          Text('4.8分')
            .fontSize(10)
            .fontColor('#FF9500')

          Text('月售1.2k')
            .fontSize(10)
            .fontColor('#999999')
            .margin({ left: 8 })

          Text('1.2km')
            .fontSize(10)
            .fontColor('#999999')
            .margin({ left: 8 })
        }
        .margin({ top: 4 })

        Text('满58减5 | 新人专享')
          .fontSize(10)
          .fontColor('#FF4D4F')
          .margin({ top: 4 })
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      Image($r('app.media.startIcon'))
        .width(20)
        .height(20)
    }
    .width('100%')
    .padding(12)
    .backgroundColor(Color.White)
    .onClick(() => {
      router.pushUrl({ url: 'pages/store/ProductDetailPage' });
    })
  }

  // 商品卡片组件
  @Builder
  ProductItem() {
    Column() {
      Image($r('app.media.startIcon'))
        .width('100%')
        .height(120)
        .objectFit(ImageFit.Cover)
        .borderRadius({ topLeft: 8, topRight: 8 })

      Column() {
        Text('新鲜红富士苹果 5斤装')
          .fontSize(12)
          .fontColor('#333333')
          .maxLines(2)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Row() {
          Text('¥')
            .fontSize(10)
            .fontColor('#FF4D4F')

          Text('29.9')
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FF4D4F')

          Text('¥39.9')
            .fontSize(10)
            .fontColor('#999999')
            .decoration({ type: TextDecorationType.LineThrough })
            .margin({ left: 4 })
        }
        .margin({ top: 4 })
      }
      .padding(8)
      .alignItems(HorizontalAlign.Start)
    }
    .backgroundColor(Color.White)
    .borderRadius(8)
    .onClick(() => {
      router.pushUrl({ url: 'pages/store/ProductDetailPage' });
    })
  }
}
