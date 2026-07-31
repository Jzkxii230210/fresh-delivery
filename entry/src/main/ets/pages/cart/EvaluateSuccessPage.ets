import router from '@ohos.router';
import { RECOMMEND_PRODUCTS, RecommendProduct } from '../../common/HomeData';
// 全局统一配色
const PRIMARY_COLOR: string = '#00C896'
const TEXT_MAIN: string = '#333333'
const TEXT_SECOND: string = '#999999'
const LINE_GRAY: string = '#EEEEEE'
const BG_WHITE: string = '#FFFFFF'


@Entry
@Component
export struct EvaluateSuccessPage {

  build() {
    Scroll() {
      Column() {
        // === 1. 顶部评价成功提示区 ===
        Column() {
          // 成功图标（圆框 + 图片）
          Stack({ alignContent: Alignment.Center }) {
            Circle({ width: 48, height: 48 }).fill('#10C8A7')
            Image($r('app.media.chenggong')).width(28).height(28)
          }
          .margin({ bottom: 12 })

          Text('评价成功')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor('#333333')
            .margin({ bottom: 20 })

          // 核心操作按钮 (返回首页 / 查看评价)
          Row({ space: 16 }) {
            Button('返回首页')
              .width(130)
              .height(36)
              .backgroundColor(Color.White)
              .fontColor('#666666')
              .border({ width: 1, color: '#CCCCCC' })
              .fontSize(14)
              .borderRadius(18)
              .onClick(() => {
                // 返回首页（MainPage的首页Tab）
                router.replaceUrl({
                  url: 'pages/main/MainPage',
                  params: { tabIndex: 0 }
                })
              })

            Button('查看评价')
              .width(130)
              .height(36)
              .backgroundColor(Color.White)
              .fontColor('#10C8A7')
              .border({ width: 1, color: '#10C8A7' })
              .fontSize(14)
              .borderRadius(18)
              .onClick(() => {
                // 查看我的评价页面
                router.pushUrl({ url: 'pages/mine/MyReviewsPage' })
              })
          }
        }
        .width('100%')
        .padding({ top: 40, bottom: 30 })

        // === 2. 更多精选商品标题 ===
        Row() {
          Image($r('app.media.xihuan')).width(14).height(14).margin({ right: 6 })
          Text('更多精选商品').fontSize(14).fontColor('#FF4D4F')
          Image($r('app.media.xihuan')).width(14).height(14).margin({ left: 6 })
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
        .margin({ bottom: 12 })

        // === 3. 商品瀑布流推荐 ===
        Grid() {
          ForEach(RECOMMEND_PRODUCTS, (product: RecommendProduct, index: number) => {
            GridItem() {
              Column() {
                // 商品图片
                Image(product.image)
                  .width('100%')
                  .aspectRatio(1)
                  .borderRadius({ topLeft: 8, topRight: 8 })

                Column() {
                  Text(product.name)
                    .fontSize(14)
                    .fontColor('#333333')
                    .fontWeight(FontWeight.Medium)
                    .margin({ bottom: 4 })

                  Text(product.desc)
                    .fontSize(11)
                    .fontColor('#999999')
                    .margin({ bottom: 10 })
                    .maxLines(1)
                    .textOverflow({ overflow: TextOverflow.Ellipsis })

                  Row() {
                    Text(product.price)
                      .fontSize(16)
                      .fontColor('#FF4D4F')
                      .fontWeight(FontWeight.Bold)
                      .margin({ right: 4 })
                    Text(product.oldPrice)
                      .fontSize(12)
                      .fontColor('#999999')
                      .decoration({ type: TextDecorationType.LineThrough })

                    Blank()

                    Stack({ alignContent: Alignment.Center }) {
                      Circle({ width: 22, height: 22 }).fill('#10C8A7')
                      Image($r('app.media.gouwuche')).width(12).height(12)
                    }
                  }
                  .width('100%')
                  .padding({ left: 10, right: 10 })
                  .margin({ top: 8 })
                }
                .padding({ left: 10, right: 10, bottom: 12 })
              }
              .width('100%')
              .backgroundColor(BG_WHITE)
              .borderRadius(8)
              .onClick(() => {
                // 跳转到商品详情页，传递商品索引
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
        .width('92%')
        .margin({ bottom: 30 })
      }
      .width('100%')
    }
    .scrollBar(BarState.Off)
    .width('100%')
    .height('100%')
    .backgroundColor('#F8F8F8')
  }
}
