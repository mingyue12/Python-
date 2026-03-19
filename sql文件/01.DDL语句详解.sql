/*
SQL语句介绍：
    概述：
        全程叫Structured Query Language,结构化查询语言，主要是实现用户与数据库交互
    分类：
        DDL：数据定义语言
            实际关键字：creat，drop,alter,alert(),show
        DML：数据操作语言
            涉及关键词：insert，delete，update
        DQL：数据查询语言
            涉及关键字：select，from，where
        DCL：数据控制语言
    通用语法：
        1.可以写一行，也可以写多行。
        2.SQL语句不区分大小写，为了方便阅读，建议关键字大写，其余小写。
        3.注释写法 /星 星/多行注释
                    # 单行注释
                    -- 单行注释

*/

# 1.查看本机安装的所有数据库
show DATABASES;
SELECT database();

# 案例一：DDL语句操作数据库
# 1.查看已创建的所有数据库
show DATABASES;

# 2.创建数据库
create DATABASE day01;                      # 以utf-8默认码表创建数据库
create DATABASE day02 character SET 'gbk';  # 以Gbk码表，创建数据库
create DATABASE day01;                      # 会报错，因为day01数据库已存在了
CREATE DATABASE if not exists day01;        # 如果day01数据库不存在，才创建

#  完整建库格式
create DATABASE if not EXISTS day03 charset 'utf-8';      # 以utf-8码表创建数据库

# 3.修改数据库 -> 码表
alter database day02 CHARSET 'utf8';

# 4.删除数据库
drop DATABASE day01;

# 5.查看当前是哪个数据库
SELECT database();

# 6.切换数据库
use day01;

# 7.查看某个已安装的数据库的码表
show create DATABASE day01; # 默认utf-8码表
show create DATABASE day02; # 使用utf-8码表创建
