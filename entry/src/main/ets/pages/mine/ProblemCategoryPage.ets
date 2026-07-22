import router from '@ohos.router';

@Entry
@Component
struct ProblemCategoryPage {
  // 页面模式: 'category' (分类列表) 或 'list' (某个分类下的子问题列表)
  @State isListMode: boolean = false;
  @State currentCategoryTitle: string = '账号相关';

  // 模拟分类数据
  private categories: string[] = [
    '账号相关', '订单问题', '支付方式', '红包相关', '积分相关',
    '新用户相关', '疫情相关', '售后相关', '配送相关', '隐私相关',
    '功能故障', '平台规则', '其他问题'
  ];

  // 模拟某个分类下的具体问题列表
  private subProblems: string[] = [
    '如何更换手机号？',
    '收不到短信验证码',
    '绑定手机号已停机如何换绑？',
    '使用QQ/微信登录遇到问题',
    '无法使用Apple ID登录',
    '无法修改昵称/头像',
    '账号如何注销？',
    '注销账号需要多久？',
    '账号注销后手机号可再次注册吗？',
    '账号密码怎么修改？',
    '其他账号问题'
  ];

  build() {
    Column() {
      // === 1. 顶部标题栏 (带搜索图标) ===
      Row() {
        Image($r('app.media.startIcon'))
          .width(20).height(20).margin({ right: 12 })
          .onClick(() => {
            if (this.isListMode) {
              this.isListMode = false; // 返回分类页
            } else {
              router.back();
            }
          })

        Text(this.isListMode ? this.currentCategoryTitle : '问题分类')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        // 右上角搜索放大镜图标
        Image($r('app.media.startIcon'))
          .width(20)
          .height(20)
          .onClick(() => {
            // router.pushUrl({ url: 'pages/profile/ProblemSearchPage' })
          })
      }
      .width('100%')
      .height(50)
      .padding({ left: 16, right: 16 })
      .backgroundColor(Color.White)

      // === 2. 动态内容区 ===
      Scroll() {
        Column() {
          if (!this.isListMode) {
            // --- 视图 A：分类列表 ---
            List() {
              ForEach(this.categories, (catName) => {
                ListItem() {
                  Row() {
                    Text(catName).fontSize(15).fontColor('#333333')
                    Blank()
                    Image($r('app.media.startIcon')).width(12).height(12)
                  }
                  .width('100%')
                  .padding(16)
                  .onClick(() => {
                    this.currentCategoryTitle = catName;
                    this.isListMode = true; // 切换到子问题列表
                  })
                }
              })
            }
            .width('92%')
            .backgroundColor(Color.White)
            .borderRadius(12)
            .margin({ top: 12, bottom: 20 })
            .divider({ strokeWidth: 0.5, color: '#F0F0F0', startMargin: 16, endMargin: 16 })
            .shadow({ radius: 4, color: 'rgba(0,0,0,0.03)', offsetY: 2 })

          } else {
            // --- 视图 B：子问题列表 ---
            List() {
              ForEach(this.subProblems, (probName) => {
                ListItem() {
                  Row() {
                    Text(probName).fontSize(14).fontColor('#333333')
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
            .margin({ top: 12, bottom: 20 })
            .divider({ strokeWidth: 0.5, color: '#F0F0F0', startMargin: 16, endMargin: 16 })
            .shadow({ radius: 4, color: 'rgba(0,0,0,0.03)', offsetY: 2 })
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
}