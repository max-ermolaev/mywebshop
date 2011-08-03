/* This is an Upgrade script for sqlserver2008 for version 20110728184204 */
ALTER TABLE [Order]
ADD OrderDate datetime not null, ShipDate datetime not null
