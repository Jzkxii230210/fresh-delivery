import router from '@ohos.router';
import { ORDERS, OrderData, OrderProduct, NEARBY_SHOPS } from '../../common/HomeData';
import { CancelOrderDialog } from '../../views/components/CancelOrderDialog';

@Entry
@Component
struct OrderDetailPage {
  // 订单ID参数
  @State orderId: string = '';
  // 当前订单数据
  @State order: OrderData = ORDERS[0];

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

  aboutToAppear() {
    // 获取路由传递的订单ID参数
    const params = router.getParams() as Record<string, Object>;
    if (params && params['orderId']) {
      this.orderId = params['orderId'] as string;
      // 根据订单ID查找对应的订单数据
      const foundOrder = ORDERS.find((item: OrderData) => item.id === this.orderId);
      if (foundOrder) {
        this.order = foundOrder;
      }
    }
  }

  build() {
    Column() {
      // === 1. 顶部绿色导航栏 ===
      Row() {
        Image($r('app.media.back'))
          .width(20).height(20).margin({ right: 12 })
          .onClick(() => { router.back(); })

        Text('订单详情')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Image($r('app.media.fenxiang')).width(20).height(20) // 右上角分享/扩展图标
      }
      .width('100%')
      .height(50)
      .padding({ left: 16, right: 16 })
      .backgroundColor('#10C8A7')

      // === 2. 滚动详情区 ===
      Scroll() {
        Column() {
          // --- 顶部状态提示卡片 (根据 order.statusType 动态渲染) ---
          Column() {
            Row() {
              Text(this.getStatusTitle())
                .fontSize(18)
                .fontWeight(FontWeight.Bold)
                .fontColor('#333333')
                .onClick(() => {
                  router.pushUrl({ url: 'pages/order/OrderTrackPage', params: { orderId: this.order.id } });
                })
            }
            .margin({ bottom: 8 })

            Text(this.getStatusDesc())
              .fontSize(13)
              .fontColor('#666666')
              .margin({ bottom: 16 })

            // 动态按钮组
            Row({ space: 12 }) {
              if (this.order.statusType === 'wait') {
                Button('取消订单')
                  .width(100).height(34).backgroundColor(Color.White).fontColor('#10C8A7')
                  .border({ width: 1, color: '#10C8A7' }).fontSize(13).borderRadius(17)
                  .onClick(() => {
                    // 显示取消订单弹窗
                    this.cancelDialogController.open();
                  })
                Button('联系客服')
                  .width(100).height(34).backgroundColor(Color.White).fontColor('#666666')
                  .border({ width: 1, color: '#CCCCCC' }).fontSize(13).borderRadius(17)
                  .onClick(() => {
                    router.pushUrl({ url: 'pages/mine/HelpCenterPage' });
                  })
              } else if (this.order.statusType === 'finished' || this.order.statusType === 'closed') {
                Button('再次购买')
                  .width(100).height(34).backgroundColor('#10C8A7').fontColor(Color.White)
                  .fontSize(13).borderRadius(17)
                  .onClick(() => {
                    // 根据商家名称找到对应的商家索引，跳转到商家详情页
                    const shopIndex = this.findShopIndex(this.order.storeName);
                    router.pushUrl({ 
                      url: 'pages/store/StoreHomePage',
                      params: { shopIndex: shopIndex }
                    });
                  })
                Button('联系客服')
                  .width(100).height(34).backgroundColor(Color.White).fontColor('#666666')
                  .border({ width: 1, color: '#CCCCCC' }).fontSize(13).borderRadius(17)
                  .onClick(() => {
                    router.pushUrl({ url: 'pages/mine/HelpCenterPage' });
                  })
              } else if (this.order.statusType === 'refund') {
                // 退款订单只显示两个按钮：查看退款和再次购买
                Button('查看退款')
                  .width(100).height(34).backgroundColor(Color.White).fontColor('#666666')
                  .border({ width: 1, color: '#CCCCCC' }).fontSize(13).borderRadius(17)
                  .onClick(() => {
                    // 跳转到退款详情页
                    router.pushUrl({ 
                      url: 'pages/order/RefundDetailPage',
                      params: { orderId: this.order.id }
                    });
                  })
                Button('再次购买')
                  .width(100).height(34).backgroundColor('#10C8A7').fontColor(Color.White)
                  .fontSize(13).borderRadius(17)
                  .onClick(() => {
                    // 根据商家名称找到对应的商家索引，跳转到商家详情页
                    const shopIndex = this.findShopIndex(this.order.storeName);
                    router.pushUrl({ 
                      url: 'pages/store/StoreHomePage',
                      params: { shopIndex: shopIndex }
                    });
                  })
              }
            }
          }
          .width('92%')
          .backgroundColor(Color.White)
          .borderRadius(12)
          .padding(16)
          .margin({ top: 12, bottom: 12 })

          // --- 骑手配送信息卡片 (仅在已完成/配送时显示) ---
          if (this.order.statusType === 'finished') {
            Row() {
              Image($r('app.media.startIcon')).width(40).height(40).borderRadius(20).margin({ right: 12 })
              Column() {
                Text('张**').fontSize(14).fontWeight(FontWeight.Bold).fontColor('#333333').margin({ bottom: 2 })
                Text('达达快递').fontSize(11).fontColor('#007DFF').backgroundColor('#E5F2FF').padding({ left: 4, right: 4 }).borderRadius(2)
              }
              .alignItems(HorizontalAlign.Start)
              Blank()
              Row({ space: 4 }) {
                Image($r('app.media.startIcon')).width(16).height(16)
                Text('呼叫').fontSize(13).fontColor('#10C8A7')
              }
              .padding({ left: 12, right: 12, top: 6, bottom: 6 })
              .border({ width: 0.5, color: '#10C8A7' })
              .borderRadius(16)
            }
            .width('92%')
            .backgroundColor(Color.White)
            .borderRadius(12)
            .padding(14)
            .margin({ bottom: 12 })
          }

          // --- 商品清单与费用明细卡片 ---
          Column() {
            Row() {
              Image(this.order.storeIcon).width(16).height(16).borderRadius(2).margin({ right: 6 })
              Text(this.order.storeName).fontSize(14).fontWeight(FontWeight.Bold).fontColor('#333333')
            }
            .width('100%')
            .margin({ bottom: 12 })

            // 商品列表
            ForEach(this.order.products, (product: OrderProduct) => {
              this.ProductItem(product)
            })

            // 退款到账提示（仅退款订单显示）
            if (this.order.statusType === 'refund') {
              Row() {
                Text('退款到账')
                  .fontSize(14)
                  .fontColor('#FFA500')
                  .fontWeight(FontWeight.Medium)
              }
              .width('100%')
              .margin({ top: 8, bottom: 8 })
            }

            Divider().color('#F0F0F0').strokeWidth(0.5).margin({ top: 8, bottom: 12 })

            // 费用明细
            this.FeeRow('运费', '￥4')
            this.FeeRow('时段运费', '￥2')
            this.FeeRow('包装费', '￥1.2')
            this.FeeRow('优惠券', '-￥3', true)
            this.FeeRow('红包', '-￥5', true)

            Divider().color('#F0F0F0').strokeWidth(0.5).margin({ top: 8, bottom: 12 })

            // 实付金额
            Row() {
              Text('共节省 ¥8').fontSize(12).fontColor('#FF4D4F')
              Blank()
              Text('实付金额：').fontSize(13).fontColor('#333333')
              Text('￥ ' + this.order.totalPrice).fontSize(18).fontColor('#FF4D4F').fontWeight(FontWeight.Bold)
            }
            .width('100%')
            .margin({ bottom: 12 })

            Divider().color('#F0F0F0').strokeWidth(0.5).margin({ bottom: 12 })

            Row() {
              Image($r('app.media.lianxi')).width(16).height(16).margin({ right: 6 })
              Text('联系商家').fontSize(13).fontColor('#333333')
            }
            .width('100%')
            .justifyContent(FlexAlign.Center)
          }
          .width('92%')
          .backgroundColor(Color.White)
          .borderRadius(12)
          .padding(14)
          .margin({ bottom: 12 })

          // --- 配送信息与订单信息卡片 ---
          Column() {
            this.InfoBlockTitle('配送信息')
            this.InfoRow('送达时间：', '立即送达 05月12日 14:20-15:20')
            this.InfoRow('收货地址：', '张小乙 136****5678\n深圳市龙华区凤凰大道龙岭十二区38栋')
            this.InfoRow('配送方式：', '达达快递')

            Divider().color('#F0F0F0').strokeWidth(0.5).margin({ top: 8, bottom: 12 })

            this.InfoBlockTitle('订单信息')
            this.InfoRow('订单号码：', this.order.id)
            this.InfoRow('下单时间：', this.order.createTime)
            this.InfoRow('支付方式：', '微信支付')
            this.InfoRow('订单备注：', '其他商品继续配送（缺货商品退款）')
          }
          .width('92%')
          .backgroundColor(Color.White)
          .borderRadius(12)
          .padding(14)
          .margin({ bottom: 30 })
        }
      }
      .scrollBar(BarState.Off)
      .layoutWeight(1)
      .backgroundColor('#F8F8F8')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8F8F8')
  }

  // --- 辅助 Builder ---
  getStatusTitle(): string {
    if (this.order.statusType === 'wait') return this.order.status + ' >';
    if (this.order.statusType === 'finished') return '订单已完成 >';
    if (this.order.statusType === 'closed') return '订单已关闭 >';
    return '订单已关闭 >'; // 退款订单也显示"订单已关闭"
  }

  getStatusDesc(): string {
    if (this.order.statusType === 'wait') return '订单已付款，请耐心等待商家接单';
    if (this.order.statusType === 'finished') return '感谢你使用小默买菜';
    if (this.order.statusType === 'closed') return '期待你再次使用小默买菜';
    return '期待你再次使用小默买菜'; // 退款订单也显示相同描述
  }

  @Builder ProductItem(product: OrderProduct) {
    Row() {
      Image(product.image).width(50).height(50).borderRadius(6).margin({ right: 10 })
      Column() {
        Text(product.name).fontSize(13).fontColor('#333333').fontWeight(FontWeight.Medium).margin({ bottom: 4 })
        Text(`￥${product.price}  x${product.quantity}`).fontSize(12).fontColor('#666666')
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      Text('￥' + (parseFloat(product.price) * product.quantity).toFixed(2)).fontSize(13).fontColor('#333333').fontWeight(FontWeight.Medium)
    }
    .width('100%')
    .margin({ bottom: 10 })
  }

  @Builder FeeRow(label: string, val: string, isRed: boolean = false) {
    Row() {
      Text(label).fontSize(12).fontColor('#666666')
      Blank()
      Text(val).fontSize(12).fontColor(isRed ? '#FF4D4F' : '#333333')
    }
    .width('100%')
    .margin({ bottom: 8 })
  }

  @Builder InfoBlockTitle(title: string) {
    Text(title)
      .fontSize(14)
      .fontWeight(FontWeight.Bold)
      .fontColor('#333333')
      .width('100%')
      .margin({ bottom: 10 })
  }

  @Builder InfoRow(label: string, val: string) {
    Row() {
      Text(label).fontSize(12).fontColor('#666666').width(75)
      Text(val).fontSize(12).fontColor('#333333').layoutWeight(1).lineHeight(16)
    }
    .width('100%')
    .margin({ bottom: 8 })
    .alignItems(VerticalAlign.Top)
  }
}
