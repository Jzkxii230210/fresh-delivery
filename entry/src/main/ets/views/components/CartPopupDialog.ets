import promptAction from '@ohos.promptAction';
import router from '@ohos.router';

// 购物车商品项接口
interface CartItem {
  name: string;
  price: string;
  qty: number;
  image: Resource;
}

// === 1. 购物车底部弹窗组件 ===
@CustomDialog
export struct CartPopupDialog {
  controller: CustomDialogController

  // 完全还原原型图的商品数据
  @State cartItems: CartItem[] = [
    { name: '水豆腐 约500g/份', price: '2.60', qty: 1, image: $r('app.media.doufu') },
    { name: '大白菜 约1.5kg', price: '9.99', qty: 1, image: $r('app.media.baicai') },
    { name: '东北五常大米 10kg', price: '68.90', qty: 1, image: $r('app.media.wuchangdami') }
  ];

  build() {
    Column() {
      // --- 1. 顶部栏 (全选 & 清空购物车) ---
      Row() {
        // 自定义亮绿色全选勾选框
        Stack({ alignContent: Alignment.Center }) {
          Circle({ width: 18, height: 18 }).fill('#00D097')
          Text('✓').fontSize(12).fontColor(Color.White).fontWeight(FontWeight.Bold)
        }.margin({ right: 8 })

        Text('全选').fontSize(14).fontColor('#333333').fontWeight(FontWeight.Medium)
        Text('（已选3件，共11.738kg）').fontSize(12).fontColor('#999999').margin({ left: 4 })

        Blank()

        Text('清空购物车')
          .fontSize(12)
          .fontColor('#999999')
          .onClick(() => {
            promptAction.showToast({ message: '购物车已清空' });
            this.controller.close();
          })
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 16, bottom: 12 })

      // --- 2. 购物车商品列表区 ---
      List({ space: 8 }) {
        ForEach(this.cartItems, (item: CartItem) => {
          ListItem() {
            this.CartItemCard(item)
          }
        })
      }
      .width('100%')
      // 限制最大高度，超过此高度会自动变为可滚动，防止商品过多撑满整个屏幕
      .constraintSize({ maxHeight: 350 })
      .padding({ left: 16, right: 16 })
      .scrollBar(BarState.Off)

      // --- 3. 底部结算悬浮栏 ---
      Row() {
        // 购物车图标与红点角标
        Stack({ alignContent: Alignment.TopEnd }) {
          Stack({ alignContent: Alignment.Center }) {
            Circle({ width: 44, height: 44 }).fill('#00D097') // 原型图中明亮的青绿色
            Image($r('app.media.gouwuche')) // 请替换为白色购物车图标
              .width(24).height(24)
          }.margin({ top: 6, right: 6 })

          // 红色数字角标
          Text('3')
            .fontSize(10)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.White)
            .backgroundColor('#FF0000')
            .textAlign(TextAlign.Center)
            .borderRadius(8)
            .padding({ left: 4, right: 4 })
            .height(16)
            .constraintSize({ minWidth: 16 })
        }
        .width(50)
        .height(50)
        .margin({ right: 12 })

        // 价格与免运费提示
        Column() {
          Row() {
            Text('￥').fontSize(14).fontColor('#333333').margin({ bottom: 2 })
            Text('81.49').fontSize(20).fontWeight(FontWeight.Bold).fontColor('#333333')
          }
          .alignItems(VerticalAlign.Bottom)

          Text('已免运费').fontSize(10).fontColor('#999999').margin({ top: 2 })
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        // 去结算胶囊按钮
        Button('去结算')
          .backgroundColor('#00D097')
          .fontColor(Color.White)
          .fontSize(15)
          .fontWeight(FontWeight.Medium)
          .height(40)
          .width(100)
          .borderRadius(20)
          .onClick(() => {
            this.controller.close();
            router.pushUrl({ url: 'pages/cart/ConfirmOrderPage' });
          })
      }
      .width('100%')
      .height(64)
      .backgroundColor(Color.White)
      .padding({ left: 16, right: 16 })
      .margin({ top: 8 })
      .shadow({ radius: 8, color: 'rgba(0,0,0,0.03)', offsetY: -2 }) // 顶部微弱阴影分离层次
    }
    .width('100%')
    .backgroundColor(Color.White)
    .borderRadius({ topLeft: 16, topRight: 16 }) // 顶部圆角
    .padding({ bottom: 12 }) // 底部安全区留白
  }

  // --- 局部复用组件：单个商品行卡片 ---
  @Builder CartItemCard(item: CartItem) {
    Row() {
      // 勾选框
      Stack({ alignContent: Alignment.Center }) {
        Circle({ width: 18, height: 18 }).fill('#00D097')
        Text('✓').fontSize(12).fontColor(Color.White).fontWeight(FontWeight.Bold)
      }.margin({ right: 12 })

      // 商品主图
      Image(item.image)
        .width(60)
        .height(60)
        .borderRadius(4)
        .backgroundColor('#EAEAEA')
        .margin({ right: 12 })

      // 商品信息与加减步进器
      Column() {
        Text(item.name)
          .fontSize(14)
          .fontColor('#333333')
          .fontWeight(FontWeight.Medium)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .width('100%')

        Blank() // 自动推开间距

        Row() {
          // 商品价格
          Text(`￥${item.price}`)
            .fontSize(14)
            .fontColor('#FF0000') // 红色价格
            .fontWeight(FontWeight.Medium)

          Blank()

          // 步进器
          Row() {
            Text('－')
              .fontSize(12).fontColor('#999999').width(26).height(24)
              .textAlign(TextAlign.Center).border({ width: 0.5, color: '#EEEEEE' }).borderRadius({ topLeft: 4, bottomLeft: 4 })
            Text(`${item.qty}`)
              .fontSize(13).fontColor('#333333').width(32).height(24)
              .textAlign(TextAlign.Center).border({ width: { top: 0.5, bottom: 0.5 }, color: '#EEEEEE' })
            Text('＋')
              .fontSize(12).fontColor('#666666').width(26).height(24)
              .textAlign(TextAlign.Center).border({ width: 0.5, color: '#EEEEEE' }).borderRadius({ topRight: 4, bottomRight: 4 })
          }
        }
        .width('100%')
      }
      .layoutWeight(1)
      .height(60) // 与图片等高
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .padding(12)
    // 原型图中的商品背景不是纯白，而是一种极浅的暖色/粉灰底色以区分层次
    .backgroundColor('#FFFDFD')
    .borderRadius(8)
  }
}