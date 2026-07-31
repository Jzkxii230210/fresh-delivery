import promptAction from '@ohos.promptAction';

// 分享项类
class ShareItem {
  name: string = '';
  color: string = '';
  icon: Resource = $r('app.media.back');
  hasBorder: boolean = false;

  constructor(name: string, color: string, icon: Resource, hasBorder: boolean) {
    this.name = name;
    this.color = color;
    this.icon = icon;
    this.hasBorder = hasBorder;
  }
}

// 1. 定义弹窗组件
@CustomDialog
export struct ShareDialog {
  controller: CustomDialogController

  // 模拟分享选项数据 (颜色已按原型图提取)
  private shareItems: ShareItem[] = [
    new ShareItem('微信', '#07C160', $r('app.media.weixinzhifu'), false),
    new ShareItem('朋友圈', '#62D04A', $r('app.media.pyq'), false),
    new ShareItem('QQ', '#27A5F9', $r('app.media.qqdl'), false),
    new ShareItem('QQ空间', '#FFB84F', $r('app.media.qqkj'), false),
    new ShareItem('微博', '#E92D2D', $r('app.media.weibo'), false),
    // 后两个是白底灰边
    new ShareItem('复制链接', '#FFFFFF', $r('app.media.lianjie'), true),
    new ShareItem('系统分享', '#FFFFFF', $r('app.media.xtfx'), true)
  ]

  build() {
    Column() {
      // --- 1. 顶部标题 ---
      Text('分享到')
        .fontSize(15)
        .fontColor('#333333')
        .margin({ top: 18, bottom: 20 })

      // --- 2. 分享图标矩阵 ---
      Grid() {
        ForEach(this.shareItems, (item: ShareItem) => {
          GridItem() {
            Column() {
              // 图标圆形背景
              Stack({ alignContent: Alignment.Center }) {
                Circle({ width: 52, height: 52 })
                  .fill(item.color)
                  // 针对“复制链接”等图标增加灰色描边
                  .border(item.hasBorder ? { width: 1, color: '#EAEAEA' } : { width: 0 })

                // 内部图标 (实际开发请替换为真实的透明PNG或SVG)
                Image(item.icon)
                  .width(28)
                  .height(28)
                  // 如果是白底，图标用深色；如果是彩底，图标用纯白
                  .fillColor(item.hasBorder ? '#333333' : Color.White)
              }
              .margin({ bottom: 8 })

              // 底部文字
              Text(item.name)
                .fontSize(11)
                .fontColor('#666666')
            }
          }
          .onClick(() => {
            promptAction.showToast({ message: `点击了: ${item.name}` });
            this.controller.close();
          })
        })
      }
      .columnsTemplate('1fr 1fr 1fr 1fr') // 严格的 4 列布局
      .rowsGap(24) // 上下行间距
      .padding({ left: 16, right: 16, bottom: 24 })
      .height(180) // 给定一个合适的高度包裹两行内容

      Divider()
        .color('#F0F0F0')
        .strokeWidth(0.5)

      // --- 3. 底部取消按钮 ---
      Text('取消')
        .fontSize(16)
        .fontColor('#007DFF') // 经典的交互蓝色
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .height(56)
        .textAlign(TextAlign.Center)
        .onClick(() => {
          this.controller.close() // 关闭弹窗
        })
    }
    .width('100%')
    .backgroundColor('#F8F8F8') // 面板底色为极浅的灰色
    .borderRadius({ topLeft: 16, topRight: 16 }) // 仅左上和右上需要圆角
    .padding({ bottom: 12 }) // 预留底部安全区
  }
}