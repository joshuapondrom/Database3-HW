.output stdout
.print "Creating Tables"

CREATE TABLE AlbumTrack(
	rid	INT	NOT NULL,
	cat	VARCHAR(15)	NOT NULL,
	sid	INT	NOT NULL,
	trackno	INT,
	PRIMARY KEY(rid, cat, sid)
);

CREATE TABLE Rerelease(
	cat	VARCHAR(20)	NOT NULL,
	rid	INT	NOT NULL,
	upc	VARCHAR(20),
	label	INT	NOT NULL,
	year	INT,
	medium	VARCHAR(20),
	PRIMARY KEY(cat, rid)
);

CREATE TABLE Artist(
	aid	INT	PRIMARY KEY,
	aname	VARCHAR(20)
);

CREATE TABLE Label(
	lid	INT	PRIMARY KEY,
	lname	VARCHAR(20),
	labbr	VARCHAR(20)
);

CREATE TABLE Release(
	rid	INT	PRIMARY KEY,
	rtitle	VARCHAR(40),
	year	INT,
	aid	INT	NOT NULL
);

CREATE TABLE Song(
	sid	INT	PRIMARY KEY,
	stitle	VARCHAR(50),
	duration	INT,
	remix of	INT
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

INSERT INTO Song VALUES(1,"Brazil (2nd Edit)",323,NULL);
INSERT INTO Song VALUES(2,"I Remember",548,NULL);
INSERT INTO Song VALUES(3,"Faxing Berlin (Piano Acoustica Version)",105,4);
INSERT INTO Song VALUES(4,"Faxing Berlin",150,NULL);

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
