@Component
export struct HomeView {
  private categories: string[] = ['蔬菜豆品', '肉禽蛋', '海鲜水产', '水果鲜花', '乳品烘焙', '冷冻食品', '粮油调味', '酒水饮料', '休闲零食', '生活用品'];
  private tags: string[] = ['鸡蛋', '柠檬', '排骨', '草莓', '葡萄', '木瓜', '车厘子'];
  // 模拟商品双列数据
  private mockProductPairs: number[][] = [[1, 2], [3, 4], [5, 6]];

  build() {
    // 登录态不再需要 Stack 悬浮条，直接使用 Column 作为根节点
    Column() {
      // === 1. 固定在最顶部的绿色头部 (定位 + 搜索) ===
      Column() {
        Row() {
          Image($r('app.media.startIcon')).width(16).height(16).margin({ right: 4 })
          Text('碧桂园凤凰城').fontSize(16).fontColor(Color.White).fontWeight(FontWeight.Bold)
          Image($r('app.media.startIcon')).width(12).height(12).margin({ left: 4 })
          Blank()
          Image($r('app.media.startIcon')).width(24).height(24)
        }
        .width('100%')
        .padding({ left: 16, right: 16, top: 16, bottom: 12 })

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
      .backgroundColor('#10C8A7')
      .width('100%')

      // === 2. 核心可滚动区域 (包含吸顶逻辑) ===
      List() {
        // -- 非吸顶部分 --
        ListItem() {
          Column() {
            // 热搜词条区
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
            .borderRadius({ bottomLeft: 16, bottomRight: 16 })

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

        // -- 吸顶商品流部分 --
        ListItemGroup({ header: this.StickyTabHeader() }) {
          ForEach(this.mockProductPairs, (pair: number[]) => {
            ListItem() {
              Row({ space: 10 }) {
                this.HomeProductCard()
                this.HomeProductCard()
              }
              .width('92%')
              .margin({ left: '4%', right: '4%', bottom: 10 })
            }
          })
        }
      }
      .sticky(StickyStyle.Header)
      .scrollBar(BarState.Off)
      .layoutWeight(1)
      .backgroundColor('#F8F8F8')
    }
    .width('100%')
    .height('100%')
  }

  // --- 局部复用组件 ---

  @Builder StickyTabHeader() {
    Row() {
      this.TabTitle('好物推荐', '人气甄选', true)
      this.TabTitle('新品尝鲜', '新品抢购', false)
      this.TabTitle('优惠折扣', '就是便宜', false)
      this.TabTitle('猜你喜欢', '经常购买', false)
    }
    .width('100%')
    .padding({ left: 16, right: 16, top: 16, bottom: 16 })
    .backgroundColor('#F8F8F8')
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

  // ⭐️ 核心变化：带购物车图标的商品卡片
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

        // 价格与购物车同行布局
        Row() {
          Text('¥7.99').fontSize(16).fontColor('#FF4D4F').fontWeight(FontWeight.Bold).margin({ right: 4 })
          Text('¥9.90').fontSize(12).fontColor('#999999').decoration({ type: TextDecorationType.LineThrough })

          Blank() // 撑开中间空间，把购物车顶到最右侧

          // 新增：快速加购图标 (用圆形绿色背景 + 内部图标模拟)
          Stack({ alignContent: Alignment.Center }) {
            Circle({ width: 22, height: 22 }).fill('#10C8A7')
            Image($r('app.media.startIcon')) // 后期替换为真实的白色购物车切图
              .width(12)
              .height(12)
          }
          .onClick(() => {
            // TODO: 加入购物车动画逻辑
          })
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
    .layoutWeight(1)
    .backgroundColor(Color.White)
    .borderRadius(8)
  }
}