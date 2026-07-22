@Component
export struct HomeUnloginView {
  private categories: string[] = ['蔬菜豆品', '肉禽蛋', '海鲜水产', '水果鲜花', '乳品烘焙', '冷冻食品', '粮油调味', '酒水饮料', '休闲零食', '生活用品'];
  private tags: string[] = ['鸡蛋', '柠檬', '排骨', '草莓', '葡萄', '木瓜', '车厘子'];
  // 将商品模拟为二维数组，方便在 List 中使用 Row 渲染双列
  private mockProductPairs: number[][] = [[1, 2], [3, 4], [5, 6]];

  build() {
    Stack({ alignContent: Alignment.Bottom }) {

      Column() {
        // === 1. 固定在最顶部的绿色头部 (定位 + 搜索) ===
        Column() {
          // 定位与消息栏
          Row() {
            Image($r('app.media.startIcon')).width(16).height(16).margin({ right: 4 })
            Text('碧桂园凤凰城').fontSize(16).fontColor(Color.White).fontWeight(FontWeight.Bold)
            Image($r('app.media.startIcon')).width(12).height(12).margin({ left: 4 })
            Blank()
            Image($r('app.media.startIcon')).width(24).height(24)
          }
          .width('100%')
          .padding({ left: 16, right: 16, top: 16, bottom: 12 })

          // 搜索框
          Row() {
            Image($r('app.media.startIcon')).width(16).height(16).margin({ right: 8 })
            Text('搜索商品').fontSize(14).fontColor('#999999')
          }
          .width('92%')
          .height(36)
          .backgroundColor(Color.White)
          .borderRadius(18)
          .padding({ left: 16 })
          .margin({ bottom: 8 })
        }
        .backgroundColor('#10C8A7') // 品牌绿
        .width('100%')

        // === 2. 核心可滚动区域 (使用 List 实现吸顶) ===
        List() {
          // -- 非吸顶部分 (滑动会隐藏) --
          ListItem() {
            Column() {
              // 绿色的热搜词条区 (背景与固定头部衔接，底部带圆角)
              Column() {
                List({ space: 12 }) {
                  ForEach(this.tags, (tag: string) => {
                    ListItem() {
                      Text(tag)
                        .fontSize(12)
                        .fontColor(Color.White)
                        .backgroundColor('rgba(255, 255, 255, 0.2)')
                        .padding({ left: 10, right: 10, top: 4, bottom: 4 })
                        .borderRadius(12)
                    }
                  })
                }
                .listDirection(Axis.Horizontal)
                .scrollBar(BarState.Off)
                .width('92%')
                .margin({ bottom: 12 })
              }
              .backgroundColor('#10C8A7')
              .width('100%')
              .borderRadius({ bottomLeft: 16, bottomRight: 16 }) // 底部大圆角

              // 十宫格分类区
              Grid() {
                ForEach(this.categories, (item: string) => {
                  GridItem() {
                    Column() {
                      Image($r('app.media.startIcon')).width(44).height(44).borderRadius(22).margin({ bottom: 6 })
                      Text(item).fontSize(12).fontColor('#333333')
                    }
                  }
                })
              }
              .columnsTemplate('1fr 1fr 1fr 1fr 1fr')
              .rowsTemplate('1fr 1fr')
              .rowsGap(16)
              .width('100%')
              .height(160)
              .padding({ top: 16 })
              .backgroundColor(Color.White)

              // 一公里商家区
              Column() {
                Row() {
                  Text('一公里商家').fontSize(16).fontWeight(FontWeight.Bold).fontColor('#333333')
                  Blank()
                  Text('更多 >').fontSize(12).fontColor('#999999')
                }
                .width('100%')
                .padding({ left: 16, right: 16, top: 16, bottom: 12 })

                List({ space: 12 }) {
                  ListItem().margin({ left: 16 })
                  ForEach([1, 2, 3, 4], (item: number) => {
                    ListItem() { this.MerchantCard() }
                  })
                  ListItem().margin({ right: 4 })
                }
                .listDirection(Axis.Horizontal)
                .scrollBar(BarState.Off)
                .width('100%')
              }
              .backgroundColor(Color.White)
              .margin({ top: 10 })
              .padding({ bottom: 16 })
            }
            .backgroundColor('#F8F8F8')
          }

          // -- 吸顶部分 (ListItemGroup) --
          ListItemGroup({ header: this.StickyTabHeader() }) {
            ForEach(this.mockProductPairs, (pair: number[]) => {
              ListItem() {
                // 使用 Row 实现双列瀑布流排版
                Row({ space: 10 }) {
                  this.HomeProductCard()
                  this.HomeProductCard()
                }
                .width('92%')
                .margin({ left: '4%', right: '4%', bottom: 10 })
              }
            })
            // 底部留白，防止商品被悬浮条遮挡
            ListItem() {
              Row().height(80).width('100%')
            }
          }
        }
        // 关键属性：开启 ListItemGroup 的头部吸顶效果
        .sticky(StickyStyle.Header)
        .scrollBar(BarState.Off)
        .layoutWeight(1) // 占满下方剩余空间
        .backgroundColor('#F8F8F8')
      }
      .width('100%')
      .height('100%')

      // === 3. 绝对定位悬浮层 (半遮挡登录提示条) ===
      Row() {
        Text('登录小默买菜，解锁更多功能~')
          .fontSize(14)
          .fontColor(Color.White)
          .layoutWeight(1)

        Button('立即登录')
          .width(80)
          .height(30)
          .backgroundColor('#10C8A7')
          .fontColor(Color.White)
          .fontSize(13)
          .borderRadius(15)
          .onClick(() => {
            // TODO: 跳转至登录页面
          })
      }
      .width('92%')
      .height(50)
      .backgroundColor('rgba(0, 0, 0, 0.65)')
      .borderRadius(25)
      .padding({ left: 20, right: 10 })
      .margin({ bottom: 16 })
    }
    .width('100%')
    .height('100%')
  }


