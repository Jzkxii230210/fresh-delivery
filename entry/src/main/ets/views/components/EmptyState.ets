/**
 * 通用空状态提示 (缺省图)
 */
@Component
export struct EmptyState {
  build() {
    Column() {
      // TODO: 实现空状态提示UI
      Text('暂无数据')
    }
    .width('100%')
    .height('100%')
  }
}
