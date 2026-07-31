import router from '@ohos.router';
import { CATEGORY_LIST, RECOMMEND_PRODUCTS, RecommendProduct, CategoryItem } from '../../common/HomeData';
import { CartPopupDialog } from '../../views/components/CartPopupDialog';

@Entry
@Component
export struct CategoryListPage {
  // 当前选中的一级分类索引 (顶部)
  @State currentTopIndex: number = 0;
  // 当前选中的二级分类索引 (左侧)
  @State currentLeftIndex: number = 0;

  // 购物车弹窗控制器
  private cartDialogController: CustomDialogController = new CustomDialogController({
    builder: CartPopupDialog(),
    customStyle: true,
    alignment: DialogAlignment.Bottom
  });

  // 模拟数据
  private topCategories: CategoryItem[] = CATEGORY_LIST;
  private leftMenus: string[] = ['爆品推荐', '新品', '平价好菜', '本地蔬菜', '免洗免切', '叶菜类', '根茎类', '茄瓜果类', '豆制品', '菌菇豆类', '葱蒜调味'];
  private products: RecommendProduct[] = RECOMMEND_PRODUCTS;

  build() {
    Column() {
      // === 1. 顶部标题与搜索栏 ===
      Row() {
        Image($r('app.media.back')) // 返回按钮
          .width(20)
          .height(20)
          .margin({ right: 12 })
          .onClick(() => {
            router.back();
          })

        // 模拟搜索框
        Row() {
          Image($r('app.media.search')).width(16).height(16).margin({ right: 8 })
          Text('搜索商品').fontSize(14).fontColor('#999999')
        }
        .layoutWeight(1)
        .height(36)
        .backgroundColor('#F5F5F5')
        .borderRadius(18)
        .padding({ left: 16 })
        .onClick(() => {
          // 跳转到搜索页面
          router.pushUrl({ url: 'pages/home/SearchPage' });
        })

        Image($r('app.media.gouwuche')) // 购物车图标
          .width(24)
          .height(24)
          .margin({ left: 16 })
          .onClick(() => {
            // 打开购物车弹窗
            this.cartDialogController.open();
          })
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 16, bottom: 12 })
      .backgroundColor(Color.White)

      // === 2. 顶部一级分类 (横向滚动) ===
      List() {
        ForEach(this.topCategories, (item: CategoryItem, index: number) => {
          ListItem() {
            Column() {
              // 选中态给图片加个绿色圆环边框
              Image(item.icon)
                .width(44)
                .height(44)
                .borderRadius(22)
                .border({
                  width: this.currentTopIndex === index ? 2 : 0,
                  color: '#10C8A7'
                })
                .margin({ bottom: 6 })

              Text(item.title)
                .fontSize(12)
                .fontWeight(this.currentTopIndex === index ? FontWeight.Bold : FontWeight.Normal)
                .fontColor(this.currentTopIndex === index ? '#10C8A7' : '#333333')
            }
            .padding({ left: 12, right: 12 })
            .onClick(() => {
              this.currentTopIndex = index;
            })
          }
        })
      }
      .listDirection(Axis.Horizontal)
      .scrollBar(BarState.Off)
      .width('100%')
      .height(80)
      .backgroundColor(Color.White)

      Divider().color('#F0F0F0').strokeWidth(1)

      // === 3. 核心双栏联动区 ===
      Row() {
        // --- 左侧：二级分类菜单 (纵向滚动) ---
        List() {
          ForEach(this.leftMenus, (item: string, index: number) => {
            ListItem() {
              Row() {
                // 选中时的左侧绿色竖条指示器
                Column()
                  .width(4)
                  .height(16)
                  .backgroundColor(this.currentLeftIndex === index ? '#10C8A7' : Color.Transparent)
                  .borderRadius(2)

                Text(item)
                  .fontSize(13)
                  .fontWeight(this.currentLeftIndex === index ? FontWeight.Bold : FontWeight.Normal)
                  .fontColor(this.currentLeftIndex === index ? '#333333' : '#666666')
                  .layoutWeight(1)
                  .textAlign(TextAlign.Center)
              }
              .width('100%')
              .height(50)
              .backgroundColor(this.currentLeftIndex === index ? Color.White : '#F8F8F8')
              .onClick(() => {
                // 切换分类
                this.currentLeftIndex = index;
              })
            }
          })
        }
        .width(90) // 固定左侧宽度
        .height('100%')
        .backgroundColor('#F8F8F8')
        .scrollBar(BarState.Off)

        // --- 右侧：商品列表区 (纵向滚动) ---
        Column() {
          // 右侧顶部过滤栏
          Row() {
            Blank()
            Text('销量').fontSize(12).fontColor('#999999').margin({ right: 16 })
            Text('价格').fontSize(12).fontColor('#999999')
          }
          .width('100%')
          .padding({ left: 12, right: 12, top: 12, bottom: 12 })
          .backgroundColor(Color.White)

          // 商品列表
          List() {
            ForEach(this.products, (product: RecommendProduct, index: number) => {
              ListItem() {
                this.CategoryProductCard(product, index)
              }
            })
          }
          .layoutWeight(1)
          .width('100%')
          .backgroundColor(Color.White)
          .scrollBar(BarState.Off)
        }
        .layoutWeight(1) // 占据右侧全部剩余空间
        .height('100%')
      }
      .layoutWeight(1) // 占据除头部外的全部屏幕高度
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }

  // --- 局部复用组件：列表型商品卡片 ---
  @Builder CategoryProductCard(product: RecommendProduct, index: number) {
    Row() {
      // 左侧商品主图
      Image(product.image)
        .width(80)
        .height(80)
        .borderRadius(8)
        .margin({ right: 12 })

      // 右侧商品信息
      Column() {
        Text(product.name)
          .fontSize(15)
          .fontColor('#333333')
          .fontWeight(FontWeight.Medium)
          .margin({ bottom: 6 })
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Text(product.desc)
          .fontSize(12)
          .fontColor('#999999')
          .margin({ bottom: 8 })
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Row() {
          Image(product.storeIcon).width(12).height(12).margin({ right: 4 })
          Text(product.storeName).fontSize(11).fontColor('#999999').maxLines(1).textOverflow({ overflow: TextOverflow.Ellipsis }).layoutWeight(1)
        }
        .margin({ bottom: 12 })

        // 价格与加购按钮同行
        Row() {
          Text(`¥${product.price}`).fontSize(16).fontColor('#FF4D4F').fontWeight(FontWeight.Bold).margin({ right: 6 })
          Text(`¥${product.oldPrice}`).fontSize(12).fontColor('#999999').decoration({ type: TextDecorationType.LineThrough })

          Blank()

          // 原型图中的亮绿色加号按钮
          Stack({ alignContent: Alignment.Center }) {
            Circle({ width: 24, height: 24 }).fill('#10C8A7')
            Text('+').fontSize(18).fontColor(Color.White).fontWeight(FontWeight.Medium).margin({ bottom: 2 })
          }
          .onClick(() => {
            this.cartDialogController.open();
          })
        }
        .width('100%')
      }
      .layoutWeight(1) // 挤占剩余宽度
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .padding({ left: 12, right: 12, top: 16, bottom: 16 })
    // 底部细分割线
    .border({ width: { bottom: 0.5 }, color: '#F0F0F0' })
    .onClick(() => {
      router.pushUrl({
        url: 'pages/store/ProductDetailPage',
        params: { productIndex: index }
      });
    })
  }
}