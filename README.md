# 🥦 FreshDelivery 生鲜配送 App

FreshDelivery 是一款基于 **HarmonyOS（鸿蒙）** 原生体系开发的生鲜电商购物应用。项目采用 Stage 开发模型、ArkTS 语言与 ArkUI 声明式框架，遵循 MVVM 架构模式，完整覆盖商品浏览、购物车管理、订单支付、物流追踪、售后客服等电商全业务链路；内置 Mock 数据可直接运行演示，适合作为鸿蒙移动端开发的学习与参考项目。

## ✨ 功能特性

项目完整实现了生鲜电商 App 的核心业务模块：

### 🔐 用户认证模块
- 手机号验证码登录与号码绑定
- 微信、QQ 第三方授权登录
- 未登录状态下的降级浏览体验

### 🛍️ 首页与商品模块
- 首页商品瀑布流展示与分类导航
- 店铺详情页与附近商家列表
- 商品详情、规格选择与评价浏览
- 全局商品与店铺关键词搜索

### 🛒 购物车与结算模块
- 购物车商品增删、数量调整与批量管理
- 购物车商品一键结算
- 订单确认与收货地址选择

### 📦 订单与售后模块
- 全状态订单列表与订单详情
- 支付结果与交易成功页
- 物流信息实时追踪
- 退款申请与售后工单管理

### 👤 个人中心模块
- 个人资料编辑与钱包管理
- 收货地址增删改查
- 浏览足迹、商品收藏与店铺关注
- 电子发票与消费账单管理

### 💬 消息与客服模块
- 客服即时聊天界面
- 帮助中心与常见问题解答

## 🛠️ 技术栈

| 分类 | 技术方案 |
|------|----------|
| 运行系统 | HarmonyOS / OpenHarmony |
| 开发语言 | ArkTS（TypeScript 超集） |
| UI 框架 | ArkUI 声明式开发范式 |
| 架构模式 | MVVM（Model-View-ViewModel） |
| 开发模型 | Stage 模型 |
| 构建工具 | Hvigor |

## 📂 项目结构

项目核心业务代码位于 `entry/src/main/ets/` 目录下，按职责分层划分：

```text
FreshDelivery/
├── AppScope/                     # 应用全局配置与公共资源
├── entry/                        # 主应用模块
│   ├── src/main/ets/             # ArkTS 核心源码
│   │   ├── common/               # 公共常量、全局配置
│   │   ├── constants/            # 静态常量定义（颜色、样式、路由等）
│   │   ├── entryability/         # 应用入口 Ability 与生命周期管理
│   │   ├── models/               # 数据模型层（商品、订单、用户等数据结构）
│   │   ├── pages/                # UI 视图层，按业务模块划分
│   │   │   ├── cart/             # 购物车模块
│   │   │   ├── home/             # 首页与分类模块
│   │   │   ├── login/            # 登录与授权模块
│   │   │   ├── main/             # 主框架 Tab 承载页
│   │   │   ├── message/          # 消息与客服模块
│   │   │   ├── mine/             # 个人中心模块
│   │   │   ├── order/            # 订单与售后模块
│   │   │   ├── store/            # 商家与商品详情模块
│   │   │   └── unlogin/          # 未登录状态占位页面
│   │   ├── services/             # 服务层（接口请求、Mock 数据服务）
│   │   ├── utils/                # 工具类（存储、窗口、日志等工具）
│   │   ├── viewmodels/           # 视图模型层（业务逻辑与状态管理）
│   │   └── views/components/     # 公共自定义组件（弹窗、导航栏、空状态等）
│   ├── src/main/resources/       # 模块级静态资源（图片、多语言字符串、颜色值）
│   └── src/test/                 # 单元测试代码
├── build-profile.json5           # 项目构建配置
└── oh-package.json5              # 项目依赖与包管理配置
```

## 🚀 快速开始

### 环境要求
- IDE：DevEco Studio 3.1 及以上版本
- SDK：HarmonyOS API Version 9 及以上
- 运行环境：HarmonyOS 真机 或 系统模拟器

### 运行步骤
1. 克隆项目到本地：
```bash
git clone https://github.com/您的用户名/FreshDelivery.git
```

2. 使用 DevEco Studio 打开项目根目录。
3. 等待 IDE 自动同步依赖，或手动执行 `ohpm install` 安装依赖包。
4. 连接鸿蒙真机（需配置应用签名）或启动本地模拟器。
5. 点击工具栏 **Run** 按钮（快捷键 `Shift + F10`），编译并部署应用。

> 项目内置完整 Mock 数据，无需对接后端服务即可完整浏览全部页面与交互流程，便于开发学习与功能演示。

## 🤝 贡献指南

欢迎通过 Issue 反馈问题，或提交 Pull Request 参与项目优化：

1. Fork 本仓库
2. 创建特性分支 (`git checkout -b feature/AmazingFeature`)
3. 提交代码变更 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到远程分支 (`git push origin feature/AmazingFeature`)
5. 发起 Pull Request

## 📄 开源协议

本项目采用 **MIT License** 开源协议。
