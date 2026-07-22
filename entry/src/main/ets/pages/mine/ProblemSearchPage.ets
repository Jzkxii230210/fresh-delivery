import router from '@ohos.router';

@Entry
@Component
struct ProblemSearchPage {
  @State searchQuery: string = '';
  @State isResultMode: boolean = false;

  private searchHistory: string[] = [
    '手机号', '订单问题', '验证码', '登录问题',
    '修改昵称', '用户头像', '账号注销', '第三方登录',
    '配送慢', '用户注册'
  ];

  private searchResults: string[] = [
    '账号密码怎么修改？',
    '账号如何注销？'
  ];

  build() {
    Column() {
      // === 1. 顶部搜索导航栏 ===
      Row() {
        Image($r('app.media.startIcon'))
          .width(20).height(20).margin({ right: 12 })
          .onClick(() => {
            if (this.isResultMode) {
              this.isResultMode = false;
              this.searchQuery = '';
            } else {
              router.back();
            }
          })

        // 搜索输入框
        Row() {
          Image($r('app.media.startIcon')).width(16).height(16).margin({ right: 8 })

          TextInput({ text: this.searchQuery, placeholder: '输入问题关键词' })
            .layoutWeight(1)
            .height(36)
            .backgroundColor(Color.Transparent)
            .fontSize(14)
            .padding(0)
            .onChange((value: string) => {
              this.searchQuery = value;
            })
            .onSubmit(() => {
              if (this.searchQuery.trim() !== '') {
                this.isResultMode = true;
              }
            })

          if (this.isResultMode && this.searchQuery !== '') {
            Image($r('app.media.startIcon'))
              .width(16).height(16)
              .margin({ left: 8 })
              .onClick(() => {
                this.searchQuery = '';
                this.isResultMode = false;
              })
          }
        }
        .layoutWeight(1)
        .height(36)
        .backgroundColor(this.isResultMode ? Color.White : '#F5F5F5')
        .borderRadius(18)
        .padding({ left: 12, right: 12 })
        .border({ width: this.isResultMode ? 1 : 0, color: '#10C8A7' })

        if (!this.isResultMode) {
          Text('搜索')
            .fontSize(15)
            .fontColor('#10C8A7')
            .margin({ left: 12 })
            .onClick(() => {
              if (this.searchQuery.trim() !== '') {
                this.isResultMode = true;
              }
            })
        }
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 16, bottom: 12 })
      .backgroundColor(Color.White)

      // === 2. 动态内容区 ===
      if (!this.isResultMode) {
        // --- 历史搜索模式 ---
        Stack({ alignContent: Alignment.Bottom }) {
          Column() {
            Row() {
              Text('历史搜索')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor('#333333')
              Blank()
              Image($r('app.media.startIcon')).width(16).height(16)
            }
            .width('100%')
            .padding({ left: 16, right: 16, top: 16, bottom: 16 })

            Flex({ wrap: FlexWrap.Wrap }) {
              ForEach(this.searchHistory, (item: string) => {
                Text(item)
                  .fontSize(13)
                  .fontColor('#666666')
                  .backgroundColor('#F5F5F5')
                  .padding({ left: 14, right: 14, top: 6, bottom: 6 })
                  .borderRadius(16)
                  .margin({ right: 10, bottom: 12 })
                  .onClick(() => {
                    this.searchQuery = item;
                    this.isResultMode = true;
                  })
              })
            }
            .padding({ left: 16, right: 16 })
            .width('100%')
          }
          .width('100%')
          .height('100%')
          .backgroundColor(Color.White)

          // 语音搜索悬浮球
          Column() {
            Circle({ width: 60, height: 60 }).fill(Color.White).shadow({ radius: 10, color: 'rgba(0,0,0,0.05)', offsetY: -2 })
            Image($r('app.media.startIcon')).width(28).height(28).position({ x: 16, y: 16 })
          }
          .width(60).height(60).margin({ bottom: 40 })
        }
        .layoutWeight(1)

      } else {
        // --- 搜索结果模式 ---
        Scroll() {
          Column() {
            List() {
              ForEach(this.searchResults, (resTitle) => {
                ListItem() {
                  Row() {
                    // 关键词高亮演示 (这里用代码逻辑或直接组合文本展示)
                    Text(resTitle)
                      .fontSize(14)
                      .fontColor('#333333')

                    Blank()

                    Image($r('app.media.startIcon')).width(12).height(12)
                  }
                  .width('100%')
                  .padding(16)
                  .onClick(() => {
                    // router.pushUrl({ url: 'pages/profile/ProblemDetailPage' })
                  })
                }
              })
            }
            .width('92%')
            .backgroundColor(Color.White)
            .borderRadius(12)
            .margin({ top: 12 })
            .divider({ strokeWidth: 0.5, color: '#F0F0F0', startMargin: 16, endMargin: 16 })
            .shadow({ radius: 4, color: 'rgba(0,0,0,0.03)', offsetY: 2 })
          }
          .width('100%')
        }
        .layoutWeight(1)
        .backgroundColor('#F8F8F8')
        .scrollBar(BarState.Off)
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}