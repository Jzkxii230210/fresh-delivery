import router from '@ohos.router';

// 定义商家数据模型
class MerchantInfo {
  logo: Resource;
  name: string;
  isFrequent: boolean;

  constructor(logo: Resource, name: string, isFrequent: boolean = false) {
    this.logo = logo;
    this.name = name;
    this.isFrequent = isFrequent;
  }
}

@Entry
@Component
export struct NearbyShopPage {
  // 当前选中的 Tab 索引
  @State currentTabIndex: number = 0;

  // 模拟分类数据
  private tabs: string[] = ['全部', '超市', '便利店', '药店', '水果店', '其他'];

  // 完全根据原型图构建的真实商家列表顺序与状态
  private mockMerchants: MerchantInfo[] = [
    new MerchantInfo($r('app.media.tianhong'), '天虹商场-凤凰城店', true), // 只有第一个有经常光顾
    new MerchantInfo($r('app.media.yonghui'), '永辉超市-凤凰城店'),
    new MerchantInfo($r('app.media.darunfa'), '大润发(凤凰城店)'),
    new MerchantInfo($r('app.media.dashenlin'), '大参林药店(凤凰城店)'),
    new MerchantInfo($r('app.media.tianfu'), '天福便利店(凤凰二街店)'),
    // --- 下面是“一公里外”商家 ---
    new MerchantInfo($r('app.media.changdachang'), '昌大昌-龙岭店'),
    new MerchantInfo($r('app.media.baoshenlu'), '宝神鹿药店(龙岭店)'),
    new MerchantInfo($r('app.media.yonghui'), '永辉超市(龙岭店)'),
    new MerchantInfo($r('app.media.tianfu'), '天福便利店(龙岭二区店)'),
    new MerchantInfo($r('app.media.darunfa'), '大润发-龙岭店')
  ];

