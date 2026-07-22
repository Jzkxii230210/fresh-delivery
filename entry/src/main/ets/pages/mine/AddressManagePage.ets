import router from '@ohos.router';

@Entry
@Component
struct AddressManagePage {
  // 页面模式判断：true 为编辑，false 为新增
  @State isEditMode: boolean = true;
  @State recipientName: string = '张小乙';
  @State phoneNum: string = '13612345678';
  @State locationAddress: string = '广东省深圳市龙华区民福街道 凤凰大道龙岭二区';
  @State houseNumber: string = '38栋302室';
  @State selectedTag: string = '家';
  @State isDefaultChecked: boolean = false;

  private tags: string[] = ['公司', '家', '学校'];

  build() {
    Column() {
      // === 1. 顶部标题栏 ===
      Row() {
        Image($r('app.media.startIcon'))
          .width(20).height(20).margin({ right: 12 })
          .onClick(() => { router.back(); })

        Text(this.isEditMode ? '编辑收货地址' : '添加收货地址')
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

      // === 2. 表单填写区域 ===
      Scroll() {
        Column() {
          Column() {
            // 收货人
            this.FormInputRow('收货人', '填写收货人', this.recipientName, (val) => { this.recipientName = val; })
            Divider().color('#F0F0F0').strokeWidth(0.5)

            // 手机号
            Row() {
              Text('手机号').fontSize(14).fontColor('#333333').width(80)

              Row({ space: 6 }) {
                Text('+86').fontSize(13).fontColor('#333333')
                Image($r('app.media.startIcon')).width(10).height(10)
              }
              .margin({ right: 12 })
              .padding({ right: 12 })
              .border({ width: { right: 0.5 }, color: '#E0E0E0' })

              TextInput({ text: this.phoneNum, placeholder: '填写手机号' })
                .layoutWeight(1)
                .height(44)
                .backgroundColor(Color.Transparent)
                .fontSize(14)
                .padding(0)
                .onChange((val) => { this.phoneNum = val; })
            }
            .width('100%')
            .height(50)
            .border({ width: { bottom: 0.5 }, color: '#F0F0F0' })

            // 收货地址 (点击跳转地图搜索)
            Row() {
              Text('收货地址').fontSize(14).fontColor('#333333').width(80)

              Text(this.locationAddress)
                .fontSize(14)
                .fontColor(this.locationAddress ? '#333333' : '#999999')
                .layoutWeight(1)
                .maxLines(1)
                .textOverflow({ overflow: TextOverflow.Ellipsis })

              Image($r('app.media.startIcon')) // 定位图标
                .width(16).height(16)
                .margin({ left: 8 })
            }
            .width('100%')
            .height(50)
            .border({ width: { bottom: 0.5 }, color: '#F0F0F0' })
            .onClick(() => {
              // TODO: 跳转地图搜索页 (AddressSearchPage)
            })

            // 楼号门牌
            this.FormInputRow('楼号门牌', '例：12号楼806室', this.houseNumber, (val) => { this.houseNumber = val; })
            Divider().color('#F0F0F0').strokeWidth(0.5)

            // 地址标签
            Row() {
              Text('地址标签').fontSize(14).fontColor('#333333').width(80)

              Row({ space: 10 }) {
                ForEach(this.tags, (tag: string) => {
                  Text(tag)
                    .fontSize(12)
                    .fontColor(this.selectedTag === tag ? '#10C8A7' : '#666666')
                    .backgroundColor(this.selectedTag === tag ? '#E6F8F5' : '#F5F5F5')
                    .border({ width: 0.5, color: this.selectedTag === tag ? '#10C8A7' : Color.Transparent })
                    .borderRadius(14)
                    .padding({ left: 14, right: 14, top: 5, bottom: 5 })
                    .onClick(() => {
                      this.selectedTag = tag;
                    })
                })
              }
            }
            .width('100%')
            .height(55)
            .border({ width: { bottom: 0.5 }, color: '#F0F0F0' })

            // 设为默认开关
            Row() {
              Text('设为默认').fontSize(14).fontColor('#333333')
              Blank()
              Toggle({ type: ToggleType.Switch, isOn: this.isDefaultChecked })
                .selectedColor('#10C8A7')
                .onChange((isOn) => {
                  this.isDefaultChecked = isOn;
                })
            }
            .width('100%')
            .height(55)
          }
          .width('92%')
          .backgroundColor(Color.White)
          .borderRadius(12)
          .padding({ left: 16, right: 16 })
          .margin({ top: 12, bottom: 20 })
          .shadow({ radius: 4, color: 'rgba(0,0,0,0.03)', offsetY: 2 })

          // 保存按钮
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
              // TODO: 保存或更新地址逻辑
              router.back();
            })

          // 编辑模式下额外显示删除按钮
          if (this.isEditMode) {
            Text('删除')
              .fontSize(14)
              .fontColor('#FF4D4F')
              .width('100%')
              .textAlign(TextAlign.Center)
              .padding(10)
              .onClick(() => {
                // TODO: 删除地址逻辑
                router.back();
              })
          }
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

  // --- 辅助 Builder：通用表单输入行 ---
  @Builder FormInputRow(label: string, placeholderStr: string, val: string, onChangeCallback: (val: string) => void) {
    Row() {
      Text(label).fontSize(14).fontColor('#333333').width(80)
      TextInput({ text: val, placeholder: placeholderStr })
        .layoutWeight(1)
        .height(44)
        .backgroundColor(Color.Transparent)
        .fontSize(14)
        .padding(0)
        .onChange(onChangeCallback)
    }
    .width('100%')
    .height(50)
  }
}