import request from '@/utils/request'

// 查询文章新增列表
export function listArticles(query) {
  return request({
    url: '/blog/articles/list',
    method: 'get',
    params: query
  })
}

// 查询文章新增详细
export function getArticles(articleId) {
  return request({
    url: '/blog/articles/' + articleId,
    method: 'get'
  })
}

// 新增文章新增
export function addArticles(data) {
  return request({
    url: '/blog/articles',
    method: 'post',
    data: data
  })
}

// 修改文章新增
export function updateArticles(data) {
  return request({
    url: '/blog/articles',
    method: 'put',
    data: data
  })
}

// 删除文章新增
export function delArticles(articleId) {
  return request({
    url: '/blog/articles/' + articleId,
    method: 'delete'
  })
}
