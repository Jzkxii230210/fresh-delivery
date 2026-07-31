import router from '@ohos.router';
import { ORDERS, OrderData, FREQUENT_SHOPS, FrequentShop, NEARBY_SHOPS } from '../../common/HomeData';
import { CancelOrderDialog } from '../../views/components/CancelOrderDialog';
import { ConfirmReceiptDialog } from '../../views/components/ConfirmReceiptDialog';

@Entry
@Component
export struct OrderListPage {
  // 当前选中的订单状态 Tab 索引 (0:全部, 1:待付款, 2:待配送, 3:待收货, 4:待评价)
  @State currentOrderTab: number = 0;
  // 当前正在展示的订单列表数据
  @State currentOrders: OrderData[] = [];

  private tabs: string[] = ['全部', '待付款', '待配送', '待收货', '待评价'];

  // 根据商家名称查找商家索引
  private findShopIndex(storeName: string): number {
    const index = NEARBY_SHOPS.findIndex(shop => shop.name === storeName);
    return index >= 0 ? index : 0; // 如果找不到，默认返回第一个商家
  }

  // 取消订单弹窗控制器
  private cancelDialogController: CustomDialogController = new CustomDialogController({
    builder: CancelOrderDialog({
      onConfirm: () => {
        // TODO: 执行取消订单逻辑
        console.info('订单已取消');
      }
    }),
    customStyle: true,
    alignment: DialogAlignment.Center
  });

  // 确认收货弹窗控制器
  private confirmReceiptDialogController: CustomDialogController = new CustomDialogController({
    builder: ConfirmReceiptDialog({
      onConfirm: () => {
        // TODO: 执行确认收货逻辑
        console.info('订单已确认收货');
      }
    }),
    customStyle: true,
    alignment: DialogAlignment.Center
  });

  aboutToAppear() {
    // 页面初始化时加载全部订单
    this.updateOrderData();
  }

  // 根据当前选中的 Tab 索引，动态获取对应的订单数据
  updateOrderData() {
    switch (this.currentOrderTab) {
      case 1: // 待付款
        this.currentOrders = ORDERS.filter(o => o.status === '待付款');
        break;
      case 2: // 待配送
        this.currentOrders = ORDERS.filter(o => o.status === '待商家接单');
        break;
      case 3: // 待收货
        this.currentOrders = ORDERS.filter(o => o.status === '配送中');
        break;
      case 4: // 待评价
        this.currentOrders = ORDERS.filter(o => o.status === '已送达');
        break;
      case 0: // 全部
      default:
        this.currentOrders = ORDERS;
        break;
    }
  }

