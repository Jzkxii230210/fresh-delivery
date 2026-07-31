import router from '@ohos.router';
import { RECOMMEND_PRODUCTS, RecommendProduct } from '../../common/HomeData';
import { CartPopupDialog } from '../../views/components/CartPopupDialog';
import { ShareDialog } from '../../views/components/ShareDialog';

// 路由参数接口
interface RouterParams {
  productIndex?: number;
}

@Entry
@Component
export struct ProductDetailPage {

  // 当前商品索引
  private productIndex: number = 0;
  private product: RecommendProduct = RECOMMEND_PRODUCTS[0];

  // 购物车弹窗控制器
  private cartDialogController: CustomDialogController = new CustomDialogController({
    builder: CartPopupDialog(),
    customStyle: true,
    alignment: DialogAlignment.Bottom
  });

  // 分享弹窗控制器
  private shareDialogController: CustomDialogController = new CustomDialogController({
    builder: ShareDialog(),
    customStyle: true,
    alignment: DialogAlignment.Bottom
  });

  aboutToAppear() {
    const params = router.getParams() as RouterParams;
    if (params && params.productIndex !== undefined) {
      this.productIndex = params.productIndex;
      if (this.productIndex >= 0 && this.productIndex < RECOMMEND_PRODUCTS.length) {
        this.product = RECOMMEND_PRODUCTS[this.productIndex];
      }
    }
  }

