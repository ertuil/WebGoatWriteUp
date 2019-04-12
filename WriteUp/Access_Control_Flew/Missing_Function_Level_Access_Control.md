# Missing Function Level Access control

Missing Function Level Access is different from Insecure Direct Object References.

前者会暴露功能性？

## Task 1

找到页面中两个隐藏的链接。打开开发者工具，找到 Users 和 Config。

## Task 2

这题有两个做法：

简单的：去访问上页中找到的 /users 页面，发现返回 html。提示修改Get 的请求头。将 Content-type 修改成 application/json 后返回。

困难的：
太麻烦了，看 hints 即可
