Use Final_ADT;
CREATE TABLE Artist (
    ArtistId INT PRIMARY KEY IDENTITY(1,1),
    ArtistName NVARCHAR(100)
);

CREATE TABLE Album (
    AlbumId INT PRIMARY KEY IDENTITY(1,1),
    AlbumName NVARCHAR(100),
    ReleaseDate DATE,
    TotalTracks INT,
    AlbumDuration TIME,
    ArtistId INT,
    FOREIGN KEY (ArtistId) REFERENCES Artist(ArtistId)
);

CREATE TABLE Genre (
    GenreId INT PRIMARY KEY IDENTITY(1,1),
    GenreName NVARCHAR(100)
);

CREATE TABLE Track (
    TrackId INT PRIMARY KEY IDENTITY(1,1),
    TrackName NVARCHAR(100),
    TrackDuration TIME,
    TrackPopularity INT,
    TrackNumber INT,        
    AlbumId INT,
    FOREIGN KEY (AlbumId) REFERENCES Album(AlbumId)
);

CREATE TABLE Artist_Track (
    ArtistId INT,
    TrackId INT,
    PRIMARY KEY (ArtistId, TrackId),
    FOREIGN KEY (ArtistId) REFERENCES Artist(ArtistId),
    FOREIGN KEY (TrackId) REFERENCES Track(TrackId)
);
create table top50 (
    Id INT,
    TrackName NVARCHAR(100),
    ArtistName NVARCHAR(100),
    Genre NVARCHAR(100),
    BeatsPerMinute INT,
    Energy INT,
    Danceability INT,
    LoudnessDB INT,
    Liveness INT,
    Valence INT,
    Length INT,
    Acoustics INT,
    Speech INT,
    Popularity INT
);

select * from top50;
INSERT INTO top50 (
    Id,
    TrackName,
    ArtistName,
    Genre,
    BeatsPerMinute,
    Energy,
    Danceability,
    LoudnessDB,
    Liveness,
    Valence,
    Length,
    Acoustics,
    Speech,
    Popularity) 
