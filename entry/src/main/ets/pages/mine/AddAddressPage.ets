import router from '@ohos.router';
const PRIMARY_COLOR: string = '#00C896'
const TEXT_MAIN: string = '#333333'
const TEXT_PLACEHOLDER: string = '#CCCCCC'
const INPUT_BG: string = '#F7F7F7'
const BG_WHITE: string = '#FFFFFF'

@Entry
@Component
export struct AddAddressPage {
  // 表单数据
  @State receiverName: string = ''
  @State phoneNum: string = ''
  @State areaAddr: string = ''
  @State detailAddr: string = ''
  @State selectedTag: string = ''
  @State isDefault: boolean = false

  build() {
    Column() {
      // 顶部导航栏
      this.NavBar()

      Scroll() {
        Column() {
          // 收货人输入框
          this.InputItem('收货人', '填写收货人', (v: string) => this.receiverName = v)

          // 手机号输入框
          this.PhoneInputItem()

          // 收货地区选择
          this.AreaSelectItem()

          // 楼号门牌输入
          this.InputItem('楼号门牌', '例：12号楼806室', (v: string) => this.detailAddr = v)

          // 地址标签 家/公司/学校
          this.TagSelectArea()

          // 设为默认开关
          this.SwitchItem()

          Blank().height(40)

          // 底部保存按钮
          Button('保存', { type: ButtonType.Normal })
            .width('100%')
            .height(56)
            .fontSize(18)
            .fontColor(BG_WHITE)
            .backgroundColor(PRIMARY_COLOR)
            .borderRadius(12)
            .onClick(() => {
              // 保存地址接口逻辑
              console.info('新增地址', this.receiverName, this.phoneNum, this.areaAddr, this.detailAddr, this.selectedTag, this.isDefault)
              router.back()
            })
        }
        .width('100%')
        .padding({ left: 16, right: 16, top: 20 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BG_WHITE)
  }

  /** 顶部导航 返回+标题 */
  @Builder
  NavBar() {
    Row() {
      Image($r('app.media.back'))
        .width(24)
        .height(24)
        .onClick(() => router.back())
      Blank()
      Text('添加收货地址')
        .fontSize(22)
        .fontWeight(FontWeight.Medium)
        .fontColor(TEXT_MAIN)
      Blank()
      Rect().width(24).height(24).fillOpacity(0)
    }
    .width('100%')
    .height(64)
    .padding({ left: 16, right: 16 })
  }

  /** 通用单行输入框组件 */
  @Builder
  InputItem(label: string, placeholder: string, onChange: (val: string)=>void) {
    Column() {
      Row() {
        Text(label)
          .fontSize(18)
          .fontColor(TEXT_MAIN)
          .width(80)
        TextInput({ text: '', placeholder: placeholder })
          .layoutWeight(1)
          .height(48)
          .backgroundColor(INPUT_BG)
          .borderRadius(8)
          .fontSize(16)
          .fontColor(TEXT_MAIN)
          .placeholderFont({ size:16 })
          .placeholderColor(TEXT_PLACEHOLDER)
          .padding({ left:12, right:12 })
          .onChange(onChange)
      }
      .width('100%')
      .margin({ top:14 })
    }
  }

  /** 手机号带区号下拉 */
  @Builder
  PhoneInputItem() {
    Row() {
      Text('手机号')
        .fontSize(18)
        .fontColor(TEXT_MAIN)
        .width(80)
      Row() {
        Text('+86')
          .fontSize(16)
          .fontColor(TEXT_MAIN)
        Rect().width(1).height(20).fill('#DDDDDD').margin({left:10, right:10})
        TextInput({ text:'', placeholder:'填写手机号' })
          .layoutWeight(1)
          .height(48)
          .backgroundColor(INPUT_BG)
          .borderRadius(8)
          .fontSize(16)
          .placeholderFont({ size:16 })
          .placeholderColor(TEXT_PLACEHOLDER)
          .onChange((v:string)=>this.phoneNum = v)
      }
      .layoutWeight(1)
      .height(48)
      .backgroundColor(INPUT_BG)
      .borderRadius(8)
      .padding({left:12})
    }
    .width('100%')
    .margin({ top:14 })
  }

  /** 地区选择 带定位图标 */
  @Builder
  AreaSelectItem() {
    Row() {
      Text('收货地址')
        .fontSize(18)
        .fontColor(TEXT_MAIN)
        .width(80)
      Row() {
        Text('点击选择收货地址')
          .fontSize(16)
          .fontColor(TEXT_PLACEHOLDER)
        Blank()
        Image($r('app.media.dingwei'))
          .width(22)
          .height(22)
      }
      .layoutWeight(1)
      .height(48)
      .backgroundColor(INPUT_BG)
      .borderRadius(8)
      .padding({ left:12, right:12 })
      .onClick(()=>{
        // 跳转城市/地区选择页
        router.pushUrl({url:'pages/mine/SelectCityPage'})
      })
    }
    .width('100%')
    .margin({ top:14 })
  }

  /** 地址标签：公司、家、学校 */
  @Builder
  TagSelectArea() {
    Row() {
      Text('地址标签')
        .fontSize(18)
        .fontColor(TEXT_MAIN)
        .width(80)
      Row() {
        this.TagBtn('公司')
        Blank().width(10)
        this.TagBtn('家')
        Blank().width(10)
        this.TagBtn('学校')
        Blank().width(10)
      }
      .layoutWeight(1)
    }
    .width('100%')
    .margin({ top:24 })
  }

  /** 单个标签按钮 */
  @Builder
  TagBtn(tagName:string) {
    Text(tagName)
      .fontSize(16)
      .width(80)
      .height(40)
      .textAlign(TextAlign.Center)
      .border({ width:1, color: this.selectedTag===tagName ? PRIMARY_COLOR : '#EEEEEE', radius:8 })
      .fontColor(this.selectedTag===tagName ? PRIMARY_COLOR : TEXT_MAIN)
      .backgroundColor(this.selectedTag===tagName ? '#F0FFFA' : BG_WHITE)
      .onClick(()=>{
        this.selectedTag = this.selectedTag === tagName ? '' : tagName
      })
  }

  /** 设为默认开关行 */
  @Builder
  SwitchItem() {
    Row() {
      Text('设为默认')
        .fontSize(18)
        .fontColor(TEXT_MAIN)
      Blank()
      Toggle({ type: ToggleType.Switch, isOn: this.isDefault })
        .selectedColor(PRIMARY_COLOR)
        .onChange((val:boolean)=> this.isDefault = val)
    }
    .width('100%')
    .margin({ top:24 })
  }
}
