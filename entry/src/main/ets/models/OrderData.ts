/**
 * 订单数据接口及状态枚举 (Enum)
 */
export enum OrderStatus {
  PENDING_PAYMENT = '待付款',
  PENDING_DELIVERY = '待配送',
  PENDING_RECEIPT = '待收货',
  PENDING_REVIEW = '待评价',
  COMPLETED = '已完成',
  CANCELLED = '已取消'
}

export interface OrderData {
  // TODO: 定义订单数据接口
  orderId: string
  status: OrderStatus
  totalPrice: number
  createTime: string
}