VALUES
    (1, 'Señorita', 'Shawn Mendes', 'canadian pop', 117, 55, 76, -6, 8, 75, 191, 4, 3, 79),
    (2, 'China', 'Anuel AA', 'reggaeton flow', 105, 81, 79, -4, 8, 61, 302, 8, 9, 92),
    (3, 'boyfriend (with Social House)', 'Ariana Grande', 'dance pop', 190, 80, 40, -4, 16, 70, 186, 12, 46, 85),
    (4, 'Beautiful People (feat. Khalid)', 'Ed Sheeran', 'pop', 93, 65, 64, -8, 8, 55, 198, 12, 19, 86),
    (5, 'Goodbyes (Feat. Young Thug)', 'Post Malone', 'dfw rap', 150, 65, 58, -4, 11, 18, 175, 45, 7, 94),
    (6, 'I Don''t Care (with Justin Bieber)', 'Ed Sheeran', 'pop', 102, 68, 80, -5, 9, 84, 220, 9, 4, 84),
    (7, 'Ransom', 'Lil Tecca', 'trap music', 180, 64, 75, -6, 7, 23, 131, 2, 29, 92),
    (8, 'How Do You Sleep?', 'Sam Smith', 'pop', 111, 68, 48, -5, 8, 35, 202, 15, 9, 90),
    (9, 'Old Town Road - Remix', 'Lil Nas X', 'country rap', 136, 62, 88, -6, 11, 64, 157, 5, 10, 87),
    (10, 'bad guy', 'Billie Eilish', 'electropop', 135, 43, 70, -11, 10, 56, 194, 33, 38, 95),
    (11, 'Callaita', 'Bad Bunny', 'reggaeton', 176, 62, 61, -5, 24, 24, 251, 60, 31, 93),
    (12, 'Loco Contigo (feat. J. Balvin & Tyga)', 'DJ Snake', 'dance pop', 96, 71, 82, -4, 15, 38, 185, 28, 7, 86),
    (13, 'Someone You Loved', 'Lewis Capaldi', 'pop', 110, 41, 50, -6, 11, 45, 182, 75, 3, 88),
    (14, 'Otro Trago - Remix', 'Sech', 'panamanian pop', 176, 79, 73, -2, 6, 76, 288, 7, 20, 87),
    (15, 'Money In The Grave (Drake ft. Rick Ross)', 'Drake', 'canadian hip hop', 101, 50, 83, -4, 12, 10, 205, 10, 5, 92),
    (16, 'No Guidance (feat. Drake)', 'Chris Brown', 'dance pop', 93, 45, 70, -7, 16, 14, 261, 12, 15, 82),
    (17, 'LA CANCIÓN', 'J Balvin', 'latin', 176, 65, 75, -6, 11, 43, 243, 15, 32, 90),
    (18, 'Sunflower - Spider-Man: Into the Spider-Verse', 'Post Malone', 'dfw rap', 90, 48, 76, -6, 7, 91, 158, 56, 5, 91),
    (19, 'Lalala', 'Y2K', 'canadian hip hop', 130, 39, 84, -8, 14, 50, 161, 18, 8, 88),
    (20, 'Truth Hurts', 'Lizzo', 'escape room', 158, 62, 72, -3, 12, 41, 173, 11, 11, 91),
    (21, 'Piece Of Your Heart', 'MEDUZA', 'pop house', 124, 74, 68, -7, 7, 63, 153, 4, 3, 91),
    (22, 'Panini', 'Lil Nas X', 'country rap', 154, 59, 70, -6, 12, 48, 115, 34, 8, 91),
    (23, 'No Me Conoce - Remix', 'Jhay Cortez', 'reggaeton flow', 92, 79, 81, -4, 9, 58, 309, 14, 7, 83),
    (24, 'Soltera - Remix', 'Lunay', 'latin', 92, 78, 80, -4, 44, 80, 266, 36, 4, 91),
    (25, 'bad guy (with Justin Bieber)', 'Billie Eilish', 'electropop', 135, 45, 67, -11, 12, 68, 195, 25, 30, 89),
    (26, 'If I Can''t Have You', 'Shawn Mendes', 'canadian pop', 124, 82, 69, -4, 13, 87, 191, 49, 6, 70),
    (27, 'Dance Monkey', 'Tones and I', 'australian pop', 98, 59, 82, -6, 18, 54, 210, 69, 10, 83),
    (28, 'It''s You', 'Ali Gatie', 'canadian hip hop', 96, 46, 73, -7, 19, 40, 213, 37, 3, 89),
    (29, 'Con Calma', 'Daddy Yankee', 'latin', 94, 86, 74, -3, 6, 66, 193, 11, 6, 91),
    (30, 'QUE PRETENDES', 'J Balvin', 'latin', 93, 79, 64, -4, 36, 94, 222, 3, 25, 89),
    (31, 'Takeaway', 'The Chainsmokers', 'edm', 85, 51, 29, -8, 10, 36, 210, 12, 4, 84),
    (32, '7 rings', 'Ariana Grande', 'dance pop', 140, 32, 78, -11, 9, 33, 179, 59, 33, 89),
    (33, '0.958333333', 'Maluma', 'reggaeton', 96, 71, 78, -5, 9, 68, 176, 22, 28, 89),
    (34, 'The London (feat. J. Cole & Travis Scott)', 'Young Thug', 'atl hip hop', 98, 59, 80, -7, 13, 18, 200, 2, 15, 89),
    (35, 'Never Really Over', 'Katy Perry', 'dance pop', 100, 88, 77, -5, 32, 39, 224, 19, 6, 89),
    (36, 'Summer Days (feat. Macklemore & Patrick Stump of Fall Out Boy)', 'Martin Garrix', 'big room', 114, 72, 66, -7, 14, 32, 164, 18, 6, 89),
    (37, 'Otro Trago', 'Sech', 'panamanian pop', 176, 70, 75, -5, 11, 62, 226, 14, 34, 91),
    (38, 'Antisocial (with Travis Scott)', 'Ed Sheeran', 'pop', 152, 82, 72, -5, 36, 91, 162, 13, 5, 87),
    (39, 'Sucker', 'Jonas Brothers', 'boy band', 138, 73, 84, -5, 11, 95, 181, 4, 6, 80),
    (40, 'fuck, i''m lonely (with Anne-Marie) - from “13 Reasons Why: Season 3”', 'Lauv', 'dance pop', 95, 56, 81, -6, 6, 68, 199, 48, 7, 78),
    (41, 'Higher Love', 'Kygo', 'edm', 104, 68, 69, -7, 10, 40, 228, 2, 3, 88),
    (42, 'You Need To Calm Down', 'Taylor Swift', 'dance pop', 85, 68, 77, -6, 7, 73, 171, 1, 5, 90),
    (43, 'Shallow', 'Lady Gaga', 'dance pop', 96, 39, 57, -6, 23, 32, 216, 37, 3, 87),
    (44, 'Talk', 'Khalid', 'pop', 136, 40, 90, -9, 6, 35, 198, 5, 13, 84),
    (45, 'Con Altura', 'ROSALÍA', 'r&b en espanol', 98, 69, 88, -4, 5, 75, 162, 39, 12, 88),
    (46, 'One Thing Right', 'Marshmello', 'brostep', 88, 62, 66, -2, 58, 44, 182, 7, 5, 88),
    (47, 'Te Robaré', 'Nicky Jam', 'latin', 176, 75, 67, -4, 8, 80, 202, 24, 6, 88),
    (48, 'Happier', 'Marshmello', 'brostep', 100, 79, 69, -3, 17, 67, 214, 19, 5, 88),
    (49, 'Call You Mine', 'The Chainsmokers', 'edm', 104, 70, 59, -6, 41, 50, 218, 23, 3, 88),
    (50, 'Cross Me (feat. Chance the Rapper & PnB Rock)', 'Ed Sheeran', 'pop', 95, 79, 75, -6, 7, 61, 206, 21, 12, 82);

    select * from top50;

