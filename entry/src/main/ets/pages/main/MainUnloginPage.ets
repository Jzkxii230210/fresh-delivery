import router from '@ohos.router';
import { HomeUnloginPage } from '../unlogin/HomeUnloginPage';
import { CategoryUnloginListPage } from '../unlogin/CategoryUnloginListPage';
import { CartUnloginPage } from '../unlogin/CartUnloginPage';
import { OrderUnloginPage } from '../unlogin/OrderUnloginPage';
import { MineUnloginPage } from '../unlogin/MineUnloginPage';

/**
 * 未登录主页框架 - 承载底部Tab导航
 * 与 MainPage 结构一致，但使用未登录视图
 */
@Entry
@Component
struct MainUnloginPage {
  // 当前选中的Tab索引
  @State currentTabIndex: number = 0;

  build() {
    Tabs({ barPosition: BarPosition.End }) {
      // 首页Tab
      TabContent() {
        HomeUnloginPage()
      }
      .tabBar(this.TabBuilder(0, '首页'))

      // 分类Tab
      TabContent() {
        CategoryUnloginListPage()
      }
      .tabBar(this.TabBuilder(1, '分类'))

      // 购物车Tab
      TabContent() {
        CartUnloginPage()
      }
      .tabBar(this.TabBuilder(2, '购物车'))

      // 订单Tab
      TabContent() {
        OrderUnloginPage()
      }
      .tabBar(this.TabBuilder(3, '订单'))

      // 我的Tab
      TabContent() {
        MineUnloginPage()
      }
      .tabBar(this.TabBuilder(4, '我的'))
    }
    .barHeight(56)
    .barBackgroundColor(Color.White)
    .onChange((index: number) => {
      this.currentTabIndex = index;
    })
    .width('100%')
    .height('100%')
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP]) // 延伸到顶部状态栏区域
  }

  // Tab按钮构建器 - 胶囊式展开高亮设计
  @Builder
  TabBuilder(index: number, title: string) {
    Row() {
      Image(this.getTabIcon(index))
        .width(20)
        .height(20)
        .fillColor(index === this.currentTabIndex ? Color.White : '#999999')

      // 选中时显示文字
      if (index === this.currentTabIndex) {
        Text(title)
          .fontSize(12)
          .fontColor(Color.White)
          .margin({ left: 6 })
      }
    }
    .height(36)
    .padding({ left: 12, right: 12 })
    .borderRadius(18)
    .backgroundColor(index === this.currentTabIndex ? '#10C8A7' : Color.Transparent)
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .animation({
      duration: 300,
      curve: Curve.EaseInOut
    })
  }

  // 根据索引获取对应的图标
  getTabIcon(index: number): Resource {
    switch (index) {
      case 0: // 首页
        return $r('app.media.shouye');
      case 1: // 分类
        return $r('app.media.fenlei');
      case 2: // 购物车
        return $r('app.media.gouwuche');
      case 3: // 订单
        return $r('app.media.dingdan');
      case 4: // 我的
        return $r('app.media.wode');
      default:
        return $r('app.media.shouye');
    }
  }

  // 页面转场动画 - 入场时从左侧滑入（返回效果）
  pageTransition() {
    PageTransitionEnter({ duration: 200, curve: Curve.EaseOut })
      .slide(SlideEffect.Left)
  }
}
