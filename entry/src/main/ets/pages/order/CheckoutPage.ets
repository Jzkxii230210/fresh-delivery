import router from '@ohos.router';

// 支付方式接口
interface PayMethod {
  name: string;
  icon: Resource;
}

@Entry
@Component
export struct CheckoutPage {
  // 选中的支付方式索引 (0: 支付宝, 1: 微信, 2: 建行, 3: 招行)
  @State selectedPayIndex: number = 0;

  private payMethods: PayMethod[] = [
    { name: '支付宝支付', icon: $r('app.media.zhifubao') },
    { name: '微信支付', icon: $r('app.media.weixinzhifu') },
    { name: '建行龙支付', icon: $r('app.media.jianhang') },
    { name: '招商银行一网通', icon: $r('app.media.zhaoshang') }
  ];

  build() {
    Column() {
      // === 1. 顶部导航栏 ===
      Row() {
        Image($r('app.media.back')) // 黑色返回箭头
          .width(20).height(20).margin({ right: 12 })
          .onClick(() => { router.back(); })

        Text('安全支付')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Row().width(20) // 平衡右侧，保证标题绝对居中
      }
      .width('100%')
      // 自然继承页面的灰色背景，完美融入沉浸式状态栏
      .padding({ left: 16, right: 16, top: 40, bottom: 8 })

      // === 2. 核心支付内容区 ===
      Scroll() {
        Column() {
          // --- 顶部金额与倒计时卡片 ---
          Column() {
            Row({ space: 4 }) {
              Text('¥')
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
                .fontColor('#333333')
                .margin({ bottom: 4 }) // 微调：使符号与数字底部对齐
              Text('74.60')
                .fontSize(36)
                .fontWeight(FontWeight.Bold)
                .fontColor('#333333')
            }
            .alignItems(VerticalAlign.Bottom)
            .margin({ bottom: 8 })

            Row() {
              Text('剩余时间：').fontSize(12).fontColor('#999999')
              Text('29:48').fontSize(12).fontColor('#007DFF')
            }
          }
          .width('94%')
          .backgroundColor(Color.White)
          .borderRadius(12)
          .padding({ top: 28, bottom: 28 }) // 缩小内边距，使卡片更紧凑
          .margin({  bottom: 12 })
          .shadow({ radius: 8, color: 'rgba(0,0,0,0.02)', offsetY: 2 })

          // --- 支付方式选择列表 ---
          Column() {
            Text('请选择支付方式')
              .fontSize(13)
              .fontColor('#999999')
              .width('100%')
              .padding({ left: 16, top: 16, bottom: 8 })

            // 【修复核心】：使用 Column 替代 List，避免在 Scroll 中嵌套 List 导致的大面积空白 Bug
            Column() {
              ForEach(this.payMethods, (item: PayMethod, index: number) => {
                Column() {
                  Row() {
                    // 支付渠道图标
                    Image(item.icon)
                      .width(26).height(26)
                      .borderRadius(4)
                      .margin({ right: 12 })

                    Text(item.name)
                      .fontSize(15)
                      .fontColor('#333333')
                      .fontWeight(FontWeight.Medium)

                    Blank()

                    // 单选框状态
                    if (this.selectedPayIndex === index) {
                      Stack({ alignContent: Alignment.Center }) {
                        Circle({ width: 20, height: 20 }).fill('#10C8A7')
                        // 纯代码绘制白色的对号，解决缺少图片资源导致的占位图问题
                        Text('✓')
                          .fontSize(14)
                          .fontColor(Color.White)
                          .fontWeight(FontWeight.Bold)
                      }
                    } else {
                      Circle({ width: 20, height: 20 })
                        .fill(Color.Transparent)
                        .border({ width: 1, color: '#CCCCCC', radius: 10 })
                    }
                  }
                  .width('100%')
                  .padding({ left: 16, right: 16, top: 16, bottom: 16 })
                  .onClick(() => {
                    this.selectedPayIndex = index;
                  })

                  // 手动绘制分割线 (最后一条不绘制)
                  if (index < this.payMethods.length - 1) {
                    Divider().strokeWidth(0.5).color('#F2F2F2').margin({ left: 54, right: 16 })
                  }
                }
              })
            }
            .width('100%')
          }
          .width('94%')
          .backgroundColor(Color.White)
          .borderRadius(12)
          .padding({ bottom: 8 })
          .shadow({ radius: 8, color: 'rgba(0,0,0,0.02)', offsetY: 2 })
        }
        .width('100%')
      }
      .scrollBar(BarState.Off)
      .layoutWeight(1)
      .align(Alignment.Top)

      // === 3. 底部立即支付按钮栏 ===
      Column() {
        Button('立即支付 ¥74.60')
          .width('92%')
          .height(44)
          .backgroundColor('#10C8A7')
          .fontColor(Color.White)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .borderRadius(8)
          .onClick(() => {
            // 跳转到支付成功页
             router.replaceUrl({ url: 'pages/order/PaymentSuccessPage' });
          })
      }
      .width('100%')
      .backgroundColor(Color.White)
      .padding({ top: 12, bottom: 34 }) // 底部 Home 键防遮挡留白
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}