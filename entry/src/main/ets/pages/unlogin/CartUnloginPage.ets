import router from '@ohos.router';
import { RECOMMEND_PRODUCTS, RecommendProduct } from '../../common/HomeData';

@Entry
@Component
export struct CartUnloginPage {
  // 当前Tab索引（购物车是第3个Tab，索引为2）
  private readonly TAB_INDEX: number = 2;
  // 推荐商品列表数据
  private recommendProducts: RecommendProduct[] = RECOMMEND_PRODUCTS;

  build() {
    Scroll() {
      Column() {
        // --- 1. 顶部标题栏 ---
        Text('购物车')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .height(50)
          .width('100%')
          .textAlign(TextAlign.Center)
          .backgroundColor(Color.White)

        // --- 2. 核心未登录提示区 ---
        Column() {
          Image($r('app.media.gouwuche')) // 占位：购物车空状态图标
            .width(80)
            .height(80)
            .margin({ bottom: 16 })
            .borderRadius(40) // 加个圆角让默认图标没那么生硬

          Text('暂未登录')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#333333')
            .margin({ bottom: 8 })

          Text('登录后才可同步购物车哦~')
            .fontSize(12)
            .fontColor('#999999')
            .margin({ bottom: 24 })

          Button('立即登录')
            .width(120)
            .height(36)
            .backgroundColor('#10C8A7') // 原型图的品牌绿
            .fontColor(Color.White)
            .fontSize(14)
            .borderRadius(18)
            .onClick(() => {
              router.pushUrl({ 
                url: 'pages/login/LoginPage',
                params: { tabIndex: this.TAB_INDEX }
              });
            })
        }
        .width('100%')
        .padding({ top: 40, bottom: 40 })
        .backgroundColor(Color.White)
        .borderRadius({ bottomLeft: 20, bottomRight: 20 }) // 底部圆角过渡

        // --- 3. 推荐商品标题区 ---
        Row() {
          Image($r('app.media.xihuan')) // 占位：左侧心形图标
            .width(14).height(14).margin({ right: 6 })

          Text('更多精选商品')
            .fontSize(14)
            .fontColor('#FF4D4F') // 原型图中的红色强调

          Image($r('app.media.xihuan')) // 占位：右侧心形图标
            .width(14).height(14).margin({ left: 6 })
        }
        .margin({ top: 20, bottom: 16 })
        .justifyContent(FlexAlign.Center)
        .width('100%')

        // --- 4. 推荐商品列表 (Grid双列布局) ---
        Grid() {
          ForEach(this.recommendProducts, (item: RecommendProduct) => {
            GridItem() {
              this.ProductCard(item)
            }
            .onClick(() => {
              router.pushUrl({ 
                url: 'pages/login/LoginPage',
                params: { tabIndex: this.TAB_INDEX }
              });
            })
          })
        }
        .columnsTemplate('1fr 1fr') // 均分两列
        .columnsGap(10) // 列间距
        .rowsGap(10)    // 行间距
        .width('92%')
        .margin({ bottom: 20 })
      }
      .width('100%')
    }
    .scrollBar(BarState.Off)
    .backgroundColor('#F8F8F8') // 整体背景呈浅灰色，让白色的卡片凸显出来
    .width('100%')
    .height('100%')
  }

  // --- 局部复用组件：商品卡片 ---
  @Builder ProductCard(item: RecommendProduct) {
    Column() {
      // 商品主图 (1:1 比例)
      Image(item.image)
        .width('100%')
        .aspectRatio(1)
        .borderRadius({ topLeft: 8, topRight: 8 })

      // 商品信息区
      Column() {
        Text(item.name)
          .fontSize(14)
          .fontColor('#333333')
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .margin({ bottom: 4 })

        Text(item.desc)
          .fontSize(11)
          .fontColor('#999999')
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .margin({ bottom: 8 })

        // 价格栏
        Row() {
          Text('¥' + item.price)
            .fontSize(16)
            .fontColor('#FF4D4F')
            .fontWeight(FontWeight.Bold)
            .margin({ right: 8 })

          Text('¥' + item.oldPrice)
            .fontSize(12)
            .fontColor('#999999')
            .decoration({ type: TextDecorationType.LineThrough }) // 原价删除线
        }
        .width('100%')
        .margin({ bottom: 10 })

        // 商家来源标签
        Row() {
          Image(item.storeIcon) // 商家小Logo
            .width(16)
            .height(16)
            .borderRadius(4)
            .margin({ right: 6 })

          Text(item.storeName)
            .fontSize(11)
            .fontColor('#666666')
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .layoutWeight(1) // 挤占剩余空间，防止文字过长溢出
        }
        .width('100%')
      }
      .padding(10)
      .alignItems(HorizontalAlign.Start)
    }
    .backgroundColor(Color.White)
    .borderRadius(8)
  }
}