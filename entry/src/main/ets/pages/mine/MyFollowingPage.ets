import router from '@ohos.router';

@Entry
@Component
struct MyFollowingPage {
  // 核心状态：是否处于管理编辑模式
  @State isManaging: boolean = false;

  // 模拟关注的店铺列表数据
  private followedShops: Array<{ name: string, score: string, sales: string, time: string, distance: string }> = [
    { name: '天虹商场-凤凰城店', score: '4.5分', sales: '月售700+', time: '30分钟', distance: '1.6km' },
    { name: '大参林药店(凤凰城店)', score: '4.5分', sales: '月售700+', time: '30分钟', distance: '1.6km' },
    { name: '永辉超市-凤凰城店', score: '4.5分', sales: '月售700+', time: '30分钟', distance: '1.6km' },
    { name: '大润发(凤凰城店)', score: '4.5分', sales: '月售700+', time: '30分钟', distance: '1.6km' },
  ];

  build() {
    Stack({ alignContent: Alignment.Bottom }) {

      // === 1. 顶部标题栏与主体滚动区域 ===
      Column() {
        // 顶部导航栏
        Row() {
          Image($r('app.media.startIcon'))
            .width(20).height(20).margin({ right: 12 })
            .onClick(() => { router.back(); })

          Text('我的关注 (4)')
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
            List({ space: 12 }) {
              ForEach(this.followedShops, (shop) => {
                ListItem() {
                  this.ShopCardItem(shop)
                }
              })
            }
            .width('92%')
            .padding({ top: 12, bottom: this.isManaging ? 80 : 20 })
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

          Row({ space: 12 }) {
            Button('分享')
              .width(88)
              .height(38)
              .backgroundColor(Color.White)
              .fontColor('#10C8A7')
              .border({ width: 1, color: '#10C8A7' })
              .fontSize(14)
              .borderRadius(19)

            Button('删除')
              .width(88)
              .height(38)
              .backgroundColor('#10C8A7')
              .fontColor(Color.White)
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .borderRadius(19)
              .onClick(() => {
                // TODO: 批量删除已关注店铺逻辑
              })
          }
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

  // --- 局部复用组件：单个关注店铺卡片 ---
  @Builder ShopCardItem(shop: { name: string, score: string, sales: string, time: string, distance: string }) {
    Row() {
      // 管理模式下左侧显示复选框
      if (this.isManaging) {
        Circle({ width: 18, height: 18 }).fill('#10C8A7').margin({ right: 12 })
      }

      // 店铺Logo
      Image($r('app.media.startIcon'))
        .width(55)
        .height(55)
        .borderRadius(8)
        .margin({ right: 12 })

      // 店铺详细信息
      Column() {
        // 店铺名称
        Text(shop.name)
          .fontSize(15)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')
          .margin({ bottom: 4 })

        // 评分、月售、配送时间、距离
        Row() {
          Text(shop.score).fontSize(12).fontColor('#FF4D4F').margin({ right: 6 })
          Text(shop.sales).fontSize(12).fontColor('#666666').margin({ right: 6 })
          Text('|').fontSize(10).fontColor('#CCCCCC').margin({ right: 6 })
          Text(shop.time).fontSize(12).fontColor('#666666').margin({ right: 6 })
          Text('|').fontSize(10).fontColor('#CCCCCC').margin({ right: 6 })
          Text(shop.distance).fontSize(12).fontColor('#666666')
        }
        .width('100%')
        .margin({ bottom: 6 })

        // 起送与满减说明
        Text('起送 ¥20  满¥30免基础运费')
          .fontSize(11)
          .fontColor('#FF4D4F')
          .margin({ bottom: 8 })

        // 领券标签行 (仅在非管理模式下展示或精简展示)
        if (!this.isManaging) {
          Row({ space: 6 }) {
            this.TagButton('领2元店铺券')
            this.TagButton('领4元店铺券')
            this.TagButton('领7元店铺券')
          }
          .width('100%')
          .margin({ bottom: 6 })

          // 满减活动说明
          Row({ space: 4 }) {
            Text('满减')
              .fontSize(9)
              .fontColor('#FF4D4F')
              .backgroundColor('#FFF2F2')
              .padding({ left: 3, right: 3, top: 1, bottom: 1 })
              .borderRadius(2)

            Text('维达纸巾满49减5，满79减10，满99减15')
              .fontSize(11)
              .fontColor('#666666' )
              .maxLines(1)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
          }
          .width('100%')
        }
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .backgroundColor(Color.White)
    .borderRadius(12)
    .padding(14)
    .shadow({ radius: 4, color: 'rgba(0,0,0,0.03)', offsetY: 2 })
  }

  // --- 领券小标签 ---
  @Builder TagButton(text: string) {
    Text(text)
      .fontSize(10)
      .fontColor('#FF4D4F')
      .border({ width: 0.5, color: '#FF4D4F' })
      .borderRadius(3)
      .padding({ left: 6, right: 6, top: 2, bottom: 2 })
  }
}