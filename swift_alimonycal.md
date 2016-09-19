#swift alimonyCal
###算账小程序
###需要参数
#####1.人名
```
var xMan = ["Anne","Bellis","Sue","Tommao","Lagel","Jiaqin","Bo","Peach"]
```
####2.项目名称

```
var consume = [
	["name": "项目名称"],
	["allM": "总共花钱金额"],
	["who": "谁付账"],
	["share":[Int]谁需要买单]
]
```
eg:

```
var consume = [
    ["name":"黄酒","allM":"22.0","who":"Tommao","share":[0,1,2,3,4,5,6]],
    ["name":"午餐","allM":"148.0","who":"Sue","share":[1,2,3,6,7,8]]
    ]
 ```
