/**
 * 全局状态管理工具类
 * 使用 AppStorage 管理应用全局状态
 */

/**
 * 初始化全局状态
 * 在应用启动时调用
 */
export function initGlobalState(): void {
  // 初始化登录状态（默认未登录）
  AppStorage.setOrCreate('isLoggedIn', false);
  
  // 初始化用户信息
  AppStorage.setOrCreate('userInfo', {
    userId: '',
    userName: '',
    phone: '',
    avatar: ''
  });
}

/**
 * 设置登录状态
 * @param isLoggedIn 是否已登录
 */
export function setLoginStatus(isLoggedIn: boolean): void {
  AppStorage.setOrCreate('isLoggedIn', isLoggedIn);
}

/**
 * 获取登录状态
 * @returns 是否已登录
 */
export function getLoginStatus(): boolean {
  return AppStorage.get<boolean>('isLoggedIn') || false;
}

/**
 * 设置用户信息
 * @param userInfo 用户信息对象
 */
export function setUserInfo(userInfo: UserInfo): void {
  AppStorage.setOrCreate('userInfo', userInfo);
}

/**
 * 获取用户信息
 * @returns 用户信息对象
 */
export function getUserInfo(): UserInfo {
  return AppStorage.get<UserInfo>('userInfo') || {
    userId: '',
    userName: '',
    phone: '',
    avatar: ''
  };
}

/**
 * 清除登录状态和用户信息
 * 退出登录时调用
 */
export function clearLoginInfo(): void {
  AppStorage.setOrCreate('isLoggedIn', false);
  AppStorage.setOrCreate('userInfo', {
    userId: '',
    userName: '',
    phone: '',
    avatar: ''
  });
}

/**
 * 用户信息接口
 */
export interface UserInfo {
  userId: string;
  userName: string;
  phone: string;
  avatar: string;
}
