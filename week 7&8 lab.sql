use 1BF25CS083;
create table Suppliers(SID int primary key, SNAME varchar(30) NOT NULL, CITY varchar(30));
create table Parts(PID int primary key, PNAME varchar(30) NOT NULL, COLOR varchar(30));
create table Catalog(COST int NOT NULL, SID int, foreign key(SID) references Suppliers(SID), PID int, foreign key(PID) references Parts(PID));

insert into Suppliers values (10001, 'Acme Widget', 'Bangalore');
insert into Suppliers values (10002, 'Johns', 'Kolkata');
insert into Suppliers values (10003, 'Vimal', 'Mumbai');
insert into Suppliers values (10004, 'Reliance', 'Delhi');

insert into Parts values (20001, 'Book', 'Red');
insert into Parts values (20002, 'Pen', 'Red');
insert into Parts values (20003, 'Pencil', 'Green');
insert into Parts values (20004, 'Mobile', 'Green');
insert into Parts values (20005, 'Charger', 'Black');

insert into Catalog values (10, 10001, 20001);
insert into Catalog values (10, 10001, 20002);
insert into Catalog values (30, 10001, 20003);
insert into Catalog values (10, 10001, 20004);
insert into Catalog values (10, 10001, 20005);
insert into Catalog values (10, 10002, 20001);
insert into Catalog values (20, 10002, 20002);
insert into Catalog values (30, 10003, 20003);
insert into Catalog values (40, 10004, 20003);

 
select DISTINCT P.PNAME from PARTS P, CATALOG C where P.PID=C.PID;
select S.SNAME from Suppliers S where not exists (select P.pid from Parts P where not exists ( select C.sid from Catalog C where C.sid = S.sid and C.pid = P.pid));
select S.SNAME from SUPPLIERS S join CATALOG C on S.SID = C.SID join PARTS P on C.PID = P.PID where P.COLOR = 'Red' group by S.SID, S.SNAME having COUNT(DISTINCT P.PID) = (select COUNT(*) from PARTS where COLOR = 'Red');
select P.PNAME from PARTS P join CATALOG C on P.PID = C.PID join SUPPLIERS S on C.SID = S.SID where S.SNAME = 'Acme Widget' and P.PID not in ( select C2.PID from CATALOG C2 join SUPPLIERS S2 on C2.SID = S2.SID where S2.SNAME <> 'Acme Widget');
select DISTINCT C1.SID from CATALOG C1 join CATALOG C2 on C1.PID = C2.PID group by C1.SID, C1.PID, C1.COST having C1.COST > AVG(C2.COST);
select P.PNAME, S.SNAME, C.COST from PARTS P join CATALOG C on P.PID = C.PID join SUPPLIERS S on C.SID = S.SID join (SELECT PID, MAX(COST) as MAX_COST from CATALOG group by PID) M on C.PID = M.PID AND C.COST = M.MAX_COST;