  build() {
    Column() {
      // === 1. 顶部标题栏 ===
      Row() {
        Image($r('app.media.back')) // 返回箭头
          .width(20)
          .height(20)
          .onClick(() => {
            router.back();
          })

        Text('一公里内商家')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#333333')
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        // 右侧定位信息
        Column() {
          Image($r('app.media.dingwei')).width(16).height(16).margin({ bottom: 2 })
          Text('凤凰城').fontSize(10).fontColor('#666666')
        }
        .width(40)
        .alignItems(HorizontalAlign.Center)
      }
      .width('100%')
      .height(50)
      .padding({ left: 16, right: 16 })
      .backgroundColor(Color.White)

      // === 2. 顶部 Tab 分类 (横向滚动) ===
      List() {
        ForEach(this.tabs, (item: string, index: number) => {
          ListItem() {
            Column() {
              Text(item)
                .fontSize(14)
                .fontWeight(this.currentTabIndex === index ? FontWeight.Bold : FontWeight.Normal)
                .fontColor(this.currentTabIndex === index ? '#10C8A7' : '#666666')
                .margin({ bottom: 6 })

              // 底部绿色指示条
              Divider()
                .color(this.currentTabIndex === index ? '#10C8A7' : Color.Transparent)
                .strokeWidth(2)
                .width(24)
                .lineCap(LineCapStyle.Round)
            }
            .padding({ left: 16, right: 16, top: 10, bottom: 4 })
            .onClick(() => {
              this.currentTabIndex = index;
            })
          }
        })
      }
      .listDirection(Axis.Horizontal)
      .scrollBar(BarState.Off)
      .width('100%')
      .height(44)
      .backgroundColor(Color.White)

      // === 3. 商家列表区 ===
      List() {
        ForEach(this.mockMerchants, (merchant: MerchantInfo, index: number) => {

          // 根据原型图，在第 5 个商家（即 index 为 5，昌大昌之前）插入“一公里外商家”的分割线
          if (index === 5) {
            ListItem() {
              this.DistanceDivider()
            }
          }

          ListItem() {
            this.MerchantDetailCard(merchant)
          }
        })

        // 底部安全距离留白
        ListItem() {
          Row().height(40).width('100%')
        }
      }
      .layoutWeight(1) // 占满剩余空间
      .width('100%')
      .backgroundColor('#F8F8F8') // 灰色背景衬托白色卡片
      .padding({ left: 12, right: 12, top: 12 })
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8F8F8')
  }

  // --- 局部复用组件 ---

  // 分割线：一公里外商家
  @Builder DistanceDivider() {
    Row() {
      Image($r('app.media.startIcon')) // 替换为左侧心形Icon
        .width(14).height(14).margin({ right: 6 })

      Text('一公里外商家')
        .fontSize(13)
        .fontColor('#FF4D4F')

      Image($r('app.media.startIcon')) // 替换为右侧心形Icon
        .width(14).height(14).margin({ left: 6 })
    }
    .width('100%')
    .justifyContent(FlexAlign.Center)
    .padding({ top: 10, bottom: 16 })
  }

  // 核心商家卡片
  @Builder MerchantDetailCard(merchant: MerchantInfo) {
    Row() {
      // 左侧商家大 Logo 区域
      Stack({ alignContent: Alignment.Bottom }) {
        Image(merchant.logo)
          .width(80)
          .height(80)
          .borderRadius(8)
          .margin({ bottom: merchant.isFrequent ? 8 : 0 }) // 给标签留出空间

        // "经常光顾" 标签，仅由 isFrequent 状态控制
        if (merchant.isFrequent) {
          Text('经常光顾')
            .fontSize(10)
            .fontColor(Color.White)
            .backgroundColor('#B39169') // 贴近原型的褐色
            .padding({ left: 4, right: 4, top: 2, bottom: 2 })
            .borderRadius({ topLeft: 4, bottomRight: 4 })
            .width(80)
            .textAlign(TextAlign.Center)
        }
      }
      .margin({ right: 12 })

      // 右侧详细信息
      Column() {
        // 1. 商家名称 (动态绑定数据)
        Text(merchant.name)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .margin({ bottom: 8 })

        // 2. 评分、销量与距离 (静态统一数据)
        Row() {
          Text('4.5分').fontSize(12).fontColor('#FF4D4F').margin({ right: 8 })
          Text('月售700+').fontSize(12).fontColor('#999999').margin({ right: 8 })
          Text('30分钟').fontSize(12).fontColor('#999999').margin({ right: 8 })
          Text('|').fontSize(10).fontColor('#E0E0E0').margin({ right: 8 })
          Text('1.6km').fontSize(12).fontColor('#999999')
        }
        .width('100%')
        .margin({ bottom: 8 })

        // 3. 配送费信息
        Row() {
          Text('起送 ￥20').fontSize(12).fontColor('#666666').margin({ right: 8 })
          Text('满 ￥30免基础运费').fontSize(12).fontColor('#FF4D4F')
        }
        .width('100%')
        .margin({ bottom: 8 })

        // 4. 店铺优惠券 (横向排列)
        Row({ space: 6 }) {
          this.CouponTag('领2元店铺券')
          this.CouponTag('领4元店铺券')
          this.CouponTag('领7元店铺券')
        }
        .width('100%')
        .margin({ bottom: 8 })

        // 5. 满减活动展示
        Row() {
          Text('满减')
            .fontSize(10)
            .fontColor('#FF8C00')
            .border({ width: 1, color: '#FF8C00' })
            .borderRadius(2)
            .padding({ left: 2, right: 2 })
            .margin({ right: 6 })

          Text('维达纸巾满49减5，满79减10，满99减15')
            .fontSize(11)
            .fontColor('#FF8C00')
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .layoutWeight(1)
        }
        .width('100%')
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .backgroundColor(Color.White)
    .borderRadius(12)
    .padding(12)
    .margin({ bottom: 12 })
  }

  // 优惠券标签 Builder
  @Builder CouponTag(text: string) {
    Text(text)
      .fontSize(10)
      .fontColor('#FF4D4F')
      .border({ width: 1, color: '#FF4D4F' })
      .borderRadius(2)
      .padding({ left: 4, right: 4, top: 2, bottom: 2 })
  }
}