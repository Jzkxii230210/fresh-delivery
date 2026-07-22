import router from '@ohos.router';

@Entry
@Component
struct NearbyShopPage {
  // 当前选中的 Tab 索引
  @State currentTabIndex: number = 0;

  // 模拟数据
  private tabs: string[] = ['全部', '超市', '便利店', '药店', '水果店', '其他'];
  // 使用数字数组模拟列表，并在第 4 个元素后插入“一公里外”的分割线
  private mockMerchants: number[] = [1, 2, 3, 4, 5, 6, 7];

  build() {
    Column() {
      // === 1. 顶部标题栏 ===
      Row() {
        Image($r('app.media.startIcon')) // 返回按钮
          .width(20)
          .height(20)
          .onClick(() => {
            router.back();
          })

        Text('一公里内商家')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#333333')
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        // 右侧定位信息
        Column() {
          Image($r('app.media.startIcon')).width(16).height(16).margin({ bottom: 2 })
          Text('凤凰城').fontSize(10).fontColor('#666666')
        }
        .width(40)
        .alignItems(HorizontalAlign.Center)
      }
      .width('100%')
      .height(50)
      .padding({ left: 16, right: 16 })
      .backgroundColor(Color.White)

      // === 2. 顶部 Tab 分类 (横向滚动) ===
      List() {
        ForEach(this.tabs, (item: string, index: number) => {
          ListItem() {
            Column() {
              Text(item)
                .fontSize(14)
                .fontWeight(this.currentTabIndex === index ? FontWeight.Bold : FontWeight.Normal)
                .fontColor(this.currentTabIndex === index ? '#10C8A7' : '#666666')
                .margin({ bottom: 6 })

              // 底部绿色指示条
              Divider()
                .color(this.currentTabIndex === index ? '#10C8A7' : Color.Transparent)
                .strokeWidth(2)
                .width(24)
                .lineCap(LineCapStyle.Round)
            }
            .padding({ left: 16, right: 16, top: 10, bottom: 4 })
            .onClick(() => {
              this.currentTabIndex = index;
            })
          }
        })
      }
      .listDirection(Axis.Horizontal)
      .scrollBar(BarState.Off)
      .width('100%')
      .height(44)
      .backgroundColor(Color.White)

      // === 3. 商家列表区 ===
      List() {
        ForEach(this.mockMerchants, (item: number, index: number) => {
          // 模拟在索引 3 之后插入“一公里外商家”的分割提示
          if (index === 3) {
            ListItem() {
              this.DistanceDivider()
            }
          }

          ListItem() {
            this.MerchantDetailCard(item)
          }
        })

        // 底部安全距离留白
        ListItem() {
          Row().height(40).width('100%')
        }
      }
      .layoutWeight(1) // 占满剩余空间
      .width('100%')
      .backgroundColor('#F8F8F8') // 灰色背景衬托白色卡片
      .padding({ left: 12, right: 12, top: 12 })
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8F8F8')
  }

  // --- 局部复用组件 ---

  // 分割线：一公里外商家
  @Builder DistanceDivider() {
    Row() {
      Image($r('app.media.startIcon')) // 左侧心形占位
        .width(14).height(14).margin({ right: 6 })

      Text('一公里外商家')
        .fontSize(13)
        .fontColor('#FF4D4F')

      Image($r('app.media.startIcon')) // 右侧心形占位
        .width(14).height(14).margin({ left: 6 })
    }
    .width('100%')
    .justifyContent(FlexAlign.Center)
    .padding({ top: 10, bottom: 16 })
  }

  // 核心商家卡片
  @Builder MerchantDetailCard(itemIndex: number) {
    Row() {
      // 左侧商家大 Logo
      Column() {
        Image($r('app.media.startIcon'))
          .width(80)
          .height(80)
          .borderRadius(8)
          .margin({ bottom: 4 })

        // 模拟 Logo 下方的特殊标签 (如"经常光顾")，部分卡片有
        if (itemIndex % 2 === 0) {
          Text('经常光顾')
            .fontSize(10)
            .fontColor(Color.White)
            .backgroundColor('#D2B48C') // 浅棕色背景
            .padding({ left: 4, right: 4, top: 2, bottom: 2 })
            .borderRadius({ topLeft: 4, bottomRight: 4 })
            .position({ x: 0, y: 64 }) // 绝对定位覆盖在图片底部
        }
      }
      .margin({ right: 12 })
      .alignItems(HorizontalAlign.Start)

      // 右侧详细信息
      Column() {
        // 1. 商家名称
        Text('天虹商场-凤凰城店')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .margin({ bottom: 8 })

        // 2. 评分、销量与距离
        Row() {
          Text('4.5分').fontSize(12).fontColor('#FF4D4F').margin({ right: 8 })
          Text('月售700+').fontSize(12).fontColor('#999999').margin({ right: 8 })
          Text('30分钟').fontSize(12).fontColor('#999999').margin({ right: 8 })
          Text('|').fontSize(10).fontColor('#E0E0E0').margin({ right: 8 })
          Text('1.6km').fontSize(12).fontColor('#999999')
        }
        .width('100%')
        .margin({ bottom: 8 })

        // 3. 配送费信息
        Row() {
          Text('起送 ￥20').fontSize(12).fontColor('#666666').margin({ right: 8 })
          Text('满 ￥30免基础运费').fontSize(12).fontColor('#FF4D4F')
        }
        .width('100%')
        .margin({ bottom: 8 })

        // 4. 店铺优惠券 (横向排列)
        Row({ space: 6 }) {
          this.CouponTag('领2元店铺券')
          this.CouponTag('领4元店铺券')
          this.CouponTag('领7元店铺券')
        }
        .width('100%')
        .margin({ bottom: 8 })

        // 5. 满减活动展示
        Row() {
          Text('满减')
            .fontSize(10)
            .fontColor('#FF8C00')
            .border({ width: 1, color: '#FF8C00' })
            .borderRadius(2)
            .padding({ left: 2, right: 2 })
            .margin({ right: 6 })

          Text('维达纸巾满49减5，满79减10，满99减15')
            .fontSize(11)
            .fontColor('#FF8C00')
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .layoutWeight(1) // 挤占剩余空间防止文字溢出
        }
        .width('100%')
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .backgroundColor(Color.White)
    .borderRadius(12)
    .padding(12)
    .margin({ bottom: 12 })
  }

  // 优惠券标签 Builder
  @Builder CouponTag(text: string) {
    Text(text)
      .fontSize(10)
      .fontColor('#FF4D4F')
      .border({ width: 1, color: '#FF4D4F' }) // 红色边框
      .borderRadius(2)
      .padding({ left: 4, right: 4, top: 2, bottom: 2 })
  }
}