INSERT INTO Artist (ArtistName)
SELECT DISTINCT ArtistName
FROM top50;

INSERT INTO Genre (GenreName)
SELECT DISTINCT Genre
FROM top50;

INSERT INTO Album (AlbumName, ReleaseDate, TotalTracks, AlbumDuration, ArtistId)
SELECT DISTINCT 'Unknown Album', '2000-01-01', 1, '00:03:00', A.ArtistId
FROM top50 AS T
JOIN Artist AS A ON T.ArtistName = A.ArtistName;

INSERT INTO Track (TrackName, TrackDuration, TrackPopularity, TrackNumber, AlbumId)
SELECT T.TrackName, 
       CAST(DATEADD(SECOND, T.Length, '00:00:00') AS TIME), 
       T.Popularity, 
       1, 
       AL.AlbumId
FROM top50 AS T
JOIN Artist AS A ON T.ArtistName = A.ArtistName
JOIN Album AS AL ON AL.ArtistId = A.ArtistId;


INSERT INTO Artist_Track (ArtistId, TrackId)
SELECT A.ArtistId, TR.TrackId
FROM top50 AS T
JOIN Artist AS A ON T.ArtistName = A.ArtistName
JOIN Track AS TR ON TR.TrackName = T.TrackName;

SELECT 
    ROW_NUMBER() OVER (ORDER BY T.TrackId) AS Id,
    T.TrackName,
    A.ArtistName,
    DATEDIFF(SECOND, '00:00:00', T.TrackDuration) AS Length,
    T.TrackPopularity
FROM Track AS T
JOIN Album AS AL ON T.AlbumId = AL.AlbumId
JOIN Artist AS A ON AL.ArtistId = A.ArtistId
JOIN Artist_Track AS AT ON A.ArtistId = AT.ArtistId AND T.TrackId = AT.TrackId
ORDER BY Id;


SELECT 
    ROW_NUMBER() OVER (ORDER BY T.TrackId) AS Id,
    T.TrackName,
    A.ArtistName,
    DATEDIFF(SECOND, '00:00:00', T.TrackDuration) AS Length,
    T.TrackPopularity
FROM Track AS T
JOIN Album AS AL ON T.AlbumId = AL.AlbumId
JOIN Artist AS A ON AL.ArtistId = A.ArtistId
JOIN Artist_Track AS AT ON A.ArtistId = AT.ArtistId AND T.TrackId = AT.TrackId
ORDER BY Id;


SELECT ROW_NUMBER() OVER (ORDER BY T.TrackId) AS Id, 
T.TrackName, A.ArtistName, DATEDIFF(SECOND, '00:00:00', T.TrackDuration) AS Length,T.TrackPopularity 
FROM Track AS T 
JOIN Album AS AL ON T.AlbumId = AL.AlbumId 
JOIN Artist AS A ON AL.ArtistId = A.ArtistId 
JOIN Artist_Track AS AT ON A.ArtistId = AT.ArtistId AND 
T.TrackId = AT.TrackId ORDER BY Id;

