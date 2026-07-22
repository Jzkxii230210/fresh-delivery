import router from '@ohos.router';
import abilityAccessCtrl, { Permissions } from '@ohos.abilityAccessCtrl';
import common from '@ohos.app.ability.common';

@Entry
@Component
struct SplashPage {
  @State hasJumped: boolean = false;

  aboutToAppear() {
    // 设置超时保护，3秒后无论权限申请是否完成都跳转
    setTimeout(() => {
      if (!this.hasJumped) {
        console.info('Splash timeout, jumping to login page');
        this.jumpToLogin();
      }
    }, 3000);

    // 延迟 0.5 秒后，尝试申请权限
    setTimeout(() => {
      this.reqPermissionsFromUser();
    }, 500);
  }

  // 唤起系统内置权限弹窗的核心逻辑
  reqPermissionsFromUser() {
    try {
      // 1. 获取当前 UIAbility 的上下文
      let context = getContext(this) as common.UIAbilityContext;
      // 2. 创建权限管理实例
      let atManager = abilityAccessCtrl.createAtManager();
      // 3. 定义需要申请的权限列表（模糊定位和精确定位）
      let permissions: Permissions[] = [
        'ohos.permission.APPROXIMATELY_LOCATION',
        'ohos.permission.LOCATION'
      ];

      // 4. 发起请求
      atManager.requestPermissionsFromUser(context, permissions).then((data) => {
        let grantStatus: Array<number> = data.authResults;
        console.info(`Permission request completed, status: ${grantStatus}`);
        this.jumpToLogin();
      }).catch((err: Error) => {
        console.error(`Request permission failed: ${err.message}`);
        this.jumpToLogin();
      });
    } catch (error) {
      console.error(`Permission request error: ${error}`);
      this.jumpToLogin();
    }
  }

  jumpToLogin() {
    if (this.hasJumped) {
      return; // 防止重复跳转
    }
    this.hasJumped = true;
    // 跳转到登录页
    router.replaceUrl({
      url: 'pages/login/LoginPage'
    });
  }

  build() {
    Stack({ alignContent: Alignment.Center }) {
      // 1. 背景色
      Row()
        .width('100%')
        .height('100%')
        .backgroundColor('#50A161')

      // 2. 页面中心 Slogan
      Column() {
        Text('你的')
          .fontSize(24)
          .fontColor(Color.White)
          .margin({ bottom: 12 })
        Text('一公里生活圈')
          .fontSize(28)
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.White)
          .letterSpacing(2)
      }
      .margin({ top: -50 })

      // 3. 底部品牌 Logo 区
      Column() {
        Row() {
          Text('M')
            .fontSize(16)
            .fontWeight(FontWeight.Bolder)
            .fontColor(Color.White)
            .backgroundColor('#10C8A7')
            .padding({ left: 6, right: 6, top: 4, bottom: 4 })
            .borderRadius(4)
            .margin({ right: 8 })

          Text('小默买菜')
            .fontSize(20)
            .fontWeight(FontWeight.Medium)
            .fontColor(Color.White)
        }
      }
      .position({ x: 0, y: '85%' })
      .width('100%')
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
  }
}