  build() {
    // 使用 Stack 让底部结算栏悬浮在页面最上方
    Stack({ alignContent: Alignment.Bottom }) {

      // === 主体滚动区域 ===
      Scroll() {
        Column() {
          // --- 1. 商品主图与顶部悬浮按钮 ---
          Stack({ alignContent: Alignment.Top }) {
            // 商品主图
            Image(this.product.image)
              .width('100%')
              .height(350)
              .objectFit(ImageFit.Cover)
              .backgroundColor('#EAEAEA')

            // 顶部左右悬浮按钮 (返回 & 分享)
            Row() {
              // 返回按钮
              Stack({ alignContent: Alignment.Center }) {
                Circle({ width: 32, height: 32 }).fill('rgba(0, 0, 0, 0.4)')
                Image($r('app.media.back')) // 替换为白色返回箭头
                  .width(16).height(16)
              }
              .onClick(() => {
                router.back();
              })

              Blank()

              // 分享按钮
              Stack({ alignContent: Alignment.Center }) {
                Circle({ width: 32, height: 32 }).fill('rgba(0, 0, 0, 0.4)')
                Image($r('app.media.fenxiang')) // 替换为白色分享图标
                  .width(16).height(16)
              }
              .onClick(() => {
                this.shareDialogController.open();
              })
            }
            .width('100%')
            // 预留系统状态栏高度
            .padding({ left: 16, right: 16, top: 48 })
          }
          .width('100%')

          // --- 2. 商品核心信息区 (标题、价格、加购物车) ---
          Column() {
            Text(this.product.name)
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor('#333333')
              .width('100%')
              .margin({ bottom: 6 })

            Text(this.product.desc)
              .fontSize(13)
              .fontColor('#999999')
              .width('100%')
              .margin({ bottom: 12 })

            Row() {
              // 价格排版
              Row() {
                Text('￥').fontSize(14).fontColor('#FF0000').margin({ bottom: 2 })
                Text(this.product.price).fontSize(26).fontWeight(FontWeight.Bold).fontColor('#FF0000')
                Text('/份').fontSize(12).fontColor('#FF0000').margin({ left: 2, bottom: 2 })
                Text(`￥${this.product.oldPrice}`)
                  .fontSize(13)
                  .fontColor('#999999')
                  .decoration({ type: TextDecorationType.LineThrough })
                  .margin({ left: 8, bottom: 2 })
              }
              .alignItems(VerticalAlign.Bottom)

              Blank()

              // 加入购物车按钮
              Button('加入购物车')
                .backgroundColor('#10C8A7')
                .fontColor(Color.White)
                .fontSize(14)
                .height(32)
                .padding({ left: 16, right: 16 })
                .borderRadius(16)
            }
            .width('100%')
            .alignItems(VerticalAlign.Center)
          }
          .width('100%')
          .padding(16)
          .backgroundColor(Color.White)

          // --- 3. 店铺入口区 ---
          Row() {
            Image(this.product.storeIcon)
              .width(20)
              .height(20)
              .borderRadius(4)
              .margin({ right: 8 })

            Text(this.product.storeName)
              .fontSize(14)
              .fontColor('#333333')

            Blank()

            Image($r('app.media.more')) // 替换为右箭头
              .width(14)
              .height(14)
              .opacity(0.5)
          }
          .width('100%')
          .padding(16)
          .backgroundColor(Color.White)
          .margin({ top: 8 })

          // --- 4. 商品规格区 (三分栏) ---
          Row() {
            Column() {
              Text('产地').fontSize(13).fontColor('#333333').margin({ bottom: 6 })
              Text('本地').fontSize(12).fontColor('#999999')
            }.layoutWeight(1).alignItems(HorizontalAlign.Center)

            Divider().vertical(true).height(30).color('#EEEEEE')

            Column() {
              Text('规格').fontSize(13).fontColor('#333333').margin({ bottom: 6 })
              Text('约500g').fontSize(12).fontColor('#999999')
            }.layoutWeight(1).alignItems(HorizontalAlign.Center)

            Divider().vertical(true).height(30).color('#EEEEEE')

            Column() {
              Text('储存方式').fontSize(13).fontColor('#333333').margin({ bottom: 6 })
              Text('常温').fontSize(12).fontColor('#999999')
            }.layoutWeight(1).alignItems(HorizontalAlign.Center)
          }
          .width('100%')
          .padding({ top: 16, bottom: 16 })
          .backgroundColor(Color.White)
          .margin({ top: 8 })

          // --- 5. 【新增】搭配购买区 (横向滑动) ---
          Column() {
            Row() {
              Text('搭配购买')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor('#333333')
            }
            .width('100%')
            .margin({ bottom: 12 })

            List() {
              ForEach(RECOMMEND_PRODUCTS, (item: RecommendProduct, index: number) => {
                if (index !== this.productIndex) {
                  ListItem() {
                    this.BundleCard(item)
                  }
                }
              })
            }
            .listDirection(Axis.Horizontal) // 设置为横向滑动
            .scrollBar(BarState.Off)
            .width('100%')
          }
          .width('100%')
          .padding(16)
          .backgroundColor(Color.White)
          .margin({ top: 8 })

          // --- 6. 商品评价区 ---
          Column() {
            Row() {
              Text('商品评价 (534)')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor('#333333')

              Blank()

              Text('好评 ')
                .fontSize(12)
                .fontColor('#999999')
              Text('97.3%')
                .fontSize(12)
                .fontColor('#FF0000')
              Image($r('app.media.more')) // 替换为右箭头
                .width(12).height(12).opacity(0.5).margin({ left: 4 })
            }
            .width('100%')
            .margin({ bottom: 12 })

            // 评价标签
            Row({ space: 8 }) {
              this.ReviewTag('值得回购')
              this.ReviewTag('包装完整')
              this.ReviewTag('品质保障')
              this.ReviewTag('强烈推荐')
            }
            .width('100%')
          }
          .width('100%')
          .padding(16)
          .backgroundColor(Color.White)
          .margin({ top: 8 })

          // --- 7. 价格说明区 (长文本规则) ---
          Column() {
            this.RuleSection('划线价格', '划线价格系参考价，可能是商品（含服务）的线下实体门店销售价、网络零售指导价、品牌供应商提供的正品零售价(如厂商指导价、建议零售价) 专柜价、吊牌价或该商品在小默买菜平台上曾经展示过的销售价等。划线价并非原价，仅供参考。由于地区、时间差异及市场波动，该价格可能存在变化或差异，供参考。')

            this.RuleSection('未划线价格', '未划线价格系商品（含服务）在小默买菜平台的实时标价（不含餐具费、包装费、配送费），不因表述的差异改变性质。具体成交价格根据商品参加活动、优惠卡券或会员使用优惠券、积分等发生变化，最终以订单结算页展示的实际成交价格为准。商家/商品详情页（含主图）以图片或文字形式标注的一口价、促销价、优惠价等价格可能是使用优惠券满减或特定优惠活动和时段等情形下的价格，具体请以订单结算页面的标价、优惠条件或活动规则为准。')

            this.RuleSection('折扣', '当商品存在折扣时，除非商户另有明确说明，商品页面显示的折扣数字为未划线价格/划线价格；可能因页面显示范围有限而无法展示折扣的完整数列，具体展示的折扣数字将会为您保留小数点后一至二位，请您理解并以订单结算页面显示的最终未划线价格计算为准。\n\n若商家单独对划线价格、折扣、成交价、到手价等进行说明的，以商家的表述为准。如有疑问，您可咨询商家。')
          }
          .width('100%')
          .padding(16)
          .backgroundColor(Color.White)
          .margin({ top: 8 })

          // 底部留白，防止被悬浮结算栏遮挡
          Row().width('100%').height(80)
        }
      }
      .scrollBar(BarState.Off)
      .width('100%')
      .height('100%')
      .backgroundColor('#F5F5F5') // 整体浅灰背景色
      .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP]) // 顶部沉浸式

