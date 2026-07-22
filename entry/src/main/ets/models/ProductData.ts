/**
 * 商品与分类接口定义
 */
export interface ProductData {
  // TODO: 定义商品数据接口
  productId: string
  name: string
  price: number
  image: string
}

export interface CategoryData {
  // TODO: 定义分类数据接口
  categoryId: string
  name: string
}
