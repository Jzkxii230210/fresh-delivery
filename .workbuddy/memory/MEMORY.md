# FreshDelivery 项目长期笔记

## 项目概况
- 生鲜电商买菜到家APP"小毕买菜"（一公里生活圈·小时达）；纯 HarmonyOS 工程（DevEco Studio），API 22（6.0.2），ArkTS + ArkUI 声明式。
- 路由：@ohos.router 经典路由 + main_pages.json 静态注册（62条路由 / 65个页面组件）；无 Navigation。
- 分层：pages（按业务域子目录 login/main/home/store/cart/order/message/mine/help/setting/unlogin）、views/components（11个公共组件）、viewmodels、models、services、utils、constants。
- 状态/存储：@State 页面级；AppStorage 全局（utils/GlobalStateManager.ets 封装 isLoggedIn/userInfo）；StorageUtil/ApiService/MockService 均为 TODO 占位，无真实网络请求，数据页面内硬编码。
- 视觉规范：品牌绿 #10C8A7、灰底 #F8F8F8、白色圆角12卡片+浅阴影；弹窗=Stack条件渲染+rgba(0,0,0,0.4)遮罩；确认用 promptAction.showDialog，轻提示 showToast。
- 权限：module.json5 声明位置权限×2；SplashPage 高仿系统权限弹窗。

## 实训报告相关
- 第5组6人：赵强、毕敬明、厉健洋、王涛、孙兴宏、高朱杰。
- 赵强负责9页：登录注册(LoginPage)、消息中心(ProblemCenterPage/struct MessageCenterPage)、在线客服聊天(ChatPage)、意见反馈(FeedbackPage)、帮助中心(HelpCenterPage)、设置中心(SettingsPage)、账号安全(AccountSecurityPage)、隐私管理(PrivacyManagementPage)、关于我们(AboutUsPage)。
- 2026-07-26 已生成《赵强-移动应用开发实训报告.docx》于 E:\DevEcoStudioProjects\，模板同目录。
