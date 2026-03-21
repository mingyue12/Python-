/*
 DMl语句详解：
    概述：
        他叫数据操作语言，主要是操作表数据，进行增删改操作。
        实际开发中，增删改统称为更新语句。
    细节：
        进行删除，修改前，一定一定一定要备份(或加where条件)。
    添加数据：
        格式：
            insert into 数据名称(列名1，列名2，....) value(值1，值2.....);
            insert into 数据表名 values(值1，值2....);

            insert into 数据表名 values(值1，值2....),(值1，值2....)...;
            细节：
                1.要添加的值的个数，必须和列名及其类型对应
                2.如果不写列名，默认是全列名
    修改数据：
        格式：
            update 数据表名 set 列名1=值1，列名2=值2.... where 条件;
        细节：
            1.修改数据时，必须写where条件，否则会修改所有数据
            2.如果写多个列名，用逗号隔开
            3.如果写多个值，用逗号隔开

    删除数据：
        格式：
            delete from 数据表名 where 条件;
            truncate table 数据表名;    # 删除表中所有数据，但是表结构不删除
        细节：
            1.删除数据时，必须写where条件，否则会删除所有数据
            2.如果写多个条件，用逗号隔开
 */


 # ----------------------------------------案例一：DML语句操作表数据增（table）----------------------------------- #
# 1.切库
use day01;
show TABLES;

# 2.创建分类表，分类id，分类名称，描述信息
create table category(
    cid int,                # 分类id
    cname varchar(20),      # 分类名称
    info varchar(100)       # 分类描述信息
);
# 3.往表中添加数据
insert into category(cid, cname) values(1,'电脑');

insert into category VALUES (2,'手机','华为增智慧');

# 4.查看表数据
INSERT INTO category
VALUES
    (3, '汽车', '小米'),
    (4, '平板', '小米');

# 5.查看全表数据
select * from category;

# ----------------------------------------案例二：DML语句操作表数据改（table）----------------------------------- #
# 1.查看表数据
select * from category;

# 2.修改cname=‘空调’，info=‘小米’,cid=3
UPDATE category SET cname='空调',info='小米' WHERE cid=3;

# ----------------------------------------案例三：DML语句操作表数据改（table）----------------------------------- #
# 演示 delete from
delete from category where cid = 4;
DELETE from category;   # 删除表中所有数据，但是表结构不删除

# 演示 truncate table
truncate table category;   # 删除表中所有数据，但是表结构不删除

# ----------------------------------------案例四：扩展如何备份数据表----------------------------------- #
# 查看数据表
show tables;
# 1.原表
SELECT * from category;

# 2.场景1：备份表不存在
# 格式：create table 备份表名 select * from 原表名 where;
CREATE TABLE category_tmp SELECT * FROM category;

# 3.场景2：备份表存在
#   格式： insert into 备份表名 select * from 原表名 where...;
INSERT INTO category_tmp SELECT * FROM category;



# 4.查看备份表数据
select * from category_tmp;

# 5.清空备份表
DELETE FROM category_tmp;
SELECT now();




























