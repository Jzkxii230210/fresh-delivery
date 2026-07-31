import router from '@ohos.router';
// 全局配色常量
const PRIMARY_COLOR: string = '#00C896'
const TEXT_MAIN: string = '#333333'
const TEXT_SECOND: string = '#999999'
const BG_WHITE: string = '#FFFFFF'
const BG_PAGE: string = '#F7F7F7'
const LINE_GRAY: string = '#EEEEEE'

// 地址数据模型
interface AddressItem {
  id: string
  name: string
  phone: string
  tag: string // 家/公司/学校/无
  fullAddress: string
  isDefault: boolean
}

@Entry
@Component
export struct SelectAddressPage {
  @State city: string = '深圳市'
  @State addressList: AddressItem[] = [
    {
      id: '1',
      name: '张小乙',
      phone: '13612345678',
      tag: '家',
      fullAddress: '广东省深圳市龙华区民福街道 凤凰大道 龙岭十二区38栋',
      isDefault: true
    },
    {
      id: '2',
      name: '张小乙',
      phone: '13812345678',
      tag: '公司',
      fullAddress: '广东省深圳市龙华区民福街道 凤凰大道 东方银座C栋3008',
      isDefault: false
    },
    {
      id: '3',
      name: '张小乙',
      phone: '13612345678',
      tag: '学校',
      fullAddress: '广东省深圳市龙华区民福街道 凤凰大道 民治小学',
      isDefault: false
    },
    {
      id: '4',
      name: '张小枕头',
      phone: '13612345678',
      tag: '',
      fullAddress: '广东省深圳市龙华区民福街道 凤凰大道 龙岭十二区38栋',
      isDefault: false
    }
  ]

  build() {
    Column() {
      // 顶部导航栏
      this.NavBar()

      Scroll() {
        Column() {
          // 城市选择 + 搜索框
          this.CitySearchBar()

          // 地图定位区域
          this.LocationBox()

          // 我的收货地址标题
          Text('我的收货地址')
            .fontSize(15)
            .fontColor(TEXT_SECOND)
            .width('100%')
            .margin({ top: 20, left: 16 })

          // 地址列表卡片
          Column() {
            ForEach(this.addressList, (addr: AddressItem, index: number) => {
              this.AddressItem(addr)
              if (index !== this.addressList.length - 1) {
                Rect().width('100%').height(1).fill(LINE_GRAY).margin({ left: 16, right: 16 })
              }
            })
          }
          .width('100%')
          .backgroundColor(BG_WHITE)
          .borderRadius(12)
          .margin({ top: 12 })
        }
        .width('100%')
        .padding({ left: 16, right: 16, top: 12, bottom: 120 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      // 底部新增地址按钮
      Button('+ 新增地址', { type: ButtonType.Normal })
        .width('92%')
        .height(52)
        .margin({ left: 16, right: 16, bottom: 24 })
        .fontSize(18)
        .fontColor(PRIMARY_COLOR)
        .backgroundColor(BG_WHITE)
        .border({ width: 1, color: PRIMARY_COLOR, radius: 12 })
        .onClick(() => {
          router.pushUrl({ url: 'pages/mine/AddAddressPage' })
        })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BG_PAGE)
  }

  /** 顶部导航栏 关闭 + 标题 */
  @Builder
  NavBar() {
    Row() {
      Text('×')
        .fontSize(26)
        .fontColor(TEXT_MAIN)
        .width(40)
        .textAlign(TextAlign.Center)
        .onClick(() => router.back())
      Blank()
      Text('选择收货地址')
        .fontSize(22)
        .fontWeight(FontWeight.Medium)
        .fontColor(TEXT_MAIN)
      Blank()
      Rect().width(40).height(30).fillOpacity(0)
    }
    .width('100%')
    .height(64)
    .padding({ left: 12, right: 12 })
    .backgroundColor(BG_PAGE)
  }

  /** 城市下拉 + 搜索框 */
  @Builder
  CitySearchBar() {
    Row() {
      Row() {
        Text(this.city).fontSize(16).fontColor(TEXT_MAIN)
        Text('∨').fontSize(14).fontColor(TEXT_SECOND).margin({ left: 4 })
      }
      .padding({ left: 8, right: 8, top: 6, bottom: 6 })

      Rect().width(1).height(24).fill(LINE_GRAY)

      Row() {
        Image($r('app.media.search')).width(16).height(16)
        Text('输入小区/写字楼/学校等')
          .fontSize(14)
          .fontColor(TEXT_SECOND)
          .margin({ left: 6 })
      }
      .layoutWeight(1)
      .padding({ left: 10, right: 10, top: 6, bottom: 6 })
    }
    .width('100%')
    .backgroundColor(BG_WHITE)
    .borderRadius(8)
    .padding({ left: 8, right: 8 })
    .margin({ top: 10 })
  }

  /** 地图定位模块 */
  @Builder
  LocationBox() {
    Column() {
      Text('地图定位').fontSize(15).fontColor(TEXT_SECOND).width('100%').margin({ left: 4, bottom: 10 })
      Row() {
        Image($r('app.media.dingwei'))
          .width(22).height(22)
        Text('点击定位当前地点')
          .fontSize(16)
          .fontColor(PRIMARY_COLOR)
          .margin({ left: 8 })
      }
      .width('100%')
      .padding({ top: 14, bottom: 14, left: 16 })
      .backgroundColor(BG_WHITE)
      .borderRadius(8)
    }
    .width('100%')
    .margin({ top: 16 })
  }

  /** 单条地址条目 */
  @Builder
  CheckMark() {
    Text('✓').fontSize(14).fontColor('#fff')
  }

  @Builder
  AddressItem(addr: AddressItem) {
    Row() {
      // 单选圆圈
      Circle()
        .width(22).height(22)
        .fill(addr.isDefault ? PRIMARY_COLOR : BG_WHITE)
        .border({ width: 1, color: addr.isDefault ? PRIMARY_COLOR : TEXT_SECOND })
        .overlay(addr.isDefault ? this.CheckMark() : '')
        .margin({ left: 16, right: 12 })

      Column() {
        // 姓名+电话+标签行
        Row() {
          Text(addr.name).fontSize(17).fontColor('#000')
          Text(` ${addr.phone}`).fontSize(17).fontColor('#000')
          if (addr.isDefault) {
            Text('默认')
              .fontSize(12).fontColor('#fff')
              .padding({ left: 6, right: 6, top: 2, bottom: 2 })
              .backgroundColor(PRIMARY_COLOR)
              .borderRadius(4)
              .margin({ left: 6 })
          }
          if (addr.tag) {
            Text(addr.tag)
              .fontSize(12).fontColor(PRIMARY_COLOR)
              .padding({ left: 6, right: 6, top: 2, bottom: 2 })
              .border({ width:1, color:PRIMARY_COLOR, radius:4 })
              .margin({ left: 4 })
          }
        }
        .width('100%')

        // 完整地址
        Text(addr.fullAddress)
          .fontSize(14)
          .fontColor(TEXT_SECOND)
          .width('100%')
          .margin({ top: 6 })
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      // 编辑图标
      Image($r('app.media.more'))
        .width(22).height(22)
        .margin({ right: 16 })
        .onClick(() => {
          router.pushUrl({ url: 'pages/mine/EditAddressPage', params: { addressId: addr.id } })
        })
    }
    .width('100%')
    .padding({ top: 18, bottom: 18 })
  }
}
