# 新版 mysql 使用三个线程执行复制
> 主库一个: 二进制转储线程
> 从库两个: I/O 复制线程和SQL重放线程
> 在主库上并发运行的查询在从库中只能串行执行(因为从库只使用一个SQL线程重放中继日志事件)，这是复制过程负载瓶颈所在, 可能会出现延迟

# 1. 在主库上启用 bin-log
log-bin				= /var/lib/mysql_data/mysql-bin.log
#log-bin-index		= /var/lib/mysql_data/mysql-bin-log.index
expire_logs_days	= 10
max_binlog_size		= 100M
binlog_format		= mixed 
server-id           = 10

> 每次主库准备提交事务完成数据更新之前，将该更新事件记录到自己的二进制日志中
> 在完成记录二进制日志后，主库会告诉存储引擎可以提交事物了
> MySQL 会按事物的提交顺序记录二进制日志，而非每条语句的执行顺序来记录日志
> 当主库完成日志记录后，将唤醒从库的I/O复制线程，从库的I/O复制线程接到通知后将开始复制

# 2. 从库将主库上的二进制日期复制到自己的中继日志 （Relay Log）
> I/O复制线程跟主库建立一个普通的客户端连接，然后在主库上启动一个特殊的二进制转储线程(binlog dump)，该线程会读取主库上的二进制日志事件
> I/O复制线程不会对二进制事件进行轮询，如果该线程已经赶上了主库，他将进入睡眠。
> 直到主库发送信号量通知其有新的二进制事件产生时才被唤醒，
> 从库I/O线程会将收到的事件记录的本地中继日志(Relay Log)

# 3. 从库的SQL线程将读取中继日志中的事件，并将其重放到自己的数据库中
> 从库SQL线程执行的二进制日志事件可以通过配置选项来决定是否写入自己的二进制日志中



## steps
1. 在每台服务器上创建复制帐号
2. 配置主库和从库
3. 通知从库连接到主库并从主库复制数据

1. grant replication slave, replication client on *.* to user_repl@'172.19.0.%' identified by 'Cc';
   flush privileges;
2. relay_log               = /var/lib/mysql_data/mysql-relay-bin
   log_slave_updates       = 1     # 允许作为从库时重放的事件也记录到自身的二进制日志中
   read_only               = 0     # 阻止任何没有特权权限的线程修改数据, 当需要在从库中建表时需设置为 0

mysql> change master to master_host='mysql.primary', master_user='user_repl', master_password='Cc', master_log_file='mysql-bin.000001', master_log_pos=0;
mysql> show slave status\G
mysql> start slave;
mysql> stop slave;
mysql> show processlist;

mysql> change master to master_host='mysql.slave1', master_user='user_repl', master_password='Cc', master_log_file='mysql-bin.000005', master_log_pos=0;

# alter table `firsttable` add column phone varchar(32) null after `name`;  
# alter table `firsttable` add column address varchar(255) null after `phone`;  
# alter table firsttable drop column address;
# alter table `firsttable` modify column phone varchar(132) null;  



### 问题:
1. 怎样降低复制延迟, 
   > how to Avoid MySQL Replication Delays
   > MySQL Parallel Replication (LOGICAL_CLOCK)

2. 怎样配置读写分离, MySQL Proxy 实现负载均衡、读写分离


## Solving MySQL Replication Lag with LOGICAL_CLOCK and Calibrated Delay
https://www.vividcortex.com/blog/solving-mysql-replication-lag-with-logical_clock-and-calibrated-delay

## Solving MySQL Replication Lag with LOGICAL_CLOCK and Calibrated Delay
https://www.vividcortex.com/blog/solving-mysql-replication-lag-with-logical_clock-and-calibrated-delay


## MySQL5.7 并行复制: (https://www.kancloud.cn/thinkphp/mysql-parallel-applier/45909)
	> 5.7引入了新的变量 slave-parallel-type，其可以配置的值有：
	  DATABASE：默认值，基于库的并行复制方式
	  LOGICAL_CLOCK：基于组提交的并行复制方式
	> SHOW BINLOG EVENTS;

## 开启 MySQL 5.7 并行复制需要二步 (http://www.10tiao.com/html/357/201707/2247485423/1.html)
	> 首先在主库设置 binlog_group_commit_sync_delay 的值大于0 。
	  -- mysql> set global binlog_group_commit_sync_delay=10;	# 全局动态变量，单位微妙，默认0，范围：0～1000000（1秒）, 表示 binlog 提交后等待延迟多少时间再同步到磁盘
	  -- mysql> set global binlog_group_commit_sync_no_delay_count=10;
    > 其次要在 Slave 主机上设置如下几个参数：
      -- slave-parallel-type=LOGICAL_CLOCK
	  -- slave-parallel-workers=4

## 并行复制配置与调优:
   -- 开启 MTS 功能后，务必将参数 master-info-repository 设置为 TABLE ，这样性能可以有 50%~80% 的提升。
      这是因为并行复制开启后对于 master.info 这个文件的更新将会大幅提升，资源的竞争也会变大。
   -- 在 MySQL 5.7 中，推荐将 master-info-repository 和 relay-log-info-repository 设置为 TABLE ，来减小这部分的开销。
	  > master-info-repository = table
	  > relay-log-info-repository = table
	  > relay-log-recovery = ON
