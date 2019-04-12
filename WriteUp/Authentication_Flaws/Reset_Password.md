# 找回密码中的问题

主要是：

* 可能泄露账户是否存在
* 可能暴力破解

#Task 3

```
curl -vn -d "email=tom%40webgoat-cloud.org" -H "Cookie: JSESSIONID=ED6E5B9C6662879D1B60F54D0FEBE2BF" -X POST http://127.0.0.1:8080/WebGoat/PasswordReset/reset/create-password-reset-link
```
