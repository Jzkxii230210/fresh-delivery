import router from '@ohos.router';

@Entry
@Component
struct InvoiceEditPage {
  // 抬头类型: 'personal' (个人/事业单位) 或 'enterprise' (企业)
  @State headerType: string = 'personal';
  @State headerName: string = '';

  build() {
    Column() {
      // === 1. 顶部标题栏 ===
      Row() {
        Image($r('app.media.startIcon'))
          .width(20).height(20).margin({ right: 12 })
          .onClick(() => { router.back(); })

        Text('添加/编辑抬头')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Row().width(20)
      }
      .width('100%')
      .height(50)
      .padding({ left: 16, right: 16 })
      .backgroundColor(Color.White)

      // === 2. 表单滚动区域 ===
      Scroll() {
        Column() {
          // --- 发票基本属性卡片 ---
          Column() {
            Row() {
              Text('发票类型').fontSize(14).fontColor('#333333')
              Blank()
              Text('纸质发票').fontSize(14).fontColor('#666666')
            }
            .width('100%')
            .height(45)

            Divider().color('#F0F0F0').strokeWidth(0.5)

            Row() {
              Text('发票内容').fontSize(14).fontColor('#333333')
              Blank()
              Text('由商家决定').fontSize(14).fontColor('#666666')
            }
            .width('100%')
            .height(45)
          }
          .width('92%')
          .backgroundColor(Color.White)
          .borderRadius(12)
          .padding({ left: 16, right: 16 })
          .margin({ top: 12, bottom: 12 })
          .shadow({ radius: 4, color: 'rgba(0,0,0,0.03)', offsetY: 2 })

          // --- 抬头类型与抬头名称卡片 ---
          Column() {
            Row() {
              Text('抬头类型').fontSize(14).fontColor('#333333').width(80)

              Row({ space: 10 }) {
                // 个人/事业单位选项
                Text('个人/事业单位')
                  .fontSize(13)
                  .fontColor(this.headerType === 'personal' ? '#10C8A7' : '#666666')
                  .layoutWeight(1)
                  .textAlign(TextAlign.Center)
                  .height(34)
                  .backgroundColor(this.headerType === 'personal' ? '#E6F8F5' : Color.Transparent)
                  .borderRadius(17)
                  .border({ width: 0.5, color: this.headerType === 'personal' ? '#10C8A7' : '#E0E0E0' })
                  .onClick(() => {
                    this.headerType = 'personal';
                  })

                // 企业选项
                Text('企业')
                  .fontSize(13)
                  .fontColor(this.headerType === 'enterprise' ? '#10C8A7' : '#666666')
                  .layoutWeight(1)
                  .textAlign(TextAlign.Center)
                  .height(34)
                  .backgroundColor(this.headerType === 'enterprise' ? '#E6F8F5' : Color.Transparent)
                  .borderRadius(17)
                  .border({ width: 0.5, color: this.headerType === 'enterprise' ? '#10C8A7' : '#E0E0E0' })
                  .onClick(() => {
                    this.headerType = 'enterprise';
                  })
              }
              .layoutWeight(1)
            }
            .width('100%')
            .height(60)

            Divider().color('#F0F0F0').strokeWidth(0.5)

            Row() {
              Text('抬头名称').fontSize(14).fontColor('#333333').width(80)
              TextInput({ text: this.headerName, placeholder: '填写发票抬头' })
                .layoutWeight(1)
                .height(44)
                .backgroundColor(Color.Transparent)
                .fontSize(14)
                .padding(0)
                .onChange((val) => {
                  this.headerName = val;
                })
            }
            .width('100%')
            .height(55)
          }
          .width('92%')
          .backgroundColor(Color.White)
          .borderRadius(12)
          .padding({ left: 16, right: 16 })
          .margin({ bottom: 20 })
          .shadow({ radius: 4, color: 'rgba(0,0,0,0.03)', offsetY: 2 })

          // --- 保存按钮 ---
          Button('保存')
            .width('92%')
            .height(44)
            .backgroundColor('#10C8A7')
            .fontColor(Color.White)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .borderRadius(22)
            .margin({ bottom: 12 })
            .onClick(() => {
              // TODO: 保存抬头逻辑
              router.back();
            })

          // --- 删除按钮 ---
          Text('删除')
            .fontSize(14)
            .fontColor('#FF4D4F')
            .width('100%')
            .textAlign(TextAlign.Center)
            .padding(10)
            .onClick(() => {
              // TODO: 删除抬头逻辑
              router.back();
            })
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