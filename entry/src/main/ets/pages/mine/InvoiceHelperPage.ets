import router from '@ohos.router';

// 发票抬头数据接口
interface HeaderItem {
  name: string
}

@Entry
@Component
struct InvoiceHelperPage {
  // 控制是否开启开具发票总开关
  @State isInvoiceEnabled: boolean = true;
  // 当前选中的发票抬头索引
  @State selectedHeaderIndex: number = 0;

  // 模拟已保存的发票抬头列表
  private headers: HeaderItem[] = [
    { name: '个人' },
    { name: '张小乙' },
    { name: '默林工作室' }
  ];

  build() {
    Column() {
      // === 1. 顶部标题栏 ===
      Row() {
        Image($r('app.media.back'))
          .width(20).height(20).margin({ right: 12 })
          .onClick(() => { router.back(); })

        Text('发票助手')
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

      // === 2. 核心内容滚动区 ===
      Scroll() {
        Column() {
          // --- 开具发票开关卡片 ---
          Row() {
            Row({ space: 4 }) {
              Text('开具发票').fontSize(14).fontColor('#333333').fontWeight(FontWeight.Medium)
            }

            Blank()

            Toggle({ type: ToggleType.Switch, isOn: this.isInvoiceEnabled })
              .selectedColor('#10C8A7')
              .onChange((isOn) => {
                this.isInvoiceEnabled = isOn;
              })
          }
          .width('92%')
          .backgroundColor(Color.White)
          .borderRadius(12)
          .padding(16)
          .margin({ bottom: 12 })
          .shadow({ radius: 4, color: 'rgba(0,0,0,0.03)', offsetY: 2 })

          // --- 发票信息卡片 (开关开启时显示) ---
          if (this.isInvoiceEnabled) {
            Column() {
              Text('发票信息')
                .fontSize(14)
                .fontWeight(FontWeight.Bold)
                .fontColor('#333333')
                .width('100%')
                .margin({ bottom: 16 })

              if (this.headers.length === 0) {
                // 空状态
                Column() {
                  Text('还没有发票抬头哦')
                    .fontSize(13)
                    .fontColor('#999999')
                    .margin({ bottom: 16 })
                }
                .width('100%')
                .justifyContent(FlexAlign.Center)
              } else {
                // 抬头列表
                List({ space: 16 }) {
                  ForEach(this.headers, (item: HeaderItem, index: number) => {
                    ListItem() {
                      Row() {
                        // 单选框状态
                        if (this.selectedHeaderIndex === index) {
                          Circle({ width: 18, height: 18 }).fill('#10C8A7').margin({ right: 10 })
                        } else {
                          Circle({ width: 18, height: 18 }).fill(Color.Transparent)
                            .border({ width: 1, color: '#CCCCCC' })
                            .margin({ right: 10 })
                        }

                        Text(item.name)
                          .fontSize(15)
                          .fontColor('#333333')

                        Blank()

                        // 编辑抬头图标
                        Image($r('app.media.shanchu'))
                          .width(16)
                          .height(16)
                          .onClick(() => {
                             router.pushUrl({ url: 'pages/profile/InvoiceEditPage' })
                          })
                      }
                      .width('100%')
                      .onClick(() => {
                        this.selectedHeaderIndex = index;
                      })
                    }
                  })
                }
                .width('100%')
                .margin({ bottom: 16 })
              }

              Divider().color('#F0F0F0').strokeWidth(0.5).margin({ bottom: 16 })

              // 添加抬头按钮
              Row() {
                Text('添加抬头')
                  .fontSize(14)
                  .fontColor('#10C8A7')
                  .fontWeight(FontWeight.Medium)
              }
              .width('100%')
              .justifyContent(FlexAlign.Center)
              .onClick(() => {
                router.pushUrl({ url: 'pages/mine/InvoiceEditPage' });
              })
            }
            .width('92%')
            .backgroundColor(Color.White)
            .borderRadius(12)
            .padding(16)
            .shadow({ radius: 4, color: 'rgba(0,0,0,0.03)', offsetY: 2 })
          }
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
}