select* from Album;

ALTER TABLE Album
ALTER COLUMN AlbumDuration INT;

ALTER TABLE Track
ALTER COLUMN TrackDuration INT;

Select * from Track;

SELECT
    T.TrackName,
    A.ArtistName,
    T.TrackDuration AS Length,
    T.TrackPopularity AS Popularity,
    AL.AlbumName,
    AL.ReleaseDate,
    AL.TotalTracks,
    T.TrackNumber
FROM
    Track T
INNER JOIN Album AL ON T.AlbumId = AL.AlbumId
INNER JOIN Artist_Track AT ON T.TrackId = AT.TrackId
INNER JOIN Artist A ON AT.ArtistId = A.ArtistId
WHERE
    T.TrackId = 56;

-- Insert into Artist table
DECLARE @NewArtistId INT;

INSERT INTO Artist (ArtistName)
VALUES ('sajith');

SET @NewArtistId = SCOPE_IDENTITY();

-- Insert into Album table
DECLARE @NewAlbumId INT;

INSERT INTO Album (AlbumName, ReleaseDate, TotalTracks, AlbumDuration, ArtistId)
VALUES('Sample', '2000-01-01', 5, '00:03:11', @NewArtistId);

SET @NewAlbumId = SCOPE_IDENTITY();

-- Insert into Track table
DECLARE @NewTrackId INT;

INSERT INTO Track (TrackName, TrackDuration, TrackPopularity, TrackNumber, AlbumId)
VALUES ('sample', '00:03:11', 80, 8, @NewAlbumId);

SET @NewTrackId = SCOPE_IDENTITY();


-- Insert into Artist_Track table
INSERT INTO Artist_Track (ArtistId, TrackId)
VALUES (@NewArtistId, @NewTrackId);





-- Update Track table
UPDATE Track
SET
    TrackName = 'ddasd',
    TrackDuration = '00:03:11',
    TrackPopularity = 80,
    TrackNumber = 5
WHERE
    TrackId = 51;

-- Update Album table
UPDATE Album
SET
    AlbumName = 'sams,',
    ReleaseDate = '2000-01-01',
    TotalTracks = 8
WHERE
    AlbumId = (
        SELECT AlbumId
        FROM Track
        WHERE TrackId = 51
    );

-- Update Artist table
UPDATE Artist
SET
    ArtistName = 'Saaa'
WHERE
    ArtistId = (
        SELECT ArtistId
        FROM Artist_Track
        WHERE TrackId = 51
    );

ALTER TABLE Track
ALTER COLUMN TrackDuration varchar(8);

SELECT COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Album' AND COLUMN_NAME = 'AlbumDuration';


SELECT COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Track' AND COLUMN_NAME = 'TrackDuration';

ALTER TABLE Album
ALTER COLUMN AlbumDuration varchar(500);

select * from Track;

-- to view selected columns based on track-Id
SELECT
    T.TrackName,
    A.ArtistName,
    T.TrackDuration AS Length,
    T.TrackPopularity AS Popularity,
    AL.AlbumName,
    AL.ReleaseDate,
    AL.TotalTracks,
    T.TrackNumber
FROM
    Track T
INNER JOIN Album AL ON T.AlbumId = AL.AlbumId
INNER JOIN Artist_Track AT ON T.TrackId = AT.TrackId
INNER JOIN Artist A ON AT.ArtistId = A.ArtistId
WHERE
    T.TrackId = 56;


-- Declare a variable to store the TrackId you want to delete
DECLARE @TrackIdToDelete INT;
SET @TrackIdToDelete = 58; -- Replace 1 with the desired TrackId

-- Delete from Artist_Track table
DELETE FROM Artist_Track
WHERE TrackId = @TrackIdToDelete;

-- Delete from Track table
DELETE FROM Track
WHERE TrackId = @TrackIdToDelete;

-- Delete Albums that are no longer related to any tracks
DELETE FROM Album
WHERE AlbumId NOT IN (SELECT DISTINCT AlbumId FROM Track);

-- Delete Artists that are no longer related to any tracks or albums
DELETE FROM Artist
WHERE ArtistId NOT IN (SELECT DISTINCT ArtistId FROM Album)
AND ArtistId NOT IN (SELECT DISTINCT ArtistId FROM Artist_Track);
