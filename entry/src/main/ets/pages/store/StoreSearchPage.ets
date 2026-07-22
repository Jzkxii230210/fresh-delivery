import router from '@ohos.router';

@Entry
@Component
struct StoreSearchPage {
  // 搜索框状态
  @State searchQuery: string = '';
  // 页面模式：false 为历史搜索页，true 为搜索结果页
  @State isResultMode: boolean = false;

  // 模拟历史搜索数据
  private searchHistory: string[] = ['五常米', '天虹商场', '水豆腐', '广州酒家', '本地鸡蛋', '本地白菜', '关键词语', '搜索关键词', '关键词', '关键词'];
  // 模拟搜索结果数据
  private mockResults: number[] = [1, 2];

  build() {
    Column() {
      // === 1. 顶部搜索导航栏 ===
      Row() {
        Image($r('app.media.startIcon')) // 返回按钮
          .width(20)
          .height(20)
          .margin({ right: 12 })
          .onClick(() => {
            if (this.isResultMode) {
              this.isResultMode = false; // 结果页点击返回退回历史页
            } else {
              router.back(); // 历史页点击退回店铺主页
            }
          })

        // 搜索输入框
        Row() {
          Image($r('app.media.startIcon')).width(16).height(16).margin({ right: 8 })

          TextInput({ text: this.searchQuery, placeholder: '搜索关键词' })
            .layoutWeight(1)
            .height(36)
            .backgroundColor(Color.Transparent)
            .fontSize(14)
            .padding(0)
            .onChange((value: string) => {
              this.searchQuery = value;
            })
            .onSubmit(() => {
              if (this.searchQuery.trim() !== '') {
                this.isResultMode = true;
              }
            })

          // 有内容且在结果页时，显示清除按钮
          if (this.isResultMode && this.searchQuery !== '') {
            Image($r('app.media.startIcon'))
              .width(16)
              .height(16)
              .margin({ left: 8 })
              .onClick(() => {
                this.searchQuery = '';
                this.isResultMode = false;
              })
          }
        }
        .layoutWeight(1)
        .height(36)
        .backgroundColor(this.isResultMode ? Color.White : '#F8F8F8')
        .borderRadius(18)
        .padding({ left: 12, right: 12 })
        // 结果模式下显示绿色边框，完美还原原型
        .border({ width: this.isResultMode ? 1 : 0, color: '#10C8A7' })

        // 历史模式下，右侧的“搜索”文本按钮
        if (!this.isResultMode) {
          Text('搜索')
            .fontSize(15)
            .fontColor('#10C8A7')
            .margin({ left: 12 })
            .onClick(() => {
              if (this.searchQuery.trim() !== '') {
                this.isResultMode = true;
              }
            })
        }
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 16, bottom: 12 })
      .backgroundColor(Color.White)

      // === 2. 动态内容区 ===
      if (!this.isResultMode) {
        // --- 状态A: 历史搜索页面 ---
        Stack({ alignContent: Alignment.Bottom }) {
          Column() {
            // 历史搜索 Header
            Row() {
              Text('历史搜索')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor('#333333')
              Blank()
              Image($r('app.media.startIcon')) // 垃圾桶图标
                .width(16)
                .height(16)
            }
            .width('100%')
            .padding({ left: 16, right: 16, top: 16, bottom: 16 })

            // 历史标签 (流式布局)
            Flex({ wrap: FlexWrap.Wrap }) {
              ForEach(this.searchHistory, (item: string) => {
                Text(item)
                  .fontSize(13)
                  .fontColor('#666666')
                  .backgroundColor('#F8F8F8')
                  .padding({ left: 14, right: 14, top: 6, bottom: 6 })
                  .borderRadius(16)
                  .margin({ right: 10, bottom: 12 })
                  .onClick(() => {
                    this.searchQuery = item;
                    this.isResultMode = true;
                  })
              })
            }
            .padding({ left: 16, right: 16 })
            .width('100%')
          }
          .width('100%')
          .height('100%')
          .backgroundColor(Color.White)

          // 悬浮的语音搜索按钮
          Column() {
            Circle({ width: 56, height: 56 })
              .fill(Color.White)
              .shadow({ radius: 8, color: 'rgba(0,0,0,0.05)', offsetY: -2 })
            Image($r('app.media.startIcon'))
              .width(24)
              .height(24)
              .position({ x: 16, y: 16 })
          }
          .width(56)
          .height(56)
          .margin({ bottom: 40 })
        }
        .layoutWeight(1)

      } else {
        // --- 状态B: 店内搜索结果页面 ---
        Column() {
          Grid() {
            ForEach(this.mockResults, (item: number) => {
              GridItem() {
                this.StoreItemCard()
              }
            })
          }
          .columnsTemplate('1fr 1fr')
          .columnsGap(10)
          .rowsGap(10)
          .width('92%')
          .padding({ top: 12, bottom: 20 })
        }
        .width('100%')
        .layoutWeight(1)
        .backgroundColor('#F8F8F8')
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }

  // --- 局部复用组件：店内商品卡片 ---
  @Builder StoreItemCard() {
    Column() {
      // 1:1 商品图
      Image($r('app.media.startIcon'))
        .width('100%')
        .aspectRatio(1)
        .borderRadius({ topLeft: 8, topRight: 8 })

      Column() {
        Text('东北五常大米 10kg')
          .fontSize(14)
          .fontColor('#333333')
          .fontWeight(FontWeight.Medium)
          .margin({ bottom: 4 })

        Text('产地直供，营养丰富，多...')
          .fontSize(11)
          .fontColor('#999999')
          .margin({ bottom: 12 })
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        // 价格与购物车按钮同行
        Row() {
          Text('¥68.90').fontSize(16).fontColor('#FF4D4F').fontWeight(FontWeight.Bold).margin({ right: 4 })
          Text('¥79.60').fontSize(12).fontColor('#999999').decoration({ type: TextDecorationType.LineThrough })
          Blank()
          Stack({ alignContent: Alignment.Center }) {
            Circle({ width: 22, height: 22 }).fill('#10C8A7')
            Image($r('app.media.startIcon')).width(12).height(12)
          }
        }
        .width('100%')
      }
      .padding(10)
      .alignItems(HorizontalAlign.Start)
      .width('100%')
    }
    .backgroundColor(Color.White)
    .borderRadius(8)
  }
}