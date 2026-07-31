# 🥦 FreshDelivery (生鲜配送 App)

FreshDelivery 是一款基于 **HarmonyOS (鸿蒙)** 和 **ArkUI** 框架开发的生鲜电商购物应用程序。项目采用 Stage 模型和 ArkTS 语言编写，遵循 MVVM 架构模式，提供了从商品浏览、购物车管理、订单支付到售后追踪的完整电商业务闭环体验。

## ✨ 功能特性

本项目涵盖了标准生鲜电商 App 的核心业务模块：

* **🔐 用户认证模块**
* 支持手机号验证码登录/绑定 (`SmsLoginPage`, `BindPhonePage`)
* 支持第三方授权登录（微信、QQ）(`WechatAuthPage`, `QQAuthPage`)
* 未登录状态下的降级浏览体验 (`unlogin` 系列页面)


* **🛍️ 首页与商品模块**
* 商品分类与浏览 (`HomeViewPage`, `CategoryListPage`)
* 店铺详情与附近商家 (`StoreHomePage`, `NearbyShopPage`)
* 商品详情与评价浏览 (`ProductDetailPage`, `StoreReviewPage`)
* 全局商品与店铺搜索 (`SearchPage`)


* **🛒 购物车模块**
* 购物车商品增删改查 (`CartPage`, `CartPopupDialog`)
* 订单结算与确认 (`ConfirmOrderPage`)


* **📦 订单与售后模块**
* 订单列表与详情 (`OrderListPage`, `OrderDetailPage`)
* 支付成功与交易结果页 (`PaymentSuccessPage`, `TransactionSuccessPage`)
* 物流追踪 (`OrderTrackPage`)
* 退款申请与售后列表 (`RefundApplyPage`, `AfterSaleListPage`)


* **👤 个人中心模块**
* 用户资料与钱包 (`ProfilePage`, `WalletPage`)
* 收货地址管理 (`AddressListPage`, `AddAddressPage`)
* 浏览足迹与收藏关注 (`BrowsingHistoryPage`, `MyFollowingPage`)
* 发票与账单管理 (`InvoiceHelperPage`, `BillPage`)


* **💬 消息与客服模块**
* 即时聊天界面 (`ChatPage`)
* 帮助与问题中心 (`HelpCenterPage`, `ProblemCenterPage`)



## 🛠️ 技术栈

* **操作系统**: HarmonyOS / OpenHarmony
* **开发语言**: ArkTS (TypeScript 的超集)
* **UI 框架**: ArkUI (声明式 UI 编程范式)
* **架构模式**: MVVM (Model-View-ViewModel)
* **构建工具**: Hvigor

## 📂 项目结构

项目核心代码位于 `entry/src/main/ets/` 目录下，结构划分如下：

```text
FreshDelivery/
├── AppScope/                 # 全局配置和资源
├── entry/src/main/ets/       # 核心源代码目录
│   ├── common/               # 公共常量、通用配置
│   ├── constants/            # 静态常量定义 (颜色、样式等)
│   ├── entryability/         # 应用入口 Ability
│   ├── models/               # 数据模型层 (OrderData, ProductData, UserData)
│   ├── pages/                # UI 视图层 (各个业务模块的页面)
│   │   ├── cart/             # 购物车相关
│   │   ├── home/             # 首页相关
│   │   ├── login/            # 登录授权相关
│   │   ├── main/             # 主框架承载页
│   │   ├── message/          # 消息与客服
│   │   ├── mine/             # 个人中心
│   │   ├── order/            # 订单管理
│   │   ├── store/            # 商家与商品
│   │   └── unlogin/          # 未登录状态占位页
│   ├── services/             # 服务层 (ApiService, MockService 网络与数据请求)
│   ├── utils/                # 工具类 (StorageUtil, WindowUtil, LogUtil)
│   ├── viewmodels/           # 视图模型层 (处理业务逻辑与状态管理)
│   └── views/components/     # 自定义复用组件 (对话框、导航栏、空状态等)
├── entry/src/main/resources/ # 模块级静态资源 (图片、字符串、颜色值)
├── build-profile.json5       # 构建配置
└── oh-package.json5          # 依赖包管理

```

## 🚀 快速开始

### 环境要求

* **IDE**: DevEco Studio (建议最新版本)
* **SDK**: HarmonyOS API Version 9 或以上 (根据实际 `build-profile.json5` 配置为准)

### 运行步骤

1. 克隆本项目到本地：
```bash
git clone https://github.com/您的用户名/FreshDelivery.git

```


2. 使用 **DevEco Studio** 打开项目。
3. 等待 IDE 自动执行 `npm install` 或 `ohpm install` 以下载相关依赖。
4. 连接 HarmonyOS 真机或启动本地/远程模拟器 (Emulator)。
5. 点击工具栏的 **Run (运行)** 按钮，或使用快捷键 `Shift + F10` 编译并运行项目。

## 📱 界面预览

*(提示：建议在这里添加 3-4 张 App 的核心界面截图，例如：首页、购物车、商品详情、个人中心，以直观展示项目成果)*

| 首页 | 商品详情 | 购物车 | 个人中心 |
| --- | --- | --- | --- |
|  |  |  |  |

## 🤝 贡献指南

欢迎提交 Issue 和 Pull Request 来帮助完善此项目！

1. Fork 本仓库
2. 创建您的特性分支 (`git checkout -b feature/AmazingFeature`)
3. 提交您的更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 开启一个 Pull Request

## 📄 开源协议

本项目采用 [MIT License](https://www.google.com/search?q=LICENSE) 开源协议。
