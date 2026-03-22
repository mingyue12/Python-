/*

 约束介绍：
    概述：
        就是在数据类型的基础上，进一步对某列值做限定
    分类：
        单表约束：
            primary key:主键约束，特点：非空，唯一，一般结合自增（auto_increment）一起用
            not null:   非空约束
            unique:     唯一约束
            default:    默认约束
        多表约束：
            foreign key
 */

 # --------------------案例一：演示主键约束--------------------#
# 1.建库，切库，查表
CREATE DATABASE IF NOT EXISTS day02;
SHOW DATABASES ;
USE day02;
show TABLES ;
# 场景1：建表时添加主键约束
drop TABLE student;
# 0.删表
drop TABLE student;

# 1.创建学生表，字段：id，name，age
CREATE TABLE student(
    sid int PRIMARY KEY AUTO_INCREMENT,   # 学号
    name VARCHAR(20),       # 姓名
    age INT
);
# 2.查看表结构
desc student;


# 3.插入数据
insert into student VALUES(1, '张三', 18);

# 4.查看表数据
select * FROM student;

# 5.删除主键约束
alter TABLE student DROP PRIMARY KEY;

# 6.建表后，添加主键约束，结合自增
alter TABLE student add PRIMARY KEY(sid);
ALTER TABLE student MODIFY sid int AUTO_INCREMENT; # 增加自增


# 7.再次尝试往表中添加数据
insert into student VALUES (1, '李四', 20);
insert into student VALUES (NULL, '李四', 20);
insert into student VALUES (NULL, '赵六', 20);
select * from student;

# 8.总结，实际开发中，掌握如下代码即可
# 建表
# 插入数据
# 查看数据

# 回顾：delete from 表名 where 条件;(不会重置主键id)
# truncate table 表名;(会重置主键id:自增计数器)
DELETE FROM student;        # 删除所有数据，但是主键id不会重置
TRUNCATE TABLE student;     # 删除所有数据，主键id会重置为1

# --------------------案例二：演示主键约束--------------------#
# 1.查表
show TABLES;

# 2.建表，员工表（employee），字段（id,name,phone,gender,addr）
