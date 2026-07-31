
import router from '@ohos.router';

interface HistoryItem {
  title: string;
  desc: string;
  price: string;
  time: string;
  icon?: Resource;
  productIndex?: number; // 商品索引，用于跳转到对应的商品详情页
}

@Entry
@Component
struct BrowsingHistoryPage {
  // 核心状态：是否处于管理编辑模式
  @State isManaging: boolean = false;
  // 模拟足迹列表数据
  private todayHistory: HistoryItem[] = [
    { title: '广州酒家核桃包 330g', desc: '五分钟快蒸，绵糯多汁，…', price: '¥ 14.5', time: '今天 11:14', icon: $r('app.media.hetao'), productIndex: 5 }
  ];
  private earlyHistory: HistoryItem[] = [
    { title: '云南白药牙膏 2支装', desc: '薄荷型+留兰型', price: '¥ 38.9', time: '2099-08-10 18:26', icon: $r('app.media.yunnanbaiyao'), productIndex: 0 },
    { title: '清风抽纸 300张', desc: '印花加厚3小包抽纸', price: '¥ 29.8', time: '2099-08-09 16:55', icon: $r('app.media.qingfeng'), productIndex: 1 },
    { title: '佳洁士牙膏 1支装', desc: '全线新装升级，3D炫白', price: '¥ 18.9', time: '2099-08-09 16:50', icon: $r('app.media.jiajieshi'), productIndex: 2 }
  ];

  build() {
    Stack({ alignContent: Alignment.Bottom }) {

      // === 1. 顶部标题栏与主体滚动区域 ===
      Column() {
        // 顶部导航栏
        Row() {
          Image($r('app.media.back'))
            .width(20).height(20).margin({ right: 12 })
            .onClick(() => { router.back(); })

          Text('浏览足迹')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#333333')
            .layoutWeight(1)
            .textAlign(TextAlign.Center)

          // 右上角管理切换按钮
          Text(this.isManaging ? '退出管理' : '管理')
            .fontSize(14)
            .fontColor('#333333')
            .onClick(() => {
              this.isManaging = !this.isManaging;
            })
        }
        .width('100%')
        .height(50)
        .padding({ left: 16, right: 16 })
        .backgroundColor(Color.White)

        // 列表滚动区
        Scroll() {
          Column() {
            // --- 分组：今天 ---
            Text('今天')
              .fontSize(15)
              .fontWeight(FontWeight.Bold)
              .fontColor('#333333')
              .width('100%')
              .margin({ bottom: 8, left: 16 })

            Column() {
              ForEach(this.todayHistory, (item: HistoryItem) => {
                this.HistoryItemRow(item.title, item.desc, item.price, item.time, item.icon, item.productIndex)
              })
            }
            .width('92%')
            .backgroundColor(Color.White)
            .borderRadius(12)
            .padding(12)
            .shadow({ radius: 4, color: 'rgba(0,0,0,0.03)', offsetY: 2 })

            // --- 分组：更早 ---
            Text('更早')
              .fontSize(15)
              .fontWeight(FontWeight.Bold)
              .fontColor('#333333')
              .width('100%')
              .margin({ top: 16, bottom: 8, left: 16 })

            Column() {
              ForEach(this.earlyHistory, (item: HistoryItem) => {
                this.HistoryItemRow(item.title, item.desc, item.price, item.time, item.icon, item.productIndex)
              })
            }
            .width('92%')
            .backgroundColor(Color.White)
            .borderRadius(12)
            .padding(12)
            .margin({ bottom: this.isManaging ? 80 : 20 }) // 管理模式下底部留白防遮挡
            .shadow({ radius: 4, color: 'rgba(0,0,0,0.03)', offsetY: 2 })
          }
          .width('100%')
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
        .backgroundColor('#F8F8F8')
      }
      .width('100%')
      .height('100%')

      // === 2. 管理模式下的底部悬浮操作栏 ===
      if (this.isManaging) {
        Row() {
          Row({ space: 6 }) {
            Circle({ width: 18, height: 18 }).fill('#10C8A7')
            Text('全选').fontSize(13).fontColor('#333333')
          }

          Blank()

          Button('删除')
            .width(90)
            .height(38)
            .backgroundColor('#10C8A7')
            .fontColor(Color.White)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .borderRadius(19)
            .onClick(() => {
              // TODO: 批量删除选中足迹逻辑
            })
        }
        .width('100%')
        .height(65)
        .backgroundColor(Color.White)
        .padding({ left: 16, right: 16 })
        .shadow({ radius: 8, color: 'rgba(0,0,0,0.05)', offsetY: -2 })
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8F8F8')
  }

  // --- 局部复用组件：单条足迹行 ---
  @Builder HistoryItemRow(title: string, desc: string, price: string, timeStr: string, icon?: Resource, productIndex?: number) {
    Row() {
      // 如果处于管理模式，左侧显示复选框
      if (this.isManaging) {
        Circle({ width: 18, height: 18 }).fill('#10C8A7').margin({ right: 10 })
      }

      // 商品缩略图
      Image(icon ? icon : $r('app.media.startIcon'))
        .width(70)
        .height(70)
        .borderRadius(6)
        .margin({ right: 12 })
        .onClick(() => {
          router.pushUrl({
            url: 'pages/store/ProductDetailPage',
            params: { productIndex: productIndex !== undefined ? productIndex : 0 }
          });
        })

      // 商品描述信息
      Column() {
        Text(title)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#333333')
          .margin({ bottom: 4 })
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Text(desc)
          .fontSize(12)
          .fontColor('#999999')
          .margin({ bottom: 6 })
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Row() {
          Text(price)
            .fontSize(15)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FF4D4F')

          Blank()

          Row({ space: 4 }) {
            Image($r('app.media.pc')).width(11).height(11)
            Text(timeStr).fontSize(11).fontColor('#999999')
          }
        }
        .width('100%')
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .padding({ top: 8, bottom: 8 })
    .border({ width: { bottom: 0.5 }, color: '#F0F0F0' })
  }
}