      // === 8. 底部悬浮结算栏 ===
      Row() {
        // 购物车图标与数字角标
        Stack({ alignContent: Alignment.TopEnd }) {
          // 绿色背景圆圈
          Stack({ alignContent: Alignment.Center }) {
            Circle({ width: 44, height: 44 }).fill('#10C8A7')
            Image($r('app.media.gouwuche')) // 替换为白色购物车图标
              .width(24).height(24)
          }.margin({ top: 6, right: 6 })

          // 红底白字角标
          Text('1')
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
        .onClick(() => {
          this.cartDialogController.open();
        })

        Text('￥21.9')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')

        Blank()

        Button('去结算')
          .backgroundColor('#10C8A7')
          .fontColor(Color.White)
          .fontSize(15)
          .fontWeight(FontWeight.Medium)
          .height(40)
          .width(100)
          .borderRadius(20)
          .onClick(() => {
            router.pushUrl({ url: 'pages/cart/ConfirmOrderPage' });
          })
      }
      .width('100%')
      .height(64)
      .backgroundColor(Color.White)
      .padding({ left: 16, right: 16 })
      .shadow({ radius: 10, color: 'rgba(0,0,0,0.05)', offsetY: -2 }) // 顶部轻微阴影
    }
    .width('100%')
    .height('100%')
  }

  // --- 局部复用组件：评价标签 ---
  @Builder ReviewTag(text: string) {
    Text(text)
      .fontSize(11)
      .fontColor('#C69C6D') // 浅褐色文字
      .backgroundColor('#FFF8EE') // 极浅的褐色背景
      .padding({ left: 10, right: 10, top: 4, bottom: 4 })
      .borderRadius(12)
  }

  // --- 局部复用组件：价格规则说明文本 ---
  @Builder RuleSection(title: string, content: string) {
    Column() {
      Text(title)
        .fontSize(14)
        .fontWeight(FontWeight.Bold)
        .fontColor('#333333')
        .width('100%')
        .margin({ bottom: 8 })

      Text(content)
        .fontSize(12)
        .fontColor('#666666')
        .lineHeight(20) // 增加行高，提升阅读体验
        .width('100%')
    }
    .margin({ bottom: 20 })
  }

  // --- 局部复用组件：搭配购买卡片 ---
  @Builder BundleCard(item: RecommendProduct) {
    Column() {
      Image(item.image)
        .width(84)
        .height(84)
        .borderRadius(6)
        .backgroundColor('#F9F9F9')
        .margin({ bottom: 8 })

      Text(item.name)
        .fontSize(12)
        .fontColor('#333333')
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .width(84)
        .margin({ bottom: 6 })

      Row() {
        Text(`￥${item.price}`)
          .fontSize(13)
          .fontColor('#FF0000')
          .fontWeight(FontWeight.Medium)

        Blank()

        // 加入购物车的加号小按钮
        Stack({ alignContent: Alignment.Center }) {
          Circle({ width: 18, height: 18 }).fill('#10C8A7')
          Text('+').fontSize(14).fontColor(Color.White).margin({ bottom: 2 })
        }
      }
      .width(84)
    }
    .margin({ right: 12 })
    .alignItems(HorizontalAlign.Start)
  }
}