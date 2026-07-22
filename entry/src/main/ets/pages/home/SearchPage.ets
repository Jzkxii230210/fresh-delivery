import router from '@ohos.router';

@Entry
@Component
struct SearchPage {
  // 核心状态：输入框内容
  @State searchQuery: string = '';
  // 核心状态：是否处于搜索结果模式
  @State isResultMode: boolean = false;

  // 模拟历史搜索数据
  private searchHistory: string[] = ['五常米', '天虹商场', '水豆腐', '广州酒家', '本地鸡蛋', '本地白菜', '关键词语', '搜索关键词', '关键词'];
  // 模拟搜索结果数据
  private mockResults: number[] = [1, 2, 3, 4];

  build() {
    Column() {
      // === 1. 顶部搜索导航栏 ===
      Row() {
        // 返回按钮
        Image($r('app.media.startIcon'))
          .width(20)
          .height(20)
          .margin({ right: 12 })
          .onClick(() => {
            if (this.isResultMode) {
              this.isResultMode = false; // 如果在结果页，先退回历史页
            } else {
              router.back(); // 退回上一级页面
            }
          })

        // 搜索输入框 (根据状态改变边框样式)
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
                this.isResultMode = true; // 按下回车键触发搜索
              }
            })

          // 结果页模式下，显示清除按钮
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
        .backgroundColor(this.isResultMode ? Color.White : '#F5F5F5')
        .borderRadius(18)
        .padding({ left: 12, right: 12 })
        // 还原细节：结果页有绿色边框，历史页没有
        .border({ width: this.isResultMode ? 1 : 0, color: '#10C8A7' })

        // 历史模式下，右侧显示“搜索”文字按钮
        if (!this.isResultMode) {
          Text('搜索')
            .fontSize(15)
            .fontColor('#10C8A7') // 品牌绿
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

      // === 2. 动态内容区 (历史页 vs 结果页) ===
      if (!this.isResultMode) {
        // --- 状态A: 历史搜索页面 ---
        Stack({ alignContent: Alignment.Bottom }) {
          Column() {
            // 历史搜索标题栏
            Row() {
              Text('历史搜索')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor('#333333')
              Blank()
              Image($r('app.media.startIcon')) // 垃圾桶删除图标占位
                .width(16)
                .height(16)
            }
            .width('100%')
            .padding({ left: 16, right: 16, top: 16, bottom: 16 })

            // 流式布局标签 (Flex Wrap)
            Flex({ wrap: FlexWrap.Wrap }) {
              ForEach(this.searchHistory, (item: string) => {
                Text(item)
                  .fontSize(13)
                  .fontColor('#666666')
                  .backgroundColor('#F5F5F5')
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

          // 底部语音搜索悬浮按钮
          Column() {
            Circle({ width: 60, height: 60 })
              .fill(Color.White)
              .shadow({ radius: 10, color: 'rgba(0,0,0,0.05)', offsetY: -2 })
            Image($r('app.media.startIcon')) // 语音麦克风图标占位
              .width(28)
              .height(28)
              .position({ x: 16, y: 16 }) // 居中定位在圆形上
          }
          .width(60)
          .height(60)
          .margin({ bottom: 40 })
        }
        .layoutWeight(1)

      } else {
        // --- 状态B: 搜索结果页面 ---
        Column() {
          Grid() {
            ForEach(this.mockResults, (item: number) => {
              GridItem() {
                this.SearchResultCard()
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
        .backgroundColor('#F8F8F8') // 结果页背景设为灰色，衬托白色卡片
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }

  // --- 复用商品卡片组件 ---
  @Builder SearchResultCard() {
    Column() {
      Image($r('app.media.startIcon'))
        .width('100%')
        .aspectRatio(1)
        .borderRadius({ topLeft: 8, topRight: 8 })

      Column() {
        Text('花菜 约500g')
          .fontSize(14)
          .fontColor('#333333')
          .fontWeight(FontWeight.Medium)
          .margin({ bottom: 4 })

        Text('产地直供，营养丰富')
          .fontSize(11)
          .fontColor('#999999')
          .margin({ bottom: 12 })

        Row() {
          Text('¥7.99').fontSize(16).fontColor('#FF4D4F').fontWeight(FontWeight.Bold).margin({ right: 4 })
          Text('¥9.90').fontSize(12).fontColor('#999999').decoration({ type: TextDecorationType.LineThrough })
          Blank()
          // 购物车加购小图标
          Stack({ alignContent: Alignment.Center }) {
            Circle({ width: 22, height: 22 }).fill('#10C8A7')
            Image($r('app.media.startIcon')).width(12).height(12)
          }
        }
        .width('100%')
        .margin({ bottom: 12 })

        Row() {
          Image($r('app.media.startIcon')).width(14).height(14).borderRadius(2).margin({ right: 4 })
          Text('天虹商场-凤凰城店')
            .fontSize(10)
            .fontColor('#666666')
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .layoutWeight(1)
        }
        .margin({ bottom: 4 })

        Text('满¥30免基础运费')
          .fontSize(10)
          .fontColor('#FF8C00')
          .padding({ left: 18 })
      }
      .padding(10)
      .alignItems(HorizontalAlign.Start)
      .width('100%')
    }
    .backgroundColor(Color.White)
    .borderRadius(8)
  }
}