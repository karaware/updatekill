# updatekill
## 概要
MySQLの100秒以上経過したUPDATEクエリをkillする
Kill an UPDATE query that is older than 100 seconds in MySQL

## 実行例
### 100秒以上経過したUPDATEクエリが存在しない場合
[root@localhost updatekill]# ./updatekill.sh

### 100秒以上経過したUPDATEクエリが存在する場合
[root@localhost updatekill]# ./updatekill.sh
pid=164,time=104 killed
pid=165,time=103 killed
