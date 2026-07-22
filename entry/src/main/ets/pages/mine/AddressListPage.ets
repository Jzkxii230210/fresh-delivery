import router from '@ohos.router';

@Entry
@Component
struct AddressListPage {
  // 控制当前是否有地址状态（用于展示空状态或列表）
  @State hasAddress: boolean = true;

  // 模拟地址列表数据
  private addressList: Array<{
    name: string,
    phone: string,
    detail: string,
    tag: string,
    isDefault: boolean,
    tagType: 'home' | 'company' | 'school' | 'other'
  }> = [
    { name: '张小乙', phone: '13612345678', detail: '广东省深圳市龙华区民福街道 凤凰大道龙岭十二区38栋', tag: '家', isDefault: true, tagType: 'home' },
    { name: '张小乙', phone: '13612345678', detail: '广东省深圳市龙华区民福街道 凤凰大道东方银座C栋3008', tag: '公司', isDefault: false, tagType: 'company' },
    { name: '张小乙', phone: '13612345678', detail: '广东省深圳市龙华区民福街道 凤凰大道民治小学', tag: '学校', isDefault: false, tagType: 'school' },
    { name: '张小枕头', phone: '13612345678', detail: '广东省深圳市龙华区民福街道 凤凰大道龙岭十二区38栋', tag: '张', isDefault: false, tagType: 'other' }
  ];

  build() {
    Stack({ alignContent: Alignment.Bottom }) {

      // === 1. 顶部标题栏与主体内容 ===
      Column() {
        // 顶部导航栏
        Row() {
          Image($r('app.media.startIcon'))
            .width(20).height(20).margin({ right: 12 })
            .onClick(() => { router.back(); })

          Text('收货地址')
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

        // 动态切换：空状态 vs 地址列表
        if (!this.hasAddress) {
          // --- 空状态视图 ---
          Column() {
            Image($r('app.media.startIcon'))
              .width(120).height(120)
              .margin({ bottom: 16 })

            Text('暂无地址')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor('#333333')
              .margin({ bottom: 6 })

            Text('你还没有添加收货地址')
              .fontSize(13)
              .fontColor('#999999')
          }
          .width('100%')
          .layoutWeight(1)
          .justifyContent(FlexAlign.Center)
          .backgroundColor('#F8F8F8')
        } else {
          // --- 有地址的列表视图 ---
          Scroll() {
            Column() {
              List({ space: 12 }) {
                ForEach(this.addressList, (item) => {
                  ListItem() {
                    this.AddressCardItem(item)
                  }
                })
              }
              .width('92%')
              .padding({ top: 12, bottom: 90 }) // 底部留白防止被固定按钮遮挡
            }
            .width('100%')
          }
          .scrollBar(BarState.Off)
          .layoutWeight(1)
          .backgroundColor('#F8F8F8')
        }
      }
      .width('100%')
      .height('100%')

      // === 2. 底部固定的“添加收货地址”按钮 ===
      Row() {
        Button('+ 添加收货地址')
          .width('100%')
          .height(44)
          .backgroundColor('#10C8A7')
          .fontColor(Color.White)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .borderRadius(22)
          .onClick(() => {
            // TODO: 跳转到添加/编辑地址页
            // router.pushUrl({ url: 'pages/address/AddressEditPage' })
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

  // --- 局部复用组件：单条地址卡片 ---
  @Builder AddressCardItem(item: { name: string, phone: string, detail: string, tag: string, isDefault: boolean, tagType: string }) {
    Row() {
      // 左侧标签图标 (家、公司、学校或文字头像)
      Stack({ alignContent: Alignment.Center }) {
        Circle({ width: 36, height: 36 })
          .fill(item.tagType === 'home' ? '#10C8A7' : item.tagType === 'company' ? '#FF9800' : item.tagType === 'school' ? '#2F80ED' : '#B8E986')

        Text(item.tag)
          .fontSize(12)
          .fontColor(Color.White)
          .fontWeight(FontWeight.Bold)
      }
      .margin({ right: 12 })

      // 中间详细信息
      Column() {
        Row({ space: 8 }) {
          Text(item.name)
            .fontSize(15)
            .fontWeight(FontWeight.Bold)
            .fontColor('#333333')

          Text(item.phone)
            .fontSize(13)
            .fontColor('#666666')

          if (item.isDefault) {
            Text('默认')
              .fontSize(10)
              .fontColor('#10C8A7')
              .border({ width: 0.5, color: '#10C8A7' })
              .borderRadius(2)
              .padding({ left: 4, right: 4, top: 1, bottom: 1 })
          }
        }
        .width('100%')
        .margin({ bottom: 6 })

        Text(item.detail)
          .fontSize(13)
          .fontColor('#333333')
          .lineHeight(18)
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      // 右侧编辑按钮 (✏️)
      Image($r('app.media.startIcon'))
        .width(18)
        .height(18)
        .margin({ left: 12 })
        .onClick(() => {
          // TODO: 跳转编辑页
        })
    }
    .width('100%')
    .backgroundColor(Color.White)
    .borderRadius(12)
    .padding(16)
    .shadow({ radius: 4, color: 'rgba(0,0,0,0.03)', offsetY: 2 })
  }
}