  build() {
    Column() {
      // === 1. 顶部标题栏、搜索与消息 ===
      Column() {
        Row() {
          Text('订单')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#333333')

          Blank()

          // 搜索框
          Row() {
            Image($r('app.media.search')).width(14).height(14).margin({ right: 6 })
            Text('搜索订单号/关键词').fontSize(12).fontColor('#999999')
          }
          .width(180)
          .height(32)
          .backgroundColor('#F5F5F5')
          .borderRadius(16)
          .padding({ left: 10 })
          .margin({ right: 12 })
          .onClick(() => {
            router.pushUrl({ url: 'pages/order/OrderSearchPage' })
          })

          // 消息通知图标带红点
          Stack({ alignContent: Alignment.TopEnd }) {
            Image($r('app.media.message')).width(22).height(22).margin({ top: 4, right: 4 })
            Circle({ width: 8, height: 8 }).fill('#FF4D4F')
          }
          .onClick(() => {
            router.pushUrl({ url: 'pages/message/ProblemCenterPage' });
          })
        }
        .width('100%')
        .height(50)
        .padding({ left: 16, right: 16 })

        // 订单状态 Tab 栏
        Row() {
          ForEach(this.tabs, (item: string, index: number) => {
            Column() {
              Text(item)
                .fontSize(14)
                .fontWeight(this.currentOrderTab === index ? FontWeight.Bold : FontWeight.Normal)
                .fontColor(this.currentOrderTab === index ? '#10C8A7' : '#666666')
                .margin({ bottom: 6 })

              Divider()
                .color(this.currentOrderTab === index ? '#10C8A7' : Color.Transparent)
                .strokeWidth(2.5)
                .width(18)
                .lineCap(LineCapStyle.Round)
            }
            .layoutWeight(1)
            .onClick(() => {
              // 切换状态并更新底部列表数据
              this.currentOrderTab = index;
              this.updateOrderData();
            })
          })
        }
        .width('100%')
        .padding({ top: 4 })
      }
      .width('100%')
      .backgroundColor(Color.White)

      // === 2. 订单列表滚动区 (已修复嵌套滚动空白 Bug) ===
      // 【关键修改】：将外层的 Scroll 移除，直接使用 List 作为唯一的纵向滚动容器
      List() {

        // --- 模块 A：经常光顾商家横向推荐区 ---
        ListItem() {
          Column() {
            Row() {
              Text('经常光顾').fontSize(14).fontWeight(FontWeight.Bold).fontColor('#333333')
              Blank()
              Text('查看更多 >').fontSize(12).fontColor('#999999')
            }
            .width('100%')
            .padding({ left: 16, right: 16, top: 12, bottom: 8 })

            List({ space: 12 }) {
              ListItem().margin({ left: 16 })
              ForEach(FREQUENT_SHOPS, (shop: FrequentShop) => {
                ListItem() {
                  Column() {
                    Image(shop.icon).width(48).height(48).borderRadius(24).margin({ bottom: 4 })
                    Text(shop.name).fontSize(10).fontColor('#333333').maxLines(1).textOverflow({ overflow: TextOverflow.Ellipsis })
                  }
                  .width(56)
                  .onClick(() => {
                    // 根据商家名称找到对应的商家索引，跳转到商家详情页
                    const shopIndex = this.findShopIndex(shop.name);
                    router.pushUrl({ 
                      url: 'pages/store/StoreHomePage',
                      params: { shopIndex: shopIndex }
                    });
                  })
                }
              })
              ListItem().margin({ right: 16 })
            }
            .listDirection(Axis.Horizontal)
            .scrollBar(BarState.Off)
            .width('100%')
            .height(80)
          }
          .backgroundColor(Color.White)
          .margin({ bottom: 12 })
        }

        // --- 模块 B：动态订单列表卡片 ---
        if (this.currentOrders.length > 0) {
          ForEach(this.currentOrders, (order: OrderData) => {
            ListItem() {
              this.OrderCard(order)
            }
            .margin({ left: 16, right: 16, bottom: 12 }) // 替代原来的 92% 宽度，完美撑满居中
            .onClick(() => {
              router.pushUrl({ url: 'pages/order/OrderDetailPage', params: { orderId: order.id } });
            })
          }, (item: OrderData) => item.id)
        } else {
          // 空状态提示
          ListItem() {
            Column() {
              Image($r('app.media.startIcon'))
                .width(120).height(120).opacity(0.3).margin({ bottom: 16, top: 40 })
              Text('暂无相关订单')
                .fontSize(14).fontColor('#999999')
            }
            .width('100%')
            .alignItems(HorizontalAlign.Center)
          }
        }

        // 底部留白，防止被 TabBar 遮挡
        ListItem() {
          Row().width('100%').height(40)
        }
      }
      .scrollBar(BarState.Off)
      .layoutWeight(1) // 占满剩余高度
      .backgroundColor('#F8F8F8')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8F8F8')
  }

  // --- 局部复用组件：单个订单卡片 ---
  @Builder OrderCard(order: OrderData) {
    Column() {
      // 1. 卡片头部：店铺名称与订单状态
      Row() {
        Row() {
          Image(order.storeIcon).width(16).height(16).borderRadius(2).margin({ right: 6 })
          Text(order.storeName).fontSize(14).fontWeight(FontWeight.Bold).fontColor('#333333')
        }

        Blank()

        // 根据状态动态调整颜色
        Text(order.statusType === 'refund' ? '已关闭' : order.status)
          .fontSize(13)
          .fontColor(['待付款', '待商家接单', '配送中', '待评价', '已送达'].includes(order.status) ? '#FF8C00' : '#666666')
          .fontWeight(FontWeight.Medium)
      }
      .width('100%')
      .margin({ bottom: 12 })

      // 2. 商品缩略信息行
      Row() {
        Image(order.products[0].image)
          .width(60)
          .height(60)
          .borderRadius(6)
          .margin({ right: 10 })

        Column() {
          Text(order.products[0].name)
            .fontSize(14)
            .fontColor('#333333')
            .fontWeight(FontWeight.Medium)
            .margin({ bottom: 6 })

          Text('¥ ' + order.products[0].price)
            .fontSize(14)
            .fontColor('#333333')
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)

        Text('x' + order.products[0].quantity)
          .fontSize(13)
          .fontColor('#999999')
      }
      .width('100%')
      .margin({ bottom: 12 })

      // 3. 价格合计行
      Row() {
        Blank()
        Row({ space: 4 }) {
          Text('共' + order.products.reduce((sum, p) => sum + p.quantity, 0) + '件').fontSize(12).fontColor('#666666')
          Text('实付').fontSize(12).fontColor('#666666')
          Text('¥ ' + order.totalPrice).fontSize(15).fontColor('#333333').fontWeight(FontWeight.Bold)
        }
      }
      .width('100%')
      .margin({ bottom: 12 })

      // 退款到账提示（仅退款订单显示）
      if (order.statusType === 'refund') {
        Row() {
          Text('退款到账')
            .fontSize(13)
            .fontColor('#FFA500')
            .fontWeight(FontWeight.Medium)
        }
        .width('100%')
        .margin({ bottom: 8 })
      }

      Divider().color('#F0F0F0').strokeWidth(0.5).margin({ bottom: 12 })

      // 4. 底部操作按钮行
      Row({ space: 8 }) {
        Blank()
        // 退款订单显示两个按钮
        if (order.statusType === 'refund') {
          Button('查看退款')
            .width(88)
            .height(30)
            .backgroundColor(Color.White)
            .fontColor('#666666')
            .border({ width: 0.5, color: '#CCCCCC' })
            .fontSize(13)
            .borderRadius(15)
            .onClick(() => {
              // 跳转到退款详情页
              router.pushUrl({ 
                url: 'pages/order/RefundDetailPage',
                params: { orderId: order.id }
              });
            })
          Button('再次购买')
            .width(88)
            .height(30)
            .backgroundColor(Color.White)
            .fontColor('#10C8A7')
            .border({ width: 0.5, color: '#10C8A7' })
            .fontSize(13)
            .borderRadius(15)
            .onClick(() => {
              // 根据商家名称找到对应的商家索引，跳转到商家详情页
              const shopIndex = this.findShopIndex(order.storeName);
              router.pushUrl({ 
                url: 'pages/store/StoreHomePage',
                params: { shopIndex: shopIndex }
              });
            })
        } else {
          // 其他订单显示单个按钮
          Button(order.btnText)
            .width(88)
            .height(30)
            .backgroundColor(Color.White)
            .fontColor(order.btnText === '取消订单' ? '#666666' : '#10C8A7')
            .border({ width: 0.5, color: order.btnText === '取消订单' ? '#CCCCCC' : '#10C8A7' })
            .fontSize(13)
            .borderRadius(15)
            .onClick(() => {
              // 根据按钮文本执行不同操作
              if (order.btnText === '去支付') {
                // 跳转到支付页面
                router.pushUrl({ 
                  url: 'pages/order/CheckoutPage',
                  params: { orderId: order.id }
                });
              } else if (order.btnText === '取消订单') {
                // 显示取消订单弹窗
                this.cancelDialogController.open();
              } else if (order.btnText === '再次购买') {
                // 根据商家名称找到对应的商家索引，跳转到商家详情页
                const shopIndex = this.findShopIndex(order.storeName);
                router.pushUrl({ 
                  url: 'pages/store/StoreHomePage',
                  params: { shopIndex: shopIndex }
                });
              } else if (order.btnText === '去评价') {
                // 跳转到评价页面
                router.pushUrl({ 
                  url: 'pages/cart/CartReviewsPage'
                });
              } else if (order.btnText === '确认收货') {
                // 显示确认收货弹窗
                this.confirmReceiptDialogController.open();
              }
            })
        }
      }
      .width('100%')
    }
    .width('100%')
    .backgroundColor(Color.White)
    .borderRadius(12)
    .padding(14)
  }
}