import router from '@ohos.router';

@Entry
@Component
struct RefundApplyPage {
  // 当前选中的退款原因索引 (-1 表示未选择)
  @State selectedReasonIndex: number = -1;
  @State refundDesc: string = '';

  private refundReasons: string[] = [
    '商品错选/多选',
    '计划有变，不想要了',
    '价格太贵了',
    '收货人信息填写有误',
    '配送速度太慢',
    '其他'
  ];

  build() {
    Column() {
      // === 1. 顶部标题栏 ===
      Row() {
        Image($r('app.media.startIcon'))
          .width(20).height(20).margin({ right: 12 })
          .onClick(() => { router.back(); })

        Text('申请退款')
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

      // === 2. 核心表单滚动区 ===
      Scroll() {
        Column() {
          // --- 顶部退款提示条 ---
          Row() {
            Text('退款后订单关闭无法恢复，优惠券、红包不可返还。')
              .fontSize(12)
              .fontColor('#999999')
          }
          .width('100%')
          .padding(12)
          .backgroundColor('#F5F5F5')
          .borderRadius(6)
          .margin({ bottom: 16 })

          // --- 订单基本信息 ---
          Column() {
            this.InfoRow('订单编号', '2125538995000052')
            this.InfoRow('退款金额', '￥74.60', true)
            this.InfoRow('退款方式', '微信支付')
          }
          .width('100%')
          .backgroundColor(Color.White)
          .borderRadius(12)
          .padding(16)
          .margin({ bottom: 12 })
          .shadow({ radius: 4, color: 'rgba(0,0,0,0.03)', offsetY: 2 })

          // --- 退款原因选择模块 ---
          Column() {
            Row() {
              Text('请选择退款原因 ').fontSize(14).fontWeight(FontWeight.Bold).fontColor('#333333')
              Text('*').fontSize(14).fontColor('#FF4D4F')
            }
            .width('100%')
            .margin({ bottom: 12 })

            List({ space: 16 }) {
              ForEach(this.refundReasons, (reason: string, index: number) => {
                ListItem() {
                  Row() {
                    Text(reason)
                      .fontSize(14)
                      .fontColor('#333333')

                    Blank()

                    // 单选圆圈
                    if (this.selectedReasonIndex === index) {
                      Circle({ width: 18, height: 18 }).fill('#10C8A7')
                    } else {
                      Circle({ width: 18, height: 18 }).fill(Color.Transparent)
                        .border({ width: 1, color: '#CCCCCC' })
                    }
                  }
                  .width('100%')
                  .onClick(() => {
                    this.selectedReasonIndex = index;
                  })
                }
              })
            }
            .width('100%')
          }
          .width('100%')
          .backgroundColor(Color.White)
          .borderRadius(12)
          .padding(16)
          .margin({ bottom: 12 })
          .shadow({ radius: 4, color: 'rgba(0,0,0,0.03)', offsetY: 2 })

          // --- 补充说明输入框 ---
          Column() {
            Text('补充说明')
              .fontSize(14)
              .fontWeight(FontWeight.Bold)
              .fontColor('#333333')
              .width('100%')
              .margin({ bottom: 10 })

            TextArea({ placeholder: '请输入补充说明 (选填)' })
              .height(90)
              .backgroundColor('#FAFAFA')
              .fontSize(13)
              .placeholderColor('#999999')
              .borderRadius(8)
              .padding(10)
              .onChange((val: string) => {
                this.refundDesc = val;
              })
          }
          .width('100%')
          .backgroundColor(Color.White)
          .borderRadius(12)
          .padding(16)
          .margin({ bottom: 40 })
          .shadow({ radius: 4, color: 'rgba(0,0,0,0.03)', offsetY: 2 })
        }
        .width('92%')
        .padding({ top: 12 })
      }
      .scrollBar(BarState.Off)
      .layoutWeight(1)
      .backgroundColor('#F8F8F8')

      // === 3. 底部提交按钮 ===
      Row() {
        Button('申请退款')
          .width('100%')
          .height(44)
          .backgroundColor('#10C8A7')
          .fontColor(Color.White)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .borderRadius(22)
          .onClick(() => {
            if (this.selectedReasonIndex === -1) {
              // 可在此处加个轻提示要求选择原因
              return;
            }
            // TODO: 提交退款请求逻辑
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
  @Builder InfoRow(label: string, value: string, isRed: boolean = false) {
    Row() {
      Text(label).fontSize(14).fontColor('#666666')
      Blank()
      Text(value).fontSize(14).fontColor(isRed ? '#FF4D4F' : '#333333').fontWeight(isRed ? FontWeight.Bold : FontWeight.Normal)
    }
    .width('100%')
    .margin({ bottom: 12 })
  }
}