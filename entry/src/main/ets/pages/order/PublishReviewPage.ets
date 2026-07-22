import router from '@ohos.router';

@Entry
@Component
struct PublishReviewPage {
  @State reviewContent: string = '';
  // 综合评价倾向: 0-好评, 1-中评, 2-差评 (-1为未选)
  @State selectedRating: number = 0;
  // 记录各个商品的点赞/点踩状态 (0: 未选, 1: 赞, 2: 踩)
  @State itemLikes: number[] = [0, 0, 0, 0, 0, 0, 0];

  private productsToReview: string[] = [
    '水嫩豆腐 约500g/份',
    '大白菜 约1.5kg',
    '五花肉 约250g',
    '花菜 约500g',
    '本地鸡蛋8枚 约500g/份',
    '广州酒家核桃包 330g',
    '东北五常大米 10kg'
  ];

  build() {
    Column() {
      // === 1. 顶部标题栏 ===
      Row() {
        Image($r('app.media.startIcon'))
          .width(20).height(20).margin({ right: 12 })
          .onClick(() => { router.back(); })

        Text('天虹商场-凤凰城...')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Row().width(20) // 占位平衡
      }
      .width('100%')
      .height(50)
      .padding({ left: 16, right: 16 })
      .backgroundColor(Color.White)

      // === 2. 核心评价表单滚动区 ===
      Scroll() {
        Column() {
          // --- 综合评价选项卡 (好评、中评、差评) ---
          Row() {
            Text('综合评价')
              .fontSize(14)
              .fontWeight(FontWeight.Bold)
              .fontColor('#333333')
              .margin({ right: 20 })

            Row({ space: 16 }) {
              this.RatingOption('好评', 0)
              this.RatingOption('中评', 1)
              this.RatingOption('差评', 2)
            }
          }
          .width('100%')
          .padding(16)
          .backgroundColor(Color.White)
          .borderRadius(12)
          .margin({ top: 12, bottom: 12 })
          .shadow({ radius: 4, color: 'rgba(0,0,0,0.03)', offsetY: 2 })

          // --- 文本输入框 (展开说说对商品的想法吧) ---
          Column() {
            TextArea({ placeholder: '展开说说对商品的想法吧...' })
              .height(140)
              .backgroundColor(Color.Transparent)
              .fontSize(14)
              .placeholderColor('#999999')
              .padding(0)
              .onChange((val: string) => {
                this.reviewContent = val;
              })
          }
          .width('100%')
          .backgroundColor(Color.White)
          .borderRadius(12)
          .padding(16)
          .margin({ bottom: 12 })
          .shadow({ radius: 4, color: 'rgba(0,0,0,0.03)', offsetY: 2 })

          // --- 推荐商品逐个点赞/点踩模块 ---
          Column() {
            Text('推荐商品')
              .fontSize(14)
              .fontWeight(FontWeight.Bold)
              .fontColor('#333333')
              .width('100%')
              .margin({ bottom: 12 })

            List({ space: 12 }) {
              ForEach(this.productsToReview, (prodName: string, index: number) => {
                ListItem() {
                  Row() {
                    Text(prodName)
                      .fontSize(13)
                      .fontColor('#333333')
                      .layoutWeight(1)
                      .maxLines(1)
                      .textOverflow({ overflow: TextOverflow.Ellipsis })

                    // 点赞/点踩互动按钮组
                    Row({ space: 8 }) {
                      // 赞按钮
                      Row() {
                        Image($r('app.media.startIcon')).width(14).height(14)
                      }
                      .width(36)
                      .height(28)
                      .justifyContent(FlexAlign.Center)
                      .backgroundColor(this.itemLikes[index] === 1 ? '#E6F8F5' : '#F8F8F8')
                      .border({ width: 0.5, color: this.itemLikes[index] === 1 ? '#10C8A7' : '#E0E0E0' })
                      .borderRadius(14)
                      .onClick(() => {
                        this.itemLikes[index] = this.itemLikes[index] === 1 ? 0 : 1;
                      })

                      // 踩按钮
                      Row() {
                        Image($r('app.media.startIcon')).width(14).height(14)
                      }
                      .width(36)
                      .height(28)
                      .justifyContent(FlexAlign.Center)
                      .backgroundColor(this.itemLikes[index] === 2 ? '#FFF0F0' : '#F8F8F8')
                      .border({ width: 0.5, color: this.itemLikes[index] === 2 ? '#FF4D4F' : '#E0E0E0' })
                      .borderRadius(14)
                      .onClick(() => {
                        this.itemLikes[index] = this.itemLikes[index] === 2 ? 0 : 2;
                      })
                    }
                  }
                  .width('100%')
                }
              })
            }
            .width('100%')
          }
          .width('100%')
          .backgroundColor(Color.White)
          .borderRadius(12)
          .padding(16)
          .margin({ bottom: 40 })
          .shadow({ radius: 4, color: 'rgba(0,0,0,0.03)', offsetY: 2 })
        }
        .width('92%')
        .padding({ top: 4 })
      }
      .scrollBar(BarState.Off)
      .layoutWeight(1)
      .backgroundColor('#F8F8F8')

      // === 3. 底部发表评价按钮 ===
      Row() {
        Button('发表评价')
          .width('100%')
          .height(44)
          .backgroundColor('#10C8A7')
          .fontColor(Color.White)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .borderRadius(22)
          .onClick(() => {
            // TODO: 提交评价逻辑
            router.back();
          })
      }
      .width('100%')
      .backgroundColor(Color.White)
      .padding({ left: 16, right: 16, top: 12, bottom: 12 })
      .shadow({ radius: 8, color: 'rgba(0,0,0,0.05)', offsetY: -2 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8F8F8')
  }

  // --- 辅助 Builder ---
  @Builder RatingOption(title: string, index: number) {
    Row({ space: 4 }) {
      // 模拟笑脸表情图标占位
      Circle({ width: 16, height: 16 }).fill(this.selectedRating === index ? '#10C8A7' : '#CCCCCC')
      Text(title)
        .fontSize(13)
        .fontColor(this.selectedRating === index ? '#10C8A7' : '#666666')
    }
    .onClick(() => {
      this.selectedRating = index;
    })
  }
}