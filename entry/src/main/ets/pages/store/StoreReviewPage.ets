import router from '@ohos.router';

@Entry
@Component
struct StoreReviewPage {
  // 0: 商家服务, 1: 店铺评价
  @State currentTabIndex: number = 0;
  // 评价分类 Tab 索引 (全部、好评、中评、差评)
  @State reviewFilterIndex: number = 0;
  @State onlyHasContent: boolean = true;

  build() {
    Column() {
      // === 1. 顶部导航栏 (含店铺缩略名与 Tab 切换) ===
      Row() {
        Image($r('app.media.back')) // 返回按钮
          .width(20).height(20).margin({ right: 12 })
          .onClick(() => { router.back(); })

        // 店铺名称缩略
        Row() {
          Image($r('app.media.startIcon')).width(16).height(16).borderRadius(2).margin({ right: 6 })
          Text('天虹商场-凤凰城...').fontSize(16).fontWeight(FontWeight.Bold).fontColor('#333333')
        }
        .layoutWeight(1)
        .justifyContent(FlexAlign.Center)

        // 占位平衡右侧
        Row().width(32)
      }
      .width('100%')
      .height(50)
      .padding({ left: 16, right: 16 })
      .backgroundColor(Color.White)

      // Tab 切换头 (商家服务 vs 店铺评价)
      Row() {
        Column() {
          Text('商家服务')
            .fontSize(15)
            .fontWeight(this.currentTabIndex === 0 ? FontWeight.Bold : FontWeight.Normal)
            .fontColor(this.currentTabIndex === 0 ? '#333333' : '#666666')
            .margin({ bottom: 8 })

          Divider()
            .color(this.currentTabIndex === 0 ? '#10C8A7' : Color.Transparent)
            .strokeWidth(3)
            .width(30)
            .lineCap(LineCapStyle.Round)
        }
        .layoutWeight(1)
        .onClick(() => { this.currentTabIndex = 0; })

        Column() {
          Text('店铺评价')
            .fontSize(15)
            .fontWeight(this.currentTabIndex === 1 ? FontWeight.Bold : FontWeight.Normal)
            .fontColor(this.currentTabIndex === 1 ? '#333333' : '#666666')
            .margin({ bottom: 8 })

          Divider()
            .color(this.currentTabIndex === 1 ? '#10C8A7' : Color.Transparent)
            .strokeWidth(3)
            .width(30)
            .lineCap(LineCapStyle.Round)
        }
        .layoutWeight(1)
        .onClick(() => { this.currentTabIndex = 1; })
      }
      .width('100%')
      .backgroundColor(Color.White)
      .border({ width: { bottom: 0.5 }, color: '#E5E5E5' })

      // === 2. 动态内容区 (根据 Tab 索引切换) ===
      if (this.currentTabIndex === 0) {
        // --- 视图A: 商家服务页面 ---
        Scroll() {
          Column() {
            // 公告卡片
            Column() {
              Text('公告')
                .fontSize(16)
                .fontWeight(FontWeight.Bold)
                .fontColor('#333333')
                .width('100%')
                .margin({ bottom: 12 })

              Text('亲~ 欢迎光临！如商品出现破损、质量问题、少送错送等问题，请第一时间电话联系本店客服，我们会及时为你处理好所有问题，让你满意！部分商品包装更替，请以实际收到为准。')
                .fontSize(13)
                .fontColor('#666666')
                .lineHeight(20)
            }
            .width('92%')
            .backgroundColor(Color.White)
            .borderRadius(12)
            .padding(16)
            .margin({ top: 16, bottom: 16 })
            .shadow({ radius: 4, color: 'rgba(0,0,0,0.03)', offsetY: 2 })

            // 店铺信息卡片
            Column() {
              Text('店铺信息')
                .fontSize(16)
                .fontWeight(FontWeight.Bold)
                .fontColor('#333333')
                .width('100%')
                .margin({ bottom: 16 })

              this.InfoRow('商品数量：', '11229件')
              this.InfoRow('关注人数：', '1207人')
              this.InfoRow('配送时间：', '08:30-22:00')
              this.InfoRow('门店地址：', '广东省深圳市龙山区民福街道 凤凰大道 龙岭一区1008号1-2层')
              this.InfoRow('地图导航：', '查看地图 (距你1.57km)', true)
              this.InfoRow('门店电话：', '0755-12345678', true)
            }
            .width('92%')
            .backgroundColor(Color.White)
            .borderRadius(12)
            .padding(16)
            .shadow({ radius: 4, color: 'rgba(0,0,0,0.03)', offsetY: 2 })
          }
          .width('100%')
        }
        .layoutWeight(1)
        .backgroundColor('#F8F8F8')

      } else {
        // --- 视图B: 店铺评价页面 ---
        Scroll() {
          Column() {
            // 综合评分头部卡片
            Row() {
              Column() {
                Text('4.3')
                  .fontSize(36)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#FF4D4F')
              }
              .margin({ right: 20 })

              Column() {
                Text('综合评分')
                  .fontSize(14)
                  .fontColor('#333333')
                  .fontWeight(FontWeight.Medium)
                  .margin({ bottom: 6 })

                // 五星评分图示
                Row({ space: 2 }) {
                  ForEach([1, 2, 3, 4, 5], () => {
                    Image($r('app.media.startIcon')).width(14).height(14)
                  })
                }
              }
              .alignItems(HorizontalAlign.Start)
            }
            .width('100%')
            .padding(16)
            .backgroundColor(Color.White)

            // 评价分类标签栏
            Row({ space: 8 }) {
              this.ReviewTag('全部(122)', 0)
              this.ReviewTag('好评(102)', 1)
              this.ReviewTag('中评(12)', 2)
              this.ReviewTag('差评(10)', 3)
            }
            .width('100%')
            .padding({ left: 16, right: 16, bottom: 12 })
            .backgroundColor(Color.White)

            // 只看有内容的评价勾选栏
            Row() {
              // 模拟复选框
              Row() {
                if (this.onlyHasContent) {
                  Circle({ width: 14, height: 14 }).fill('#10C8A7')
                }
              }
              .width(18).height(18)
              .border({ width: 1, color: '#10C8A7' })
              .borderRadius(4)
              .margin({ right: 8 })
              .onClick(() => { this.onlyHasContent = !this.onlyHasContent; })

              Text('只看有内容的评价')
                .fontSize(13)
                .fontColor('#666666')
            }
            .width('100%')
            .padding({ left: 16, right: 16, bottom: 16 })
            .backgroundColor(Color.White)
            .border({ width: { bottom: 0.5 }, color: '#F0F0F0' })

            // 评价列表项
            Column() {
              this.ReviewItem()
              this.ReviewItem()
            }
            .backgroundColor('#F8F8F8')
          }
          .width('100%')
        }
        .layoutWeight(1)
        .backgroundColor('#F8F8F8')
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8F8F8')
  }

  // --- 局部复用组件 ---

  @Builder InfoRow(label: string, value: string, isLink: boolean = false) {
    Row() {
      Text(label)
        .fontSize(13)
        .fontColor('#666666')
        .width(80)

      Text(value)
        .fontSize(13)
        .fontColor(isLink ? '#007DFF' : '#333333')
        .layoutWeight(1)
    }
    .width('100%')
    .margin({ bottom: 14 })
    .alignItems(VerticalAlign.Top)
  }

  @Builder ReviewTag(title: string, index: number) {
    Text(title)
      .fontSize(12)
      .fontColor(this.reviewFilterIndex === index ? Color.White : '#333333')
      .backgroundColor(this.reviewFilterIndex === index ? '#10C8A7' : '#F2F2F2')
      .padding({ left: 12, right: 12, top: 6, bottom: 6 })
      .borderRadius(16)
      .onClick(() => { this.reviewFilterIndex = index; })
  }

  @Builder ReviewItem() {
    Column() {
      // 用户头像与时间
      Row() {
        Image($r('app.media.startIcon'))
          .width(36).height(36).borderRadius(18).margin({ right: 10 })

        Column() {
          Text('j***8').fontSize(14).fontWeight(FontWeight.Medium).fontColor('#333333').margin({ bottom: 2 })
          Row({ space: 2 }) {
            ForEach([1, 2, 3, 4, 5], () => {
              Image($r('app.media.startIcon')).width(10).height(10)
            })
          }
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        Text('2099-05-14 09:20:45')
          .fontSize(11)
          .fontColor('#999999')
      }
      .width('100%')
      .margin({ bottom: 10 })

      // 评价正文
      Text('盼望着，盼望着，东风来了，春天的脚步近了。一切都像刚睡醒的样子，欣欣然张开了眼。山朗润起来了，水涨起来了，太阳的脸红起来了。')
        .fontSize(13)
        .fontColor('#333333')
        .lineHeight(18)
        .margin({ bottom: 10 })

      // 商家回复气泡
      Column() {
        Text('商家回复：盼望着，盼望着，东风来了，春天的脚步近了。一切都像刚睡醒的样子……')
          .fontSize(12)
          .fontColor('#666666')
          .lineHeight(16)
      }
      .width('100%')
      .backgroundColor('#F5F5F5')
      .padding(10)
      .borderRadius(6)
      .margin({ bottom: 10 })

      // 购买的商品带货标签 (赞同/踩)
      Row() {
        Image($r('app.media.startIcon')).width(14).height(14).margin({ right: 4 })
        Text('东北五常大米 10kg').fontSize(11).fontColor('#666666')
      }
      .width('100%')
    }
    .width('100%')
    .backgroundColor(Color.White)
    .padding(16)
    .margin({ bottom: 10 })
  }
}