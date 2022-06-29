import request from '@/utils/request'

// 查询文件列表
export function listFiles(query) {
  return request({
    url: '/net-disc/files/list',
    method: 'get',
    params: query
  })
}

// 查询文件详细
export function getFiles(fileId) {
  return request({
    url: '/net-disc/files/' + fileId,
    method: 'get'
  })
}

// 新增文件
export function addFiles(data) {
  return request({
    url: '/net-disc/files',
    method: 'post',
    data: data
  })
}

// 修改文件
export function updateFiles(data) {
  return request({
    url: '/net-disc/files',
    method: 'put',
    data: data
  })
}

// 删除文件
export function delFiles(fileId) {
  return request({
    url: '/net-disc/files/' + fileId,
    method: 'delete'
  })
}
