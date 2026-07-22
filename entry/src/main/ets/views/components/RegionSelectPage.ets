import router from '@ohos.router';

@Entry
@Component
struct RegionSelectPage {
  // 模拟常用地区
  private commonRegions: Array<{ name: string, code: string }> = [
    { name: '中国', code: '+86' },
    { name: '中国香港', code: '+852' },
    { name: '中国澳门', code: '+853' },
    { name: '中国台湾', code: '+886' }
  ];

  // 模拟 A 字母开头的国家/地区
  private aRegions: Array<{ name: string, code: string }> = [
    { name: '阿尔巴尼亚', code: '+355' },
    { name: '阿尔及利亚', code: '+213' },
    { name: '阿根廷', code: '+54' },
    { name: '阿联酋', code: '+971' },
    { name: '阿曼', code: '+968' },
    { name: '阿塞拜疆', code: '+994' },
    { name: '爱尔兰', code: '+353' },
    { name: '埃及', code: '+20' },
    { name: '爱沙尼亚', code: '+372' }
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

          Text('国家地区')
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

        // 列表滚动区
        Scroll() {
          Column() {
            // --- 分组标题：常用 ---
            Text('常用')
              .fontSize(12)
              .fontColor('#999999')
              .width('100%')
              .padding({ left: 16, top: 12, bottom: 8 })

            // 常用列表
            Column() {
              List() {
                ForEach(this.commonRegions, (item) => {
                  ListItem() {
                    Row() {
                      Text(item.name).fontSize(14).fontColor('#333333')
                      Blank()
                      Text(item.code).fontSize(14).fontColor('#666666')
                    }
                    .width('100%')
                    .padding(16)
                    .onClick(() => {
                      // 返回上一页并传递选中的区号
                      router.back();
                    })
                  }
                })
              }
              .width('100%')
              .divider({ strokeWidth: 0.5, color: '#F0F0F0', startMargin: 16, endMargin: 16 })
            }
            .width('100%')
            .backgroundColor(Color.White)

            // --- 分组标题：A ---
            Text('A')
              .fontSize(12)
              .fontColor('#999999')
              .width('100%')
              .padding({ left: 16, top: 16, bottom: 8 })

            // A 组列表
            Column() {
              List() {
                ForEach(this.aRegions, (item) => {
                  ListItem() {
                    Row() {
                      Text(item.name).fontSize(14).fontColor('#333333')
                      Blank()
                      Text(item.code).fontSize(14).fontColor('#666666')
                    }
                    .width('100%')
                    .padding(16)
                    .onClick(() => {
                      router.back();
                    })
                  }
                })
              }
              .width('100%')
              .divider({ strokeWidth: 0.5, color: '#F0F0F0', startMargin: 16, endMargin: 16 })
            }
            .width('100%')
            .backgroundColor(Color.White)
            .margin({ bottom: 30 })
          }
          .width('100%')
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