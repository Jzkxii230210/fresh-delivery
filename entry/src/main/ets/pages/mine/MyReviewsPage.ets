import router from '@ohos.router';

@Entry
@Component
struct MyReviewsPage {
  // 模拟我的评价列表数据
  private reviewsList: Array<{
    storeName: string,
    time: string,
    content: string,
    reply?: string,
    likeProducts: string[],
    dislikeProducts: string[]
  }> = [
    {
      storeName: '天虹商场-凤凰城店',
      time: '2099-05-14 09:20:45',
      content: '盼望着，盼望着，东风来了，春天的脚步近了。一切都像刚睡醒的样子，欣欣然张开了眼。山朗润起来了，水涨起来了，太阳的脸红起来了。',
      reply: '盼望着，盼望着，东风来了，春天的脚步近了。一切都像刚睡醒的样子，欣欣然张开了眼。山朗润起来了，水涨起来了，太阳的脸红起来了。',
      likeProducts: ['东北五常大米 10kg', '本地鸡蛋8枚 约500g/份'],
      dislikeProducts: ['水豆腐 约500g/份']
    },
    {
      storeName: '天虹商场-凤凰城店',
      time: '2099-05-10 09:45:21',
      content: '盼望着，盼望着，东风来了，春天的脚步近了。一切都像刚睡醒的样子，欣欣然张开了眼。山朗润起来了，水涨起来了，太阳的脸红起来了。小草偷偷地从土地里钻出来，嫩嫩的，绿绿的。园子里，田野里，瞧去，一大片一大片满是的。',
      likeProducts: ['东北五常大米 10kg', '本地鸡蛋8枚 约500g/份'],
      dislikeProducts: []
    }
  ];

  build() {
    Column() {
      // === 1. 顶部标题栏 ===
      Row() {
        Image($r('app.media.startIcon'))
          .width(20)
          .height(20)
          .margin({ right: 12 })
          .onClick(() => { router.back(); })

        Text('我的评价')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Row().width(20) // 平衡右侧
      }
      .width('100%')
      .height(50)
      .padding({ left: 16, right: 16 })
      .backgroundColor(Color.White)

      // === 2. 评价列表滚动区 ===
      Scroll() {
        Column() {
          List({ space: 12 }) {
            ForEach(this.reviewsList, (item) => {
              ListItem() {
                this.ReviewCard(item)
              }
            })
          }
          .width('92%')
          .padding({ top: 12, bottom: 20 })
        }
        .width('100%')
      }
      .scrollBar(BarState.Off)
      .layoutWeight(1)
      .backgroundColor('#F8F8F8')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8F8F8')
  }

  // --- 局部复用组件：单条评价卡片 ---
  @Builder ReviewCard(review: {
    storeName: string,
    time: string,
    content: string,
    reply?: string,
    likeProducts: string[],
    dislikeProducts: string[]
  }) {
    Column() {
      // 1. 卡片头部：店铺Logo、名称与评价时间
      Row() {
        Image($r('app.media.startIcon'))
          .width(32)
          .height(32)
          .borderRadius(16)
          .margin({ right: 8 })

        Column() {
          Text(review.storeName)
            .fontSize(13)
            .fontWeight(FontWeight.Bold)
            .fontColor('#333333')
            .margin({ bottom: 2 })

          // 5星评分图标模拟
          Row({ space: 2 }) {
            ForEach([1, 2, 3, 4, 5], () => {
              Image($r('app.media.startIcon')).width(10).height(10)
            })
          }
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        Text(review.time)
          .fontSize(11)
          .fontColor('#999999')
      }
      .width('100%')
      .margin({ bottom: 12 })

      // 2. 评价正文文字
      Text(review.content)
        .fontSize(13)
        .fontColor('#333333')
        .lineHeight(20)
        .margin({ bottom: review.reply ? 12 : 16 })
        .width('100%')

      // 3. 商家回复区块 (如果存在)
      if (review.reply) {
        Column() {
          Text(`商家回复：${review.reply}`)
            .fontSize(12)
            .fontColor('#666666')
            .lineHeight(18)
        }
        .width('100%')
        .backgroundColor('#F8F8F8')
        .borderRadius(6)
        .padding(10)
        .margin({ bottom: 16 })
      }

      // 4. 商品点赞/点踩互动区
      // 点赞商品列表
      if (review.likeProducts.length > 0) {
        Column({ space: 8 }) {
          Row({ space: 6 }) {
            // 点赞大拇指图标
            Image($r('app.media.startIcon')).width(14).height(14)
          }
          .margin({ bottom: 4 })

          ForEach(review.likeProducts, (prodName) => {
            Row() {
              Image($r('app.media.startIcon'))
                .width(24)
                .height(24)
                .borderRadius(4)
                .margin({ right: 8 })

              Text(prodName)
                .fontSize(12)
                .fontColor('#333333')
            }
            .width('100%')
            .margin({ bottom: 4 })
          })
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)
        .margin({ bottom: review.dislikeProducts.length > 0 ? 10 : 0 })
      }

      // 点踩商品列表
      if (review.dislikeProducts.length > 0) {
        Column({ space: 8 }) {
          Row({ space: 6 }) {
            // 点踩大拇指向下图标
            Image($r('app.media.startIcon')).width(14).height(14)
          }
          .margin({ bottom: 4 })

          ForEach(review.dislikeProducts, (prodName) => {
            Row() {
              Image($r('app.media.startIcon'))
                .width(24)
                .height(24)
                .borderRadius(4)
                .margin({ right: 8 })

              Text(prodName)
                .fontSize(12)
                .fontColor('#333333')
            }
            .width('100%')
          })
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)
      }
    }
    .width('100%')
    .backgroundColor(Color.White)
    .borderRadius(12)
    .padding(14)
    .shadow({ radius: 4, color: 'rgba(0,0,0,0.03)', offsetY: 2 })
  }
}