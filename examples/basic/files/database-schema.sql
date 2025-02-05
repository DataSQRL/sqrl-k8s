CREATE TABLE IF NOT EXISTS _spendingbyday_1 ("customerid" BIGINT NOT NULL,"timeDay" TIMESTAMP WITH TIME ZONE NOT NULL,"spending" DOUBLE PRECISION NOT NULL , PRIMARY KEY ("customerid","timeDay"));
CREATE TABLE IF NOT EXISTS customertransaction_1 ("transactionId" BIGINT NOT NULL,"cardNo" DOUBLE PRECISION NOT NULL,"time" TIMESTAMP WITH TIME ZONE NOT NULL,"amount" DOUBLE PRECISION NOT NULL,"merchantName" TEXT NOT NULL,"category" TEXT NOT NULL,"customerid" BIGINT NOT NULL , PRIMARY KEY ("transactionId","time"));
CREATE TABLE IF NOT EXISTS spendingbycategory_1 ("customerid" BIGINT NOT NULL,"timeWeek" TIMESTAMP WITH TIME ZONE NOT NULL,"category" TEXT NOT NULL,"spending" DOUBLE PRECISION NOT NULL , PRIMARY KEY ("customerid","timeWeek","category"));
CREATE INDEX IF NOT EXISTS customertransaction_1_btree_c6c2 ON customertransaction_1 USING btree ("customerid","time");