  // --- 局部复用组件 ---

  // 吸顶的 Tab 栏 Builder
  @Builder StickyTabHeader() {
    Row() {
      this.TabTitle('好物推荐', '人气甄选', true)
      this.TabTitle('新品尝鲜', '新品抢购', false)
      this.TabTitle('优惠折扣', '就是便宜', false)
      this.TabTitle('猜你喜欢', '经常购买', false)
    }
    .width('100%')
    .padding({ left: 16, right: 16, top: 16, bottom: 16 })
    .backgroundColor('#F8F8F8') // 滑动上去后背景不透明，遮挡底部内容
    .justifyContent(FlexAlign.SpaceBetween)
  }

  @Builder MerchantCard() {
    Column() {
      Image($r('app.media.startIcon')).width(90).height(90).borderRadius(8).margin({ bottom: 8 })
      Text('天虹商场-凤凰...').fontSize(12).fontColor('#333333').maxLines(1).textOverflow({ overflow: TextOverflow.Ellipsis })
      Text('超市·100m内').fontSize(11).fontColor('#999999').margin({ top: 4 })
    }
    .width(90)
    .alignItems(HorizontalAlign.Start)
  }

  @Builder TabTitle(title: string, subTitle: string, isSelected: boolean) {
    Column() {
      Text(title)
        .fontSize(15)
        .fontWeight(isSelected ? FontWeight.Bold : FontWeight.Normal)
        .fontColor(isSelected ? '#333333' : '#666666')
        .margin({ bottom: 4 })
      Text(subTitle)
        .fontSize(11)
        .fontColor(isSelected ? '#10C8A7' : '#999999')
        .backgroundColor(isSelected ? 'rgba(16, 200, 167, 0.1)' : Color.Transparent)
        .padding({ left: 6, right: 6, top: 2, bottom: 2 })
        .borderRadius(8)
    }
  }

  // 还原截图细节的商品卡片
  @Builder HomeProductCard() {
    Column() {
      Image($r('app.media.startIcon')).width('100%').aspectRatio(1).borderRadius({ topLeft: 8, topRight: 8 })

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
        }
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
          .padding({ left: 18 }) // 对齐上面的文字
      }
      .padding(10)
      .alignItems(HorizontalAlign.Start)
      .width('100%')
    }
    .layoutWeight(1) // 在双列排版中均分空间
    .backgroundColor(Color.White)
    .borderRadius(8)
  }
}