/*
  单表查询介绍：
        概述：
            所谓的单表查询，指的是按照一定的条件，从一张SQL表中查出我们想要的结果数据
        总的格式：
            select
                [distinct] 列名 [as 别名],列名 [as 别名] ...
            from
                数据表名
            where
                组前筛选
            group by
                分组字段
            having
                组后筛选
            order by
                排序的列1 [asc | desc], 排序的列2 [asc | desc]...
            limit
                起始索引，数据条数
        细节：


 */
# -------------------- 准备工作：准备数据 --------------------#
# 切库
USE day02;
-- 1. 创建商品表
CREATE TABLE product (
                         pid INT PRIMARY KEY AUTO_INCREMENT,  -- 商品ID，主键自增
                         pname VARCHAR(20),                  -- 商品名称
                         price DOUBLE,                       -- 商品单价
                         category_id VARCHAR(32)             -- 商品分类ID
);
DROP TABLE product;
-- 2. 插入表数据
INSERT INTO product(pid, pname, price, category_id) VALUES(NULL, '联想', 5000, 'c001');
INSERT INTO product(pid, pname, price, category_id) VALUES(NULL, '海尔', 3000, 'c001');
INSERT INTO product(pid, pname, price, category_id) VALUES(NULL, '雷神', 5000, 'c001');
INSERT INTO product(pid, pname, price, category_id) VALUES(NULL, '杰克琼斯', 800, 'c002');
INSERT INTO product(pid, pname, price, category_id) VALUES(NULL, '真维斯', 200, NULL);
INSERT INTO product(pid, pname, price, category_id) VALUES(NULL, '花花公子', 440, 'c002');
INSERT INTO product(pid, pname, price, category_id) VALUES(NULL, '劲霸', 2000, 'c002');
INSERT INTO product(pid, pname, price, category_id) VALUES(NULL, '香奈儿', 800, 'c003');
INSERT INTO product(pid, pname, price, category_id) VALUES(NULL, '相宜本草', 200, NULL);
INSERT INTO product(pid, pname, price, category_id) VALUES(NULL, '面霸', 5, 'c003');
INSERT INTO product(pid, pname, price, category_id) VALUES(NULL, '好想你枣', 56, 'c004');
INSERT INTO product(pid, pname, price, category_id) VALUES(NULL, '香飘飘奶茶', 1, 'c005');
INSERT INTO product(pid, pname, price, category_id) VALUES(NULL, '海澜之家', 1, 'c002');

# -------------------- 案例一: 简单查询 --------------------#
# 1.查询所有商品
select * from product;
SELECT pid, pname, price FROM product;

# 2.查询指定列的数据，商品名，价格
SELECT pname, price FROM product;

# 3.别名查询
# 格式：select 列名 as 别名,列名 as 别名 from 数据表名
SELECT pname as 商品名称, price as 商品单价 FROM product as p;
