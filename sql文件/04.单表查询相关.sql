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

# 4.修改某列值，即：查询商品价格，但是价格要加10
# 格式：update 数据表名 set 列名 = 新值 where 条件
SELECT product.pname, product.price + 10 as 商品加运费单价 FROM product;

# -------------------- 案例二: 条件查询 --------------------#
/*
 格式：
    select
        列名 [as 别名],列名 [as 别名] ...
    from
        数据表名
    where
        条件
条件可以是：
    1.比较运算符
        =:等于
        <>:不等于
        >:大于
        <:小于
        >=:大于等于
        <=:小于等于
    2.逻辑运算符
        and:且
        or:或
        not:非
    3.like:模糊查询
        %:匹配任意多个字符
        _:匹配任意一个字符
    4.范围查询
        between:在两个值之间，包含左右
        in (值1, 值2, 值3...):在多个值中任意一个
    5.空值查询
        is null:空值
        is not null:非空值
 */
# 1.查看所有的数据
SELECT * FROM product;


# 2.演示比较运算符
# 需求1：查找单价在500元以上商品
SELECT * FROM product where product.price >= 500;
# 需求2：查找不是c001类别的商品信息
SELECT * from product WHERE product.category_id != 'c001';

# 需求3：查找单价在 800~3000元的商品信息，只要商品名，价格
select pname, price from product where price BETWEEN 800 and 3000;

# 需求4：查找第二个字是霸的商品信息，商品名共两个字
SELECT * FROM product WHERE pname like '_霸';

# 需求5：查找商品名包括 斯 的商品信息
SELECT * FROM product WHERE pname like '%斯%';

# 需求6：查询单价是 200,800，或者5000的商品信息
SELECT * FROM product where price in (200,800,5000);

SELECT * FROM product where price = 200 OR price = 800 OR price = 5000;

# 需求7：查询单价不在 200,800,5000 中的商品信息
SELECT * FROM product where price not in (200,800,5000);

# 需求8：查询没有分类ID的商品信息
SELECT * FROM product WHERE category_id is null;


# -------------------- 案例三: 排序查询 --------------------#

/*
 格式：
    select
        列名 [as 别名],列名 [as 别名] ...
    from
        数据表名
    order by
        排序的列1 [asc | desc], 排序的列2 [asc | desc]...
 细节：
    1.默认是升序
    2.可以对多个列进行排序，多个列之间用逗号隔开
       */

# 2.按照价格进行升序排列
SELECT * FROM product order by price;
SELECT * FROM product order by price DESC;  # 降序

# 3.按照价格降序排列，如果价格一致，则按照分类Id降序
SELECT * FROM product order by price DESC, category_id DESC;

# -------------------- 案例四: 聚合查询 --------------------#
/*
 聚合查询：
    概述：
        对多条记录进行统计分析，得到一个结果
    分类：
        1.单行聚合查询
        2.多行聚合查询
    设计到的函数：
        count():统计记录数
        sum():求和
        avg():求平均值
        max():求最大值
        min():求最小值
    */

# 1.查看表数据
SELECT * FROM product;

# 2.统计数据条数
# 面试题：count(*),count(1),count(列名) 区别
/*
    1.是否统计null值
        count(*)):统计所有记录数，包括null值
        count(1):统计所有记录数，包括null值
        count(列名):统计列名不重复的记录数，不包括null值
    2.效率问题
        count(主键列):效率最高，因为主键列是唯一的，所以统计效率最高
        count(1):效率次之，因为1是常量，所以统计效率次之
        count(列名):效率最低，因为列名是重复的，所以统计效率最低
        count(*):效率最低，因为统计所有记录数，所以效率最低
    */
SELECT count(*) FROM product;                   # 统计所有记录数
SELECT count(1) FROM product;                   # 统计所有记录数，不包括null值
SELECT count(pid) FROM product;                 # 统计pid列不重复的记录数，
SELECT count(product.category_id) FROM product; # 统计category_id列不重复的记录数,null值不统计

# 3.查看商品价格的求和，平均值，最大值，最小值数据
SELECT
    sum(price) as 商品总金额,
    round(avg(price),2) as 商品评价单价,  # round()函数，保留两位小数
    max(price) as 商品最高价,
    min(price) as 商品最低价
FROM product;

# -------------------- 案例五: 分组查询 --------------------#
/*
 格式：
    select
        列名 [as 别名],列名 [as 别名] ...
    from
        数据表名
    group by
        分组字段
    having
        组后筛选
细节：
    1.分组字段必须在select中
    2.having用于组后筛选，where用于组前筛选
    3.面试题：区别where和having
        1.作用不同
        where用于组前筛选，having用于组后筛选
        2.是否可以跟聚合函数
        where不能跟聚合函数，having可以跟聚合函数
        3.效率问题
        where效率高于having，因为where在分组之前进行筛选，having在分组之后进行筛选
 */
# 1.查看表数据
SELECT * FROM product;

# 2.需求：统计每个类别的商品数量
SELECT category_id as 类别ID, count(pid) as 商品数量 from product GROUP BY category_id;

# 3.需求：统计每个类别的商品数量，要求商品数量大于2
SELECT
    category_id as 类别ID, count(pid) as 商品数量
from
    product
GROUP BY
    category_id
HAVING
    商品数量 > 2;

# -------------------- 案例六: 去重查询 --------------------#
/*
去重解释：
    概述：
        把相同的数据给移除掉，只保留一份。
    方式：
        1.distinct:去重
        2.分组实现去重
 */
# 1.查看表数据
SELECT * FROM product;

# 2.查看去重后的所有分类
SELECT DISTINCT product.category_id FROM product;

# 3.按照分类id，价格进行去重
SELECT DISTINCT category_id, price FROM product;

# 4.去重思路2：分组去重
SELECT product.category_id FROM product GROUP BY category_id;
SELECT product.category_id, product.price FROM product GROUP BY category_id, price;

# -------------------- 案例七: 分页查询 --------------------#
/*
    分页查询：
        好处：
            1.提高用户体验
            2.降低服务器端压力
            3.降低浏览器端压力
        概述：
            分页查询就是把数据分成多页，每页显示一部分数据，用户可以通过点击下一页，上一页，跳转到指定页码来查看数据
        格式：
            select
                列名 [as 别名],列名 [as 别名] ...
            from
                数据表名
            limit
                起始索引，数据条数
细节：
    1.在sql中，每条数据都是有索引的，且索引从0开始，
    2.关于分页
        总页数：(数据的总条数 + 每页的数据条数 - 1) // 每页的数据条数
        每页的数据条数：产品经理
        每页的起始索引：(当前页数 - 1) * 每页的数据条数
        数据总条数：      count(*)
 */

# 1.查看表数据
select * from product;

# 2.场景3:3条/页
SELECT * from product limit 0,3; -- 起始索引为0，数据条数为3,第一页
SELECT * from product limit 3,3; -- 起始索引为3，数据条数为3,第二页
SELECT * from product limit 6,3; -- 起始索引为6，数据条数为3,第三页

# 3.场景2:5条/页
SELECT * from product limit 0,5;    -- 起始索引为0，数据条数为5,第一页
SELECT * from product limit 5,5;    -- 起始索引为5，数据条数为5,第二页
SELECT * from product limit 10,5;   -- 起始索引为10，数据条数为5,第三页

# 4.场景3:2条/页
SELECT * from product limit 0,2;    -- 起始索引为0，数据条数为2,第一页
SELECT * from product limit 2,2;    -- 起始索引为2，数据条数为2,第二页
SELECT * from product limit 4,2;    -- 起始索引为4，数据条数为2,第三页

#




