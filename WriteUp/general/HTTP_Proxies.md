# Task 1

这一部分主要教如何使用 中间代理软件（如 Burp 或者 ZAP）来监控 http 请求以及对请求进行修改。

有三个需求：
* 将方法从 POST 改成 GET
* 添加 ‘x-request-intercepted:true’ 头部
* 将内容 changeMe 改成 'Requests are tampered easily'

没有抓包，直接使用 curl 即可：

```
curl -vn -X GET -H "Cookie: JSESSIONID=DEAD76682A419CB65A05D317A2AF3E97" -H "x-request-intercepted:true" http://127.0.0.1:8080/WebGoat/HttpProxies/intercept-request\?changeMe\=Requests%20are%20tampered%20easily
```
