import router from '@ohos.router';
import { StoreHomePage } from '../home/StoreHomePage';
import { CategoryListPage } from '../home/CategoryListPage';
import { CartPage } from '../cart/CartPage';
import { OrderListPage } from '../order/OrderListPage';
import { ProfilePage } from '../mine/ProfilePage';

/**
 * 主页框架 - 承载底部Tab导航
 */
@Entry
@Component
struct MainPage {
  // 当前选中的Tab索引
  @State currentTabIndex: number = 0;

  build() {
    Tabs({ barPosition: BarPosition.End }) {
      // 首页Tab
      TabContent() {
        StoreHomePage()
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

  // Tab按钮构建器
  @Builder
  TabBuilder(index: number, title: string) {
    Column() {
      // 图标
      if (index === this.currentTabIndex) {
        // 选中状态图标
        if (index === 2) {
          Badge({ count: 2, position: BadgePosition.RightTop, style: { badgeSize: 16, badgeColor: '#FF4D4F' } }) {
            Image($r('app.media.startIcon'))
              .width(24)
              .height(24)
          }
        } else {
          Image($r('app.media.startIcon'))
            .width(24)
            .height(24)
        }
      } else {
        // 未选中状态图标
        Image($r('app.media.startIcon'))
          .width(24)
          .height(24)
      }

      // 文字
      Text(title)
        .fontSize(10)
        .fontColor(index === this.currentTabIndex ? '#10C8A7' : '#999999')
        .margin({ top: 4 })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }
}
