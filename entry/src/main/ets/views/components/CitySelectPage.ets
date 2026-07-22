import router from '@ohos.router';

@Entry
@Component
struct CitySelectPage {
  // 模拟经常访问城市
  private frequentCities: string[] = ['北京', '杭州', '深圳'];

  // 模拟 A 组网格城市
  private aCities: string[] = [
    '阿坝', '阿克苏', '阿拉尔', '阿拉善', '阿勒泰', '阿里',
    '鞍山', '安康', '安庆', '安顺', '安阳', '澳门'
  ];

  // 模拟 B 组网格城市
  private bCities: string[] = [
    '巴彦淖尔', '巴音郭楞', '巴中', '白城', '白沙', '白山',
    '白银', '百色', '蚌埠', '包头', '保定', '保山',
    '保亭', '宝鸡', '北海', '北京', '北屯', '本溪'
  ];

  private alphabetList: string[] = ['★', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'J', 'K', 'L', 'M', 'N', 'P', 'Q', 'R', 'S', 'T', 'W', 'X', 'Y', 'Z'];

  build() {
    Stack({ alignContent: Alignment.TopEnd }) {

      // === 1. 顶部标题栏与主体滚动区域 ===
      Column() {
        // 顶部导航栏
        Row() {
          Image($r('app.media.startIcon'))
            .width(20).height(20)
            .onClick(() => { router.back(); })

          Text('选择城市')
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

        // 滚动内容区
        Scroll() {
          Column() {
            // --- 搜索框 ---
            Row() {
              Row() {
                Image($r('app.media.startIcon')).width(15).height(15).margin({ right: 8 })
                TextInput({ placeholder: '搜索城市或地区名称' })
                  .layoutWeight(1)
                  .height(36)
                  .backgroundColor(Color.Transparent)
                  .fontSize(13)
                  .padding(0)
              }
              .width('100%')
              .height(38)
              .backgroundColor('#F5F5F5')
              .borderRadius(19)
              .padding({ left: 14, right: 14 })
            }
            .width('92%')
            .margin({ top: 12, bottom: 16 })

            // --- 当前位置 ---
            Column() {
              Text('当前位置')
                .fontSize(12)
                .fontColor('#999999')
                .width('100%')
                .margin({ bottom: 8 })

              Row() {
                Row({ space: 4 }) {
                  Image($r('app.media.startIcon')).width(14).height(14)
                  Text('深圳').fontSize(14).fontColor('#333333').fontWeight(FontWeight.Medium)
                }
                .height(32)
                .padding({ left: 16, right: 16 })
                .backgroundColor(Color.White)
                .borderRadius(16)
                .shadow({ radius: 2, color: 'rgba(0,0,0,0.02)', offsetY: 1 })
              }
              .width('100%')
            }
            .width('92%')
            .margin({ bottom: 16 })
            .alignItems(HorizontalAlign.Start)

            // --- 经常访问 ---
            Column() {
              Text('经常访问')
                .fontSize(12)
                .fontColor('#999999')
                .width('100%')
                .margin({ bottom: 8 })

              Flex({ wrap: FlexWrap.Wrap }) {
                ForEach(this.frequentCities, (city: string) => {
                  Text(city)
                    .fontSize(14)
                    .fontColor('#333333')
                    .width('30%')
                    .height(36)
                    .textAlign(TextAlign.Center)
                    .backgroundColor(Color.White)
                    .borderRadius(18)
                    .margin({ right: '3.3%', bottom: 10 })
                    .shadow({ radius: 2, color: 'rgba(0,0,0,0.02)', offsetY: 1 })
                    .onClick(() => {
                      router.back();
                    })
                })
              }
              .width('100%')
            }
            .width('92%')
            .margin({ bottom: 10 })
            .alignItems(HorizontalAlign.Start)

            // --- 字母分组 A ---
            Column() {
              Text('A')
                .fontSize(12)
                .fontColor('#999999')
                .width('100%')
                .margin({ bottom: 8 })

              Flex({ wrap: FlexWrap.Wrap }) {
                ForEach(this.aCities, (city: string) => {
                  Text(city)
                    .fontSize(13)
                    .fontColor('#333333')
                    .width('30%')
                    .height(36)
                    .textAlign(TextAlign.Center)
                    .backgroundColor(Color.White)
                    .borderRadius(18)
                    .margin({ right: '3.3%', bottom: 10 })
                    .shadow({ radius: 2, color: 'rgba(0,0,0,0.02)', offsetY: 1 })
                })
              }
              .width('100%')
            }
            .width('92%')
            .margin({ bottom: 10 })
            .alignItems(HorizontalAlign.Start)

            // --- 字母分组 B ---
            Column() {
              Text('B')
                .fontSize(12)
                .fontColor('#999999')
                .width('100%')
                .margin({ bottom: 8 })

              Flex({ wrap: FlexWrap.Wrap }) {
                ForEach(this.bCities, (city: string) => {
                  Text(city)
                    .fontSize(13)
                    .fontColor('#333333')
                    .width('30%')
                    .height(36)
                    .textAlign(TextAlign.Center)
                    .backgroundColor(Color.White)
                    .borderRadius(18)
                    .margin({ right: '3.3%', bottom: 10 })
                    .shadow({ radius: 2, color: 'rgba(0,0,0,0.02)', offsetY: 1 })
                })
              }
              .width('100%')
            }
            .width('92%')
            .margin({ bottom: 30 })
            .alignItems(HorizontalAlign.Start)
          }
          .width('100%')
          .alignItems(HorizontalAlign.Center)
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
        .backgroundColor('#F8F8F8')
      }
      .width('100%')
      .height('100%')

      // === 2. 右侧固定 A-Z 快速字母索引条 ===
      Column() {
        ForEach(this.alphabetList, (letter: string) => {
          Text(letter)
            .fontSize(9)
            .fontColor('#666666')
            .margin({ bottom: 2 })
        })
      }
      .width(20)
      .height('80%')
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .position({ x: '95%', y: '15%' })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8F8F8')
  }
}