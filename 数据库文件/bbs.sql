/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     2017/12/21 14:26:35                          */
/*==============================================================*/
drop database if exists bbs;

create database bbs;

use bbs;

grant select,insert,update,delete on bbs.* to test@localhost identified by '123456';

drop table if exists admin;

drop table if exists black_list;

drop table if exists favourite;

drop table if exists followpost;

drop table if exists main_forum;

drop table if exists post;

drop table if exists sub_forum;

drop table if exists user;

/*==============================================================*/
/* Table: admin                                                 */
/*==============================================================*/
create table admin
(
   userid               int not null,
   forumid              int not null,#管理的子版块的id号
   primary key (userid, forumid)
);

/*==============================================================*/
/* Table: black_list                                            */
/*==============================================================*/
create table black_list
(
   userid               int not null,
   level                int default 0,#封禁级别
   time                 datetime,#加入黑名单时间
   primary key (userid)
);

/*==============================================================*/
/* Table: favourite                                             */
/*==============================================================*/
create table favourite
(
   userid               int not null,
   postid               int not null,
   time                 datetime,#收藏时间
   primary key (userid, postid)
);

/*==============================================================*/
/* Table: followpost                                            */
/*==============================================================*/
create table followpost
(
   followpost_id        int auto_increment,#跟帖id
   post_id              int not null,#帖子id
   followpost_user_id   int,
   content              char(255),
   follow_time          datetime,#跟帖时间
   update_time          datetime,#最后一次修改时间
   primary key (followpost_id)#这里改了一下
);

/*==============================================================*/
/* Table: main_forum                                            */
/*==============================================================*/
create table main_forum
(
   id                   int auto_increment,#主板块id
   title                char(30) not null,
   info                 char(255),
   time                 datetime,
   primary key (id)
);

/*==============================================================*/
/* Table: post                                                  */
/*==============================================================*/
create table post
(
   id                   int auto_increment,#帖子id
   sub_id               int,#子版块的id号
   user_id              int,
   post_title           char(255),
   content              char(255),
   send_time            datetime,#发帖时间
   update_time          datetime,#最后一次修改时间
   post_type                 int default 0,#帖子类型，0为默认，1为精华
   isTop                int default 0,#0不置顶，1置顶
   view_num             int default 0,#浏览数
   reply_num            int default 0,#回帖数
   favorite_num         int default 0,#收藏数
   last_followpost_time datetime,#最后回复时间
   primary key (id)
);

/*==============================================================*/
/* Table: sub_forum                                             */
/*==============================================================*/
create table sub_forum
(
   id                   int auto_increment,#子版块的id号
   sub_forum_title                char(30) not null,
   info                 char(255),
   main_id              int,#主板块的id号
   time                 datetime,
   primary key (id)
);

/*==============================================================*/
/* Table: user                                                  */
/*==============================================================*/
create table user
(
   id                   int auto_increment,
   username             char(30) not null,
   userpassword         char(30) not null,
   info                 char(50),#个人简介
   avatar               char(50) default 'default.jpg',#头像
   sex                  char(10),
   email                char(50),
   status               int,#用户状态 正常用户：0，黑名单用户：1
   type                 int default 0,#普通用户：0，管理员：1
   level                int default 0,#用户等级
   register_time        datetime,
   primary key (id)
);

alter table followpost add constraint FK_Relationship_2 foreign key (post_id)
      references post (id) on delete cascade on update cascade;#这里修改了一下

alter table followpost add constraint FK_Relationship_5 foreign key (followpost_user_id)
      references user (id) on delete restrict on update restrict;

alter table post add constraint FK_Relationship_3 foreign key (sub_id)
      references sub_forum (id) on delete cascade on update cascade;#这里修改了一下

alter table post add constraint FK_Relationship_4 foreign key (user_id)
      references user (id) on delete restrict on update restrict;

alter table sub_forum add constraint FK_Relationship_1 foreign key (main_id)
      references main_forum (id) on delete cascade on update cascade;#这里修改了一下


create table image
(
	id int primary key auto_increment,
    user_id int,#上传者用户id
    name char(50),#图片名
    post_id int,#帖子id
    followpost_id int,#回帖id
    upload_time datetime,#上传时间
    image longblob,#图片
    info char(50)#附加信息
);


alter table image add constraint FK_Relationship_6 foreign key (user_id)
      references user (id) on delete cascade on update cascade;

alter table image add constraint FK_Relationship_7 foreign key (post_id)
      references post (id) on delete cascade on update cascade;

alter table image add constraint FK_Relationship_8 foreign key (followpost_id)
      references followpost(followpost_id) on delete cascade on update cascade;