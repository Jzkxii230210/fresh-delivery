// 首页公共数据模块 - 供登录和未登录状态共同使用

// 分类项接口
export interface CategoryItem {
  title: string;
  icon: Resource;
}

// 附近商家接口
export interface NearbyShop {
  name: string;
  type: string;
  distance: string;
  tags: string[];
  icon: Resource;
  rating: string;
}

// 推荐商品接口
export interface RecommendProduct {
  name: string;
  desc: string;
  price: string;
  oldPrice: string;
  storeName: string;
  storeIcon: Resource; // 商家logo
  image: Resource;
}

// 购物车商品接口
export interface CartProduct {
  name: string;
  price: string;
  oldPrice?: string;
  tag?: string; // '直降'等标签
  image: Resource;
  quantity: number; // 购买数量
  selected: boolean; // 是否选中
  productIndex?: number; // 对应推荐商品的索引，用于跳转到详情页
}

// 金刚区分类数据（10个导航栏）
export const CATEGORY_LIST: CategoryItem[] = [
  { title: '蔬菜豆品', icon: $r('app.media.Vegetables') },
  { title: '肉禽蛋', icon: $r('app.media.Meat') },
  { title: '海鲜水产', icon: $r('app.media.Seafood') },
  { title: '水果鲜花', icon: $r('app.media.Fruit') },
  { title: '乳品烘焙', icon: $r('app.media.Dairy') },
  { title: '冷冻食品', icon: $r('app.media.FrozenFood') },
  { title: '粮油调味', icon: $r('app.media.Grain') },
  { title: '酒水饮料', icon: $r('app.media.Liquor') },
  { title: '休闲零食', icon: $r('app.media.Snacks') },
  { title: '生活用品', icon: $r('app.media.DailyNecessities') }
];

// 附近商家数据
export const NEARBY_SHOPS: NearbyShop[] = [
  {
    name: '天虹商场-凤凰城店',
    type: '超市',
    distance: '100m内',
    tags: ['品质优选', '配送快'],
    icon: $r('app.media.tianhong'),
    rating: '4.3'
  },
  {
    name: '永辉超市-凤凰城店',
    type: '超市',
    distance: '200m内',
    tags: ['新鲜直达', '品类全'],
    icon: $r('app.media.yonghui'),
    rating: '4.5'
  },
  {
    name: '大润发(凤凰城店)',
    type: '超市',
    distance: '500m内',
    tags: ['大卖场', '优惠多'],
    icon: $r('app.media.darunfa'),
    rating: '4.2'
  },
  {
    name: '大森林(凤凰城店)',
    type: '健康',
    distance: '300m内',
    tags: ['健康优选', '品质保障'],
    icon: $r('app.media.dashenlin'),
    rating: '4.6'
  }
];

// 推荐商品数据
export const RECOMMEND_PRODUCTS: RecommendProduct[] = [
  {
    name: '花菜 约500g',
    desc: '产地直供，营养丰富',
    price: '7.99',
    oldPrice: '9.90',
    storeName: '天虹商场-凤凰城店',
    storeIcon: $r('app.media.tianhong'),
    image: $r('app.media.huacai')
  },
  {
    name: '水豆腐 约500g/份',
    desc: '本地直供，水嫩新鲜',
    price: '2.60',
    oldPrice: '3.90',
    storeName: '天虹商场-凤凰城店',
    storeIcon: $r('app.media.tianhong'),
    image: $r('app.media.doufu')
  },
  {
    name: '本地鸡蛋 约500g/份',
    desc: '本地散养，枚枚新鲜',
    price: '6.50',
    oldPrice: '7.90',
    storeName: '永辉超市-凤凰城店',
    storeIcon: $r('app.media.yonghui'),
    image: $r('app.media.jidan')
  },
  {
    name: '大白菜 约1.5kg',
    desc: '鲜嫩饱满，绿色生脆',
    price: '9.99',
    oldPrice: '12.9',
    storeName: '大润发(凤凰城店)',
    storeIcon: $r('app.media.darunfa'),
    image: $r('app.media.baicai')
  },
  {
    name: '五花肉 约250g',
    desc: '充气锁鲜包装非胀包',
    price: '20.5',
    oldPrice: '23.9',
    storeName: '大润发(凤凰城店)',
    storeIcon: $r('app.media.darunfa'),
    image: $r('app.media.wuhuaro')
  },
  {
    name: '广州酒家核桃包 330g',
    desc: '五分钟快蒸，绵糯多汁',
    price: '14.5',
    oldPrice: '16.9',
    storeName: '永辉超市-凤凰城店',
    storeIcon: $r('app.media.yonghui'),
    image: $r('app.media.hetao')
  }
];

// 搜索标签数据
export const QUICK_SEARCH_TAGS: string[] = ['鸡蛋', '柠檬', '排骨', '草莓', '葡萄', '木瓜', '车厘子'];

// 购物车商品数据
export const CART_PRODUCTS: CartProduct[] = [
  {
    name: '水豆腐 约500g/份',
    price: '2.60',
    image: $r('app.media.doufu'),
    quantity: 2,
    selected: true,
    productIndex: 1 // 对应推荐商品索引
  },
  {
    name: '大白菜 约1.5kg',
    price: '9.99',
    oldPrice: '12.9',
    tag: '直降',
    image: $r('app.media.baicai'),
    quantity: 1,
    selected: true,
    productIndex: 3 // 对应推荐商品索引
  },
  {
    name: '五花肉 约250g',
    price: '20.50',
    oldPrice: '23.9',
    tag: '直降',
    image: $r('app.media.wuhuaro'),
    quantity: 1,
    selected: false,
    productIndex: 4 // 对应推荐商品索引
  },
  {
    name: '花菜 约500g',
    price: '7.99',
    oldPrice: '9.90',
    tag: '直降',
    image: $r('app.media.huacai'),
    quantity: 1,
    selected: false,
    productIndex: 0 // 对应推荐商品索引
  },
  {
    name: '本地鸡蛋 约500g/份',
    price: '6.50',
    image: $r('app.media.jidan'),
    quantity: 2,
    selected: false,
    productIndex: 2 // 对应推荐商品索引
  },
  {
    name: '广州酒家核桃包 330g',
    price: '14.50',
    oldPrice: '16.9',
    tag: '直降',
    image: $r('app.media.hetao'),
    quantity: 1,
    selected: false,
    productIndex: 5 // 对应推荐商品索引
  }
];

// 订单商品接口
export interface OrderProduct {
  name: string;
  price: string;
  quantity: number;
  image: Resource;
}

// 订单数据接口
export interface OrderData {
  id: string;
  status: string;
  statusType: 'wait' | 'finished' | 'closed' | 'refund';
  btnText: string;
  storeName: string;
  storeIcon: Resource;
  products: OrderProduct[];
  totalPrice: string;
  createTime: string;
}

// 订单数据
export const ORDERS: OrderData[] = [
  {
    id: '202401150001',
    status: '待付款',
    statusType: 'wait',
    btnText: '去支付',
    storeName: '天虹商场-凤凰城店',
    storeIcon: $r('app.media.tianhong'),
    products: [
      { name: '水豆腐 约500g/份', price: '2.60', quantity: 2, image: $r('app.media.doufu') },
      { name: '花菜 约500g', price: '7.99', quantity: 1, image: $r('app.media.huacai') }
    ],
    totalPrice: '13.19',
    createTime: '2024-01-15 10:30'
  },
  {
    id: '202401140002',
    status: '待商家接单',
    statusType: 'wait',
    btnText: '取消订单',
    storeName: '永辉超市-凤凰城店',
    storeIcon: $r('app.media.yonghui'),
    products: [
      { name: '本地鸡蛋 约500g/份', price: '6.50', quantity: 1, image: $r('app.media.jidan') },
      { name: '广州酒家核桃包 330g', price: '14.50', quantity: 1, image: $r('app.media.hetao') }
    ],
    totalPrice: '21.00',
    createTime: '2024-01-14 15:20'
  },
  {
    id: '202401130003',
    status: '配送中',
    statusType: 'wait',
    btnText: '确认收货',
    storeName: '大润发(凤凰城店)',
    storeIcon: $r('app.media.darunfa'),
    products: [
      { name: '五花肉 约250g', price: '20.50', quantity: 1, image: $r('app.media.wuhuaro') },
      { name: '大白菜 约1.5kg', price: '9.99', quantity: 1, image: $r('app.media.baicai') }
    ],
    totalPrice: '30.49',
    createTime: '2024-01-13 09:15'
  },
  {
    id: '202401120004',
    status: '已送达',
    statusType: 'finished',
    btnText: '去评价',
    storeName: '天虹商场-凤凰城店',
    storeIcon: $r('app.media.tianhong'),
    products: [
      { name: '花菜 约500g', price: '7.99', quantity: 2, image: $r('app.media.huacai') }
    ],
    totalPrice: '15.98',
    createTime: '2024-01-12 14:30'
  },
  {
    id: '202401100005',
    status: '已完成',
    statusType: 'finished',
    btnText: '再次购买',
    storeName: '永辉超市-凤凰城店',
    storeIcon: $r('app.media.yonghui'),
    products: [
      { name: '本地鸡蛋 约500g/份', price: '6.50', quantity: 3, image: $r('app.media.jidan') },
      { name: '水豆腐 约500g/份', price: '2.60', quantity: 1, image: $r('app.media.doufu') }
    ],
    totalPrice: '22.10',
    createTime: '2024-01-10 11:45'
  },
  {
    id: '202401080006',
    status: '已取消',
    statusType: 'closed',
    btnText: '再次购买',
    storeName: '大润发(凤凰城店)',
    storeIcon: $r('app.media.darunfa'),
    products: [
      { name: '广州酒家核桃包 330g', price: '14.50', quantity: 2, image: $r('app.media.hetao') }
    ],
    totalPrice: '29.00',
    createTime: '2024-01-08 16:20'
  },
  {
    id: '202401070007',
    status: '退款到账',
    statusType: 'refund',
    btnText: '查看退款',
    storeName: '天虹商场-凤凰城店',
    storeIcon: $r('app.media.tianhong'),
    products: [
      { name: '花菜 约500g', price: '7.99', quantity: 1, image: $r('app.media.huacai') },
      { name: '五花肉 约250g', price: '20.50', quantity: 1, image: $r('app.media.wuhuaro') }
    ],
    totalPrice: '28.49',
    createTime: '2024-01-07 14:30'
  }
];

// 经常光顾商家接口
export interface FrequentShop {
  name: string;
  icon: Resource;
}

// 经常光顾商家数据
export const FREQUENT_SHOPS: FrequentShop[] = [
  { name: '天虹商场', icon: $r('app.media.tianhong') },
  { name: '永辉超市', icon: $r('app.media.yonghui') },
  { name: '大润发', icon: $r('app.media.darunfa') },
  { name: '昌大昌', icon: $r('app.media.changdachang') },
  { name: '大参林', icon: $r('app.media.dashenlin') },
  { name: '天福', icon: $r('app.media.tianfu') },
];
