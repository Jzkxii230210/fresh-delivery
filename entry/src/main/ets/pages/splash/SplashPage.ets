import router from '@ohos.router';

@Entry
@Component
struct SplashPage {
  // 控制是否显示模拟权限弹窗
  @State showMockDialog: boolean = false;
  @State hasJumped: boolean = false;

  aboutToAppear() {
    // 延迟 300ms 后显示位置权限请求弹窗，给用户一个短暂的视觉过渡
    setTimeout(() => {
      this.showMockDialog = true;
    }, 500);
  }

  // 模拟点击授权后的跳转逻辑
  jumpToLogin() {
    if (!this.hasJumped) {
      this.hasJumped = true;
      this.showMockDialog = false;
      router.replaceUrl({ url: 'pages/main/MainUnloginPage' })
        .then(() => {
          console.info('跳转到未登录主页成功');
        })
        .catch((err: Error) => {
          console.error('跳转失败:', err);
        });
    }
  }

  build() {
    // 最外层使用 Stack，方便在整个页面上方覆盖蒙层和弹窗
    Stack({ alignContent: Alignment.Center }) {

      // ==========================================
      // 1. 底层：全屏绿色背景与 Logo
      // ==========================================
      Stack({ alignContent: Alignment.Bottom }) {
        // 全屏背景层
        Column()
          .width('100%')
          .height('100%')
          .backgroundColor('#5CA865') // 品牌绿底色
        // 如果有蔬菜底纹图片，可以取消下面注释
        // .backgroundImage($r('app.media.background'))
        // .backgroundImageSize(ImageSize.Cover)

        // 底部 Logo 层
        Row({ space: 12 }) {
          Image($r('app.media.logo')) // 替换为您真实的白色/青色 Logo 资源
            .width(36)
            .height(36)
            .borderRadius(8)

          Text('小毕买菜')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.White)
            .letterSpacing(1)
        }
        .margin({ bottom: 80 })
      }
      .width('100%')
      .height('100%')

      // ==========================================
      // 2. 顶层：模拟系统位置权限弹窗
      // ==========================================
      if (this.showMockDialog) {
        // 半透明黑色蒙层
        Column()
          .width('100%')
          .height('100%')
          .backgroundColor('rgba(0,0,0,0.4)')
          .onClick(() => {
            // 拦截点击事件，防止点到弹窗外部
          })

        // 高仿 iOS/HarmonyOS 权限弹窗本体
        Column() {
          Text('允许“小毕买菜”使用\n你的位置？')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#333333')
            .textAlign(TextAlign.Center)
            .lineHeight(26)
            .margin({ top: 24, bottom: 12 })

          Text('用于向你推荐附近的商超、便利店，不授权该权限可能会影响app的使用体验。')
            .fontSize(13)
            .fontColor('#666666')
            .textAlign(TextAlign.Center)
            .lineHeight(18)
            .padding({ left: 20, right: 20 })
            .margin({ bottom: 16 })

          // 模拟地图展示区域 (用灰色占位区块代替)
          Column() {
            Image($r('app.media.map'))
              .width('100%')
              .height('100%')
              .objectFit(ImageFit.Cover)
          }
          .width('100%')
          .height(130)
          .backgroundColor('#F2F2F7')

          // 选项 1
          Divider().color('#E5E5E5').strokeWidth(1)
          Text('允许一次')
            .fontSize(16)
            .fontColor('#007DFF') // 系统弹窗标准的蓝色链接
            .width('100%')
            .height(50)
            .textAlign(TextAlign.Center)
            .onClick(() => this.jumpToLogin()) // 点击模拟跳转

          // 选项 2
          Divider().color('#E5E5E5').strokeWidth(1)
          Text('使用App时允许')
            .fontSize(16)
            .fontColor('#007DFF')
            .width('100%')
            .height(50)
            .textAlign(TextAlign.Center)
            .onClick(() => this.jumpToLogin())

          // 选项 3
          Divider().color('#E5E5E5').strokeWidth(1)
          Text('不允许')
            .fontSize(16)
            .fontColor('#007DFF')
            .width('100%')
            .height(50)
            .textAlign(TextAlign.Center)
            .onClick(() => this.jumpToLogin())
        }
        .width('80%')
        .backgroundColor(Color.White)
        .borderRadius(14)
        .clip(true)
      }
    }
    .width('100%')
    .height('100%')
    // 【关键修复】：确保最外层 Stack 开启沉浸式安全区忽略，铺满整个屏幕
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}