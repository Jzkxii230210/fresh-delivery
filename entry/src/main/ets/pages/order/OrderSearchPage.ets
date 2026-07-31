import router from '@ohos.router';
import { ORDERS, OrderData } from '../../common/HomeData';

@Entry
@Component
struct OrderSearchPage {
  @State searchQuery: string = '';
  @State isResultMode: boolean = false;
  @State searchResults: OrderData[] = [];

  private searchHistory: string[] = ['五常米', '天虹商场', '水豆腐', '广州酒家', '本地鸡蛋', '本地白菜', '关键词语', '搜索关键词', '关键词'];

  // 搜索订单
  searchOrders(query: string) {
    if (!query.trim()) {
      this.searchResults = [];
      return;
    }
    const keyword = query.toLowerCase();
    this.searchResults = ORDERS.filter((order: OrderData) => {
      // 搜索商家名称
      if (order.storeName.toLowerCase().includes(keyword)) {
        return true;
      }
      // 搜索商品名称
      for (const product of order.products) {
        if (product.name.toLowerCase().includes(keyword)) {
          return true;
        }
      }
      return false;
    });
  }

  build() {
    Column() {
      // === 1. 顶部搜索导航栏 ===
      Row() {
        Image($r('app.media.back')) // 返回按钮
          .width(20)
          .height(20)
          .margin({ right: 12 })
          .onClick(() => {
            if (this.isResultMode) {
              this.isResultMode = false;
            } else {
              router.back();
            }
          })

        // 搜索输入框
        Row() {
          Image($r('app.media.search')).width(16).height(16).margin({ right: 8 })

          TextInput({ placeholder: '搜索订单号/关键词' })
            .layoutWeight(1)
            .height(36)
            .backgroundColor(Color.Transparent)
            .fontSize(14)
            .padding(0)
            .onChange((value: string) => {
              this.searchQuery = value;
            })
            .onSubmit(() => {
              if (this.searchQuery.trim() !== '') {
                this.isResultMode = true;
              }
            })

          if (this.isResultMode && this.searchQuery !== '') {
            Image($r('app.media.quxiao'))
              .width(16)
              .height(16)
              .margin({ left: 8 })
              .onClick(() => {
                this.searchQuery = '';
                this.isResultMode = false;
              })
          }
        }
        .layoutWeight(1)
        .height(36)
        .backgroundColor(this.isResultMode ? Color.White : '#F5F5F5')
        .borderRadius(18)
        .padding({ left: 12, right: 12 })
        .border({ width: this.isResultMode ? 1 : 0, color: '#10C8A7' })

        if (!this.isResultMode) {
          Text('搜索')
            .fontSize(15)
            .fontColor('#10C8A7')
            .margin({ left: 12 })
            .onClick(() => {
              if (this.searchQuery.trim() !== '') {
                this.isResultMode = true;
                this.searchOrders(this.searchQuery);
              }
            })
        }
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 16, bottom: 12 })
      .backgroundColor(Color.White)

      // === 2. 动态内容区 ===
      if (!this.isResultMode) {
        // --- 历史搜索模式 ---
        Stack({ alignContent: Alignment.Bottom }) {
          Column() {
            Row() {
              Text('历史搜索')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor('#333333')
              Blank()
              Image($r('app.media.shanchu')).width(16).height(16)
            }
            .width('100%')
            .padding({ left: 16, right: 16, top: 16, bottom: 16 })

            Flex({ wrap: FlexWrap.Wrap }) {
              ForEach(this.searchHistory, (item: string) => {
                Text(item)
                  .fontSize(13)
                  .fontColor('#666666')
                  .backgroundColor('#F5F5F5')
                  .padding({ left: 14, right: 14, top: 6, bottom: 6 })
                  .borderRadius(16)
                  .margin({ right: 10, bottom: 12 })
                  .onClick(() => {
                    this.searchQuery = item;
                    this.isResultMode = true;
                    this.searchOrders(item);
                  })
              })
            }
            .padding({ left: 16, right: 16 })
            .width('100%')
          }
          .width('100%')
          .height('100%')
          .backgroundColor(Color.White)
        }


      } else {
        // --- 搜索结果模式 (展示订单卡片) ---
        Scroll() {
          Column() {
            if (this.searchResults.length > 0) {
              List({ space: 12 }) {
                ForEach(this.searchResults, (order: OrderData) => {
                  ListItem() {
                    this.OrderResultCard(order)
                  }
                })
              }
              .width('92%')
              .padding({ top: 12, bottom: 20 })
            } else {
              // 无搜索结果
              Column() {
                Text('暂无搜索结果')
                  .fontSize(14)
                  .fontColor('#999999')
                  .margin({ top: 100 })
              }
              .width('100%')
              .height('100%')
              .justifyContent(FlexAlign.Center)
            }
          }
          .width('100%')
        }
        .layoutWeight(1)
        .backgroundColor('#F8F8F8')
        .scrollBar(BarState.Off)
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }

  // --- 复用订单结果卡片 ---
  @Builder OrderResultCard(order: OrderData) {
    Column() {
      Row() {
        Row() {
          Image(order.storeIcon).width(16).height(16).borderRadius(2).margin({ right: 6 })
          Text(order.storeName).fontSize(14).fontWeight(FontWeight.Bold).fontColor('#333333')
        }
        Blank()
        Text(order.status).fontSize(13).fontColor('#666666').fontWeight(FontWeight.Medium)
      }
      .width('100%')
      .margin({ bottom: 12 })

      Row() {
        Image(order.products[0].image).width(60).height(60).borderRadius(6).margin({ right: 10 })
        Column() {
          Text(order.products[0].name).fontSize(14).fontColor('#333333').fontWeight(FontWeight.Medium).margin({ bottom: 6 })
          Text('¥ ' + order.products[0].price).fontSize(14).fontColor('#333333')
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)

        Text('x' + order.products[0].quantity).fontSize(13).fontColor('#999999')
      }
      .width('100%')
      .margin({ bottom: 12 })

      Row() {
        Blank()
        Row({ space: 4 }) {
          Text('共' + order.products.reduce((sum: number, p) => sum + p.quantity, 0) + '件').fontSize(12).fontColor('#666666')
          Text('实付').fontSize(12).fontColor('#666666')
          Text('¥ ' + order.totalPrice).fontSize(15).fontColor('#333333').fontWeight(FontWeight.Bold)
        }
      }
      .width('100%')
      .margin({ bottom: 12 })

      Divider().color('#F0F0F0').strokeWidth(0.5).margin({ bottom: 12 })

      Row() {
        Blank()
        Button(order.btnText)
          .width(88)
          .height(30)
          .backgroundColor(Color.White)
          .fontColor('#10C8A7')
          .border({ width: 0.5, color: '#10C8A7' })
          .fontSize(13)
          .borderRadius(15)
      }
      .width('100%')
    }
    .width('100%')
    .backgroundColor(Color.White)
    .borderRadius(12)
    .padding(16)
    .onClick(() => {
      router.pushUrl({ url: 'pages/order/OrderDetailPage', params: { orderId: order.id } });
    })
  }
}