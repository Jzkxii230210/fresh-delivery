import router from '@ohos.router';
import { HomeViewPage } from '../home/HomeViewPage';
import { CategoryListPage } from '../home/CategoryListPage';
import { CartPage } from '../cart/CartPage';
import { OrderListPage } from '../order/OrderListPage';
import { ProfilePage } from '../home/ProfilePage';

/**
 * 主页框架 - 承载底部Tab导航
 */
@Entry
@Component
struct MainPage {
  // 当前选中的Tab索引
  @State currentTabIndex: number = 0;

  aboutToAppear() {
    // 从路由参数中读取 tabIndex
    const params = router.getParams() as Record<string, Object>;
    if (params && params['tabIndex'] !== undefined) {
      this.currentTabIndex = Number(params['tabIndex']);
    }
  }

  build() {
    Tabs({ barPosition: BarPosition.End }) {
      // 首页Tab
      TabContent() {
        HomeViewPage()
      }
      .tabBar(this.TabBuilder(0, '首页'))

      // 分类Tab
      TabContent() {
        CategoryListPage()
      }
      .tabBar(this.TabBuilder(1, '分类'))

      // 购物车Tab
      TabContent() {
        CartPage()
      }
      .tabBar(this.TabBuilder(2, '购物车'))

      // 订单Tab
      TabContent() {
        OrderListPage()
      }
      .tabBar(this.TabBuilder(3, '订单'))

      // 我的Tab
      TabContent() {
        ProfilePage()
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
}
