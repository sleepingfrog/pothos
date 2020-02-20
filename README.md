# README
あれやこれをテストするやつ

## setup
```sh
dip provision
```
### depends
+ docker-compose
+ dip

## minio
s3互換を手元で動かして見たかったのでminioを使ったが
ホストマシンのhostsに
```txt
127.0.0.1   minio
```
を追加しないといい感じに動作しない・・・どうしたものか・・・
