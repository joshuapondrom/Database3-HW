/*Code in Sqlite3*/
/*Tested in Xubuntu campus machines, and Ubuntu 17 personal laptop */

.output stdout
.print "Creating Tables"

CREATE TABLE AlbumTrack(
	rid	INT	NOT NULL,
	cat	VARCHAR(15)	NOT NULL,
	sid	INT	NOT NULL,
	trackno	INT	NOT NULL,
	PRIMARY KEY(rid, cat, sid)
);

CREATE TABLE Rerelease(
	cat	VARCHAR(20)	NOT NULL,
	rid	INT	NOT NULL,
	upc	VARCHAR(12),
	label	INT	NOT NULL,
	year	INT	NOT NULL,
	medium	VARCHAR(20)	NOT NULL,
	PRIMARY KEY(cat, rid)
);

CREATE TABLE Artist(
	aid	INT	PRIMARY KEY,
	aname	VARCHAR(20)	NOT NULL
);

CREATE TABLE Label(
	lid	INT	PRIMARY KEY,
	lname	VARCHAR(20)	NOT NULL,
	labbr	VARCHAR(5)	NOT NULL
);

CREATE TABLE Release(
	rid	INT	PRIMARY KEY,
	rtitle	VARCHAR(40)	NOT NULL,
	year	INT	NOT NULL,
	aid	INT	NOT NULL
);

CREATE TABLE Song(
	sid	INT	PRIMARY KEY,
	stitle	VARCHAR(50)	NOT NULL,
	duration	INT	NOT NULL,
	remixof	INT,
	artist	INT	NOT NULL
);

.print "Inserting"

INSERT INTO AlbumTrack VALUES(1,"UL 1868-2",1,5);
INSERT INTO AlbumTrack VALUES(1,"UL 1868-2",2,7);
INSERT INTO AlbumTrack VALUES(1,"UL 1868-2",3,8);
INSERT INTO AlbumTrack VALUES(1,"UL 1868-2",4,9);
INSERT INTO AlbumTrack VALUES(1,"MAU5RAT",1,5);
INSERT INTO AlbumTrack VALUES(1,"MAU5RAT",2,7);
INSERT INTO AlbumTrack VALUES(1,"MAU5RAT",3,8);
INSERT INTO AlbumTrack VALUES(1,"MAU5RAT",4,9);

INSERT INTO Rerelease VALUES("UL 1868-2",1,617465186820,1,2008,"CD");
INSERT INTO Rerelease VALUES("MAU5RAT",1,NULL,2,2016,"Web");

INSERT INTO Artist VALUES(1,"deadmau5");

INSERT INTO Label VALUES(2,"mau5trap","MAU");
INSERT INTO Label VALUES(1,"Ultra Records","UL");

INSERT INTO Release VALUES(1,"Random Album Title.",2008,1);

INSERT INTO Song VALUES(1,"Brazil (2nd Edit)",323,NULL,1);
INSERT INTO Song VALUES(2,"I Remember",548,NULL,1);
INSERT INTO Song VALUES(3,"Faxing Berlin (Piano Acoustica Version)",105,4,1);
INSERT INTO Song VALUES(4,"Faxing Berlin",150,NULL,1);

.print "Selecting All"

SELECT * from AlbumTrack;
SELECT * from Rerelease;
SELECT * from Artist;
SELECT * from Label;
SELECT * from Release;
SELECT * from Song;

.print "Queries"
.print "Part A"
/* Part A */
SELECT stitle
FROM Song S
WHERE S.sid IN (SELECT sid
	        FROM AlbumTrack A, Rerelease R
	        WHERE A.rid = R.rid AND A.cat = R.cat AND R.year > 2008 AND R.label = (SELECT lid
	 						  			       FROM Label
      										       WHERE Lname = "Ultra Records"));


.print "Part B"
/* Part B */
SELECT Q.rtitle, R.year, count(sid)
FROM Rerelease R, Release Q, AlbumTrack A
WHERE Q.rid = R.rid AND R.rid = A.rid AND Q.rid = A.rid AND A.cat = R.cat
GROUP BY R.year;

.print "Part C"
/* Part C */
SELECT Q.rtitle, R.cat, sum(duration)
FROM Rerelease R, Release Q, AlbumTrack A, Song S
WHERE Q.rid = R.rid AND R.rid = A.rid AND Q.rid = A.rid AND A.cat = R.cat AND S.sid = A.sid
GROUP BY A.cat;

.print "Part D"
/* Part D */
SELECT S1.stitle, S1.duration, A1.aname, S2.stitle, A2.aname
FROM Song S1, Artist A1, Song S2, Artist A2
WHERE S1.artist = A1.aid AND S2.artist = A2.aid AND S1.remixof = S2.sid;
