# JWT Tokens

这一章节主要介绍了 JWT 的有关知识。及其漏洞利用。

JWT 格式分为以下三个部分：

* header 头部，表明了 JWT 协议、使用签名算法
* claims 申明，主要是主要数据的内容
* signature 签名，使用签名可以验证 Cookies 没有被非法篡改

``` json
{
  "alg":"HS256",
  "typ":"JWT"
}
.
{
  "exp": 1416471934,
  "user_name": "user",
  "scope": [
    "read",
    "write"
  ],
  "authorities": [
    "ROLE_ADMIN",
    "ROLE_USER"
  ],
  "jti": "9bc92a44-0b1a-4c5e-be70-da52075b9a84",
  "client_id": "my-client-with-secret"
}
.
qxNjYSPIKSURZEMqLQQPw1Zdk6Le2FdGHRYZG7SQnNk
```

常见的签名算法有 "HMAC with SHA-2 Functions" 或 "Digital Signature with RSASSA-PKCS1-v1_5/ECDSA/RSASSA-PSS" function for signing the token.


攻击方式：

* 敏感信息泄露
* 修改算法为 none 将alg修改为none后，去掉JWT中的signature数据（仅剩header + '.' + payload + '.'）然后提交到服务端即可
* 修改算法RS256为HS256（非对称密码算法 => 对称密码算法）

算法HS256使用秘密密钥对每条消息进行签名和验证。算法RS256使用私钥对消息进行签名，并使用公钥进行验证。如果将算法从RS256更改为HS256，后端代码会使用公钥作为秘密密钥，然后使用HS256算法验证签名。由于公钥有时可以被攻击者获取到，所以攻击者可以修改header中算法为HS256，然后使用RSA公钥对数据进行签名。后端代码会使用RSA公钥+HS256算法进行签名验证。

* HS256 较弱，可以暴力破解

# Task 1

获取的 JWT 为：
```
eyJhbGciOiJIUzUxMiJ9.
eyJpYXQiOjE1Mjk1NTkzNzksImFkbWluIjoiZmFsc2UiLCJ1c2VyIjoiVG9tIn0.
KcvygZbm6EzDZn8_X7ppL5M6NdnNPkObZv7e-KyOKZf6Zui3-DB5ClHCLOj3dlgT6ngJHqMT0FWhP-DwQkj1og
```

结果是:
```
{"alg":"HS512"}.
{"iat":1555917471,"admin":"false","user":"Tom"}
```

# 题目不想做了 直接看了 Write UP
