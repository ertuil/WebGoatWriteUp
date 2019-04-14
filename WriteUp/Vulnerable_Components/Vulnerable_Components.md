# Vulnerable Components

这里主要介绍大家网站建设过程中使用框架的一系列漏洞的利用。

## jquery-ui:1.10.4 

没有 XSS 漏洞的过滤机制。
 
1.12.0 后无这个漏洞。

## Commons Collections

有反序列化漏洞

[http://www.pcworld.com/article/3004633/business-security/thousands-of-java-applications-vulnerable-to-nine-month-old-remote-code-execution-exploit.html](http://www.pcworld.com/article/3004633/business-security/thousands-of-java-applications-vulnerable-to-nine-month-old-remote-code-execution-exploit.html)

## Dinis Cruz and Alvaro Munoz exploit of XStream
有远程代码执行漏洞

[https://github.com/pwntester/XStreamPOC](https://github.com/pwntester/XStreamPOC)

[http://blog.diniscruz.com/2013/12/xstream-remote-code-execution-exploit.html](http://blog.diniscruz.com/2013/12/xstream-remote-code-execution-exploit.html)

## Task 2 

利用漏洞 CVE-2013-7285 进行攻击。