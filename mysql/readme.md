##　bash脚本将csv数据导入mysql

## 运行脚本

``` bash
./csv2mysql.sh > result.log 2>error.log
```

**说明**

- *> result.log*: 将执行的标准输出(STDOUT)重定向到结果文件
- *2 > error.log*: 将标准错误输出(STDERR)重定向到错误日志文件

## 配置 *$HOME/.my.cnf*

如果直接将mysql 用户及密码写到bash, 执行脚本时mysql 会输出警告信息, 为了避免输出警告可将账户等信息配置到.my.cnf文件, 执行脚本中不需要再输入相应的mysql登录信息

``` bash
➜  /tmp more $HOME/.my.cnf       
[client]
host=localhost
user=root
password='123456'
```

## 测试用的表结构

```mysql

CREATE TABLE `cnarea_2017` (
  `id` mediumint(7) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` mediumint(7) unsigned NOT NULL DEFAULT '0' COMMENT '父级ID',
  `level` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '层级',
  `area_code` bigint(12) unsigned NOT NULL DEFAULT '0' COMMENT '行政代码',
  `zip_code` mediumint(6) unsigned zerofill NOT NULL DEFAULT '000000' COMMENT '邮政编码',
  `city_code` char(6) NOT NULL DEFAULT '' COMMENT '区号',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '名称',
  `short_name` varchar(50) NOT NULL DEFAULT '' COMMENT '简称',
  `merger_name` varchar(50) NOT NULL DEFAULT '' COMMENT '组合名',
  `pinyin` varchar(30) NOT NULL DEFAULT '' COMMENT '拼音',
  `lng` decimal(10,6) NOT NULL DEFAULT '0.000000' COMMENT '经度',
  `lat` decimal(10,6) NOT NULL DEFAULT '0.000000' COMMENT '纬度',
  PRIMARY KEY (`id`),
  KEY `idx_lev` (`level`,`parent_id`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='中国行政地区表';

```