import router from '@ohos.router';

@Entry
@Component
struct FeedbackPage {
  @State selectedTypeIndex: number = 0;
  @State feedbackText: string = '';
  @State contactName: string = '用户17330422';
  @State contactPhone: string = '13612345678';

  private feedbackTypes: string[] = ['软件体验', '优惠红包', '配送问题', '商家问题', '商品货品', '其他问题'];

  build() {
    Column() {
      // === 1. 顶部标题栏 (带“我的反馈”入口) ===
      Row() {
        Image($r('app.media.back'))
          .width(20).height(20).margin({ right: 12 })
          .onClick(() => { router.back(); })

        Text('意见反馈')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Text('我的反馈')
          .fontSize(14)
          .fontColor('#333333')
          .onClick(() => {
            router.pushUrl({ url: 'pages/mine/MyFeedbackPage' });
          })
      }
      .width('100%')
      .height(50)
      .padding({ left: 16, right: 16 })
      .backgroundColor(Color.White)

      // === 2. 滚动表单区 ===
      Scroll() {
        Column() {
          // --- 反馈类型与内容输入卡片 ---
          Column() {
            Text('请选择意见类型：')
              .fontSize(14)
              .fontWeight(FontWeight.Bold)
              .fontColor('#333333')
              .width('100%')
              .margin({ bottom: 12 })

            // 类型标签流式布局
            Flex({ wrap: FlexWrap.Wrap }) {
              ForEach(this.feedbackTypes, (typeItem: string, index: number) => {
                Text(typeItem)
                  .fontSize(13)
                  .fontColor(this.selectedTypeIndex === index ? '#10C8A7' : '#666666')
                  .backgroundColor(this.selectedTypeIndex === index ? '#E6F8F5' : '#F5F5F5')
                  .border({ width: 0.5, color: this.selectedTypeIndex === index ? '#10C8A7' : Color.Transparent })
                  .borderRadius(16)
                  .padding({ left: 14, right: 14, top: 7, bottom: 7 })
                  .margin({ right: 10, bottom: 12 })
                  .onClick(() => {
                    this.selectedTypeIndex = index;
                  })
              })
            }
            .width('100%')
            .margin({ bottom: 8 })

            // 意见文本输入区
            TextArea({ placeholder: '请在这里输入你的宝贵意见或建议' })
              .height(130)
              .backgroundColor('#FAFAFA')
              .fontSize(13)
              .placeholderColor('#999999')
              .borderRadius(8)
              .padding(10)
              .margin({ bottom: 8 })
              .onChange((val) => {
                this.feedbackText = val;
              })

            Row() {
              Blank()
              Text(`${this.feedbackText.length}/100`).fontSize(11).fontColor('#999999')
            }
            .width('100%')
            .margin({ bottom: 16 })

            // 图片上传预览槽
            Row({ space: 10 }) {
              // 相机添加按钮
              Stack({ alignContent: Alignment.Center }) {
                Image($r('app.media.shangchuan')).width(75).height(75).borderRadius(6).backgroundColor('#F5F5F5')
              }
            }
            .width('100%')
            .justifyContent(FlexAlign.Start)
          }
          .width('92%')
          .backgroundColor(Color.White)
          .borderRadius(12)
          .padding(16)
          .margin({ top: 12, bottom: 12 })
          .shadow({ radius: 4, color: 'rgba(0,0,0,0.03)', offsetY: 2 })

          // --- 联系信息卡片 ---
          Column() {
            Text('请输入联系信息(选填)：')
              .fontSize(14)
              .fontWeight(FontWeight.Bold)
              .fontColor('#333333')
              .width('100%')
              .margin({ bottom: 12 })

            Row() {
              Text('联系人').fontSize(14).fontColor('#666666').width(75)
              TextInput({ text: this.contactName })
                .layoutWeight(1).height(40).backgroundColor(Color.Transparent).fontSize(13).padding(0)
            }
            .width('100%')
            .height(45)
            .border({ width: { bottom: 0.5 }, color: { bottom: '#F0F0F0' } })

            Row() {
              Text('联系方式').fontSize(14).fontColor('#666666').width(75)
              Row({ space: 4 }) {
                Text('+86').fontSize(13).fontColor('#333333')
                Image($r('app.media.xiala')).width(10).height(10)
              }
              .margin({ right: 10 })

              TextInput({ text: this.contactPhone })
                .layoutWeight(1).height(40).backgroundColor(Color.Transparent).fontSize(13).padding(0)
            }
            .width('100%')
            .height(45)
          }
          .width('92%')
          .backgroundColor(Color.White)
          .borderRadius(12)
          .padding(16)
          .margin({ bottom: 30 })
          .shadow({ radius: 4, color: 'rgba(0,0,0,0.03)', offsetY: 2 })
        }
        .width('100%')
      }
      .scrollBar(BarState.Off)
      .layoutWeight(1)
      .backgroundColor('#F8F8F8')

      // === 3. 底部提交按钮 ===
      Row() {
        Button('提交')
          .width('100%')
          .height(44)
          .backgroundColor('#10C8A7')
          .fontColor(Color.White)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .borderRadius(22)
          .onClick(() => {
            // TODO: 提交反馈逻辑
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
}