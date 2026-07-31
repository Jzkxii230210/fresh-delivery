import router from '@ohos.router';
// 全局配色常量
const PRIMARY_COLOR: string = '#00C896'
const TEXT_MAIN: string = '#333333'
const TEXT_SECOND: string = '#999999'
const BG_WHITE: string = '#FFFFFF'
const AD_BG: string = '#FFDDAA'

// 服务项数据模型
interface ServiceItem {
  icon: Resource
  name: string
  hasTag: boolean
  targetUrl: string
}

@Entry
@Component
export struct WalletPage {
  // 资产数据
  @State totalAsset: number = 350.00
  @State redPacket: number = 250.00
  @State couponMoney: number = 100.00
  @State point: number = 10000

  // 更多服务列表
  private serviceList: ServiceItem[] = [
    { icon: $r('app.media.jifen'), name: '积分兑换', hasTag: true, targetUrl: '' },
    { icon: $r('app.media.quan'), name: '领券中心', hasTag: true, targetUrl: '' },
    { icon: $r('app.media.fapiao'), name: '发票助手', hasTag: false, targetUrl: 'pages/mine/InvoiceHelperPage' },
    { icon: $r('app.media.zhangdan'), name: '支付账单', hasTag: false, targetUrl: 'pages/mine/BillPage' },
  ]

  build() {
    Column() {
      // 顶部绿色导航栏
      this.NavBar()

      Scroll() {
        Column() {
          // 总资产卡片
          this.AssetCard()

          // 广告轮播位
          this.AdBanner()

          // 更多服务卡片
          this.ServiceCard()
        }
        .width('100%')
        .padding({ left: 16, right: 16, top: 8, bottom: 30 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }

  /** 顶部导航栏 */
  @Builder
  NavBar() {
    Row() {
      Image($r('sys.media.ohos_ic_public_arrow_left'))
        .width(24)
        .height(24)
        .fillColor(BG_WHITE)
        .onClick(() => router.back())
      Blank()
      Text('我的钱包')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(BG_WHITE)
      Blank()
      // 占位平衡布局
      Rect().width(24).height(24).fillOpacity(0)
    }
    .width('100%')
    .height(64)
    .padding({ left: 16, right: 16 })
    .backgroundColor(PRIMARY_COLOR)
  }

  /** 总资产、红包、优惠券、积分卡片 */
  @Builder
  AssetCard() {
    Column() {
      Text('总资产(元)')
        .fontSize(13)
        .fontColor(TEXT_MAIN)
        .width('100%')
        .margin({ top: 12, left: 16 })

      Text(`${this.totalAsset.toFixed(2)}`)
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
        .fontColor('#000000')
        .margin({ top: 6 })

      Row() {
        Column() {
          Text(`${this.redPacket.toFixed(2)}`)
            .fontSize(15)
            .fontColor('#000000')
          Text('红包(元)')
            .fontSize(11)
            .fontColor(TEXT_SECOND)
            .margin({ top: 4 })
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center)

        Column() {
          Text(`${this.couponMoney.toFixed(2)}`)
            .fontSize(15)
            .fontColor('#000000')
          Text('优惠券(元)')
            .fontSize(11)
            .fontColor(TEXT_SECOND)
            .margin({ top: 4 })
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center)

        Column() {
          Text(`${this.point}`)
            .fontSize(15)
            .fontColor('#000000')
          Text('积分(分)')
            .fontSize(11)
            .fontColor(TEXT_SECOND)
            .margin({ top: 4 })
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center)
      }
      .width('100%')
      .margin({ top: 24, bottom: 24 })
    }
    .width('100%')
    .backgroundColor(BG_WHITE)
    .borderRadius(12)
  }

  /** 广告位overlay内容 */
  @Builder
  AdOverlay() {
    Column() {
      Text('广告位')
        .fontSize(16)
        .fontColor(BG_WHITE)
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }

  /** 广告轮播区域 */
  @Builder
  AdBanner() {
    Swiper() {
      Rect()
        .width('100%')
        .height(140)
        .fill(AD_BG)
        .borderRadius(12)
        .overlay(this.AdOverlay())
    }
    .width('100%')
    .height(140)
    .autoPlay(true)
    .indicator(true)
    .indicatorStyle({ selectedColor: PRIMARY_COLOR })
    .margin({ top: 16 })
    .borderRadius(12)
  }

  /** 更多服务功能入口 */
  @Builder
  ServiceCard() {
    Column() {
      Text('更多服务')
        .fontSize(14)
        .fontColor('#000000')
        .width('100%')
        .margin({ top: 16, left: 16 })

      Row() {
        ForEach(this.serviceList, (item: ServiceItem) => {
          Column() {
            Stack() {
              Image(item.icon)
                .width(44)
                .height(44)
                .fillColor(TEXT_MAIN)
              if (item.hasTag) {
                Text('规划中')
                  .fontSize(8)
                  .fontColor('#FF3333')
                  .padding({ left: 4, right: 4, top: 2, bottom: 2 })
                  .backgroundColor('#FFE666')
                  .rotate({ angle: -30 })
                  .position({ x: 0, y: -8 })
              }
            }
            Text(item.name)
              .fontSize(11)
              .fontColor(TEXT_MAIN)
              .margin({ top: 6 })
          }
          .layoutWeight(1)
          .alignItems(HorizontalAlign.Center)
          .onClick(() => {
            if (item.targetUrl) router.pushUrl({ url: item.targetUrl })
          })
        })
      }
      .width('100%')
      .margin({ top: 20, bottom: 24 })
    }
    .width('100%')
    .backgroundColor(BG_WHITE)
    .borderRadius(12)
    .margin({ top: 16 })
  }
}
