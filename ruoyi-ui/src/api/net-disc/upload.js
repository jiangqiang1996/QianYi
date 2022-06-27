import request from '@/utils/request'

// 合并分片文件
export function mergeFile(data) {
  return request({
    url: '/net-disc/mergeFile',
    method: 'post',
    data: data
  })
}
