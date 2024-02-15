-- Schema Creation
create database online_music_streaming_application;
use online_music_streaming_application;

-- Table Creation

create table SUBSCRIPTION_PLAN(
	Subscription_ID varchar(10) not null,
    Subscription_name varchar(20) not null,
    Duration time not null,
    Price decimal,
	primary key(Subscription_ID)
);

create table USER_TABLE(
	User_ID varchar(10) not null,
    User_name varchar(50) not null,
    Email varchar(50) not null,
    Continent varchar(20) not null,
    Country varchar(20) not null,
    State varchar(20),
    Image varchar(50),
    Follower_count int,
    Following_count int,
    Birthday date not null,
    Subscription_plan varchar(50),
    primary key(User_ID),
    constraint  fk_user_subscription Foreign key(Subscription_plan) references SUBSCRIPTION_PLAN(Subscription_ID) on delete set null on update cascade
);

create table PLAYLIST(
	Playlist_ID varchar(10) not null,
    Playlist_name varchar(50) not null,
    Duration time not null,
    Created_date date not null,
    Creator varchar(10),
    primary key(Playlist_ID),
    constraint  fk_playlist_creator Foreign key(Creator) references USER_TABLE(User_ID) on delete set null on update cascade
);

create table GENRE(
	Genre_ID varchar(10) not null,
    Genre_type varchar(20) not null,
    Genre_description varchar(300),
    primary key(Genre_ID)
);

create table ARTIST(
	Artist_ID varchar(10) not null,
    Artist_name varchar(50) not null,
    Email varchar(50) not null,
    Image varchar(50),
    Follower_count int,
    primary key(Artist_ID)
);

create table ALBUM(
	Album_ID varchar(10) not null,
    Album_name varchar(20) not null,
    Image varchar(50),
    Genre varchar(10),
    Artist varchar(10),
    primary key(Album_ID),
    constraint  fk_album_genre Foreign key(Genre) references GENRE(Genre_ID) on delete set null on update cascade,
    constraint  fk_album_artist Foreign key(Artist) references ARTIST(Artist_ID) on delete set null on update cascade
);

create table TRACK(
	Track_ID varchar(10) not null,
    Track_name varchar(50) not null,
    Lyrics varchar(10000) not null,
    Duration time not null,
    Release_date date not null,
    Image varchar(50),
    Artist varchar(20),
    Album varchar(20),
    Genre varchar(10),
    primary key(Track_ID),
    constraint  fk_track_artist Foreign key(Artist) references ARTIST(Artist_ID) on delete set null on update cascade,
    constraint  fk_track_album Foreign key(Album) references ALBUM(Album_ID) on delete set null on update cascade,
    constraint  fk_track_genre Foreign key(Genre) references GENRE(Genre_ID) on delete set null on update cascade
);


create table PLAYLIST_TRACK(
	Playlist_ID varchar(10) not null,
    Track varchar(10) not null,
    primary key(Playlist_ID,Track),
    constraint  fk_playlist Foreign key(Playlist_ID) references PLAYLIST(Playlist_ID) on delete cascade on update cascade,
    constraint  fk_track Foreign key(Track) references TRACK(Track_ID) on delete cascade on update cascade
);

create table ALBUM_TRACK(
	Album_ID varchar(10) not null,
    Track varchar(10) not null,
    primary key(Album_ID,Track),
    constraint  fk_album_track Foreign key(Album_ID) references ALBUM(Album_ID) on delete cascade on update cascade,
    constraint  fk_include_track Foreign key(Track) references TRACK(Track_ID) on delete cascade on update cascade
);

create table ALBUM_ARTIST(
	Album_ID varchar(10) not null,
    Artist varchar(10) not null,
    Co_Artist varchar(10),
    primary key(Album_ID,Artist),
    constraint  fk_album_owner Foreign key(Album_ID) references ALBUM(Album_ID) on delete cascade on update cascade,
    constraint  fk_artist Foreign key(Artist) references ARTIST(Artist_ID) on delete cascade on update cascade
);

create table ARTIST_ALBUM(
	Artist_ID varchar(10) not null,
    Album varchar(10) not null,
    primary key(Artist_ID,Album),
    constraint  fk_artist_album Foreign key(Artist_ID) references ARTIST(Artist_ID) on delete cascade on update cascade,
    constraint  fk_album Foreign key(Album) references ALBUM(Album_ID) on delete cascade on update cascade
);

create table FAVOURITE(
	User_ID varchar(10) not null,
    Track varchar(10) not null,
    Date_added datetime not null,
    primary key(User_ID,Track),
    constraint  fk_owner Foreign key(User_ID) references USER_TABLE(User_ID) on delete cascade on update cascade,
    constraint  fk_fav_track Foreign key(Track) references TRACK(Track_ID) on delete cascade on update cascade
);


create table TRACK_ARTIST(
	Track_ID varchar(10) not null,
    Artist varchar(10) not null,
    Co_artist varchar(10),
    primary key(Track_ID,Artist),
    constraint  fk_t Foreign key(Track_ID) references TRACK(Track_ID) on delete cascade on update cascade,
    constraint  fk_a Foreign key(Artist) references ARTIST(Artist_ID) on delete cascade on update cascade
);


create table USER_DEVICE(
	User_ID varchar(10) not null,
    Device_name varchar(30) not null,
    Device_type varchar(20) not null,
    primary key(User_ID,Device_name),
    constraint  fk_owner_user Foreign key(User_ID) references USER_TABLE(User_ID) on delete cascade on update cascade
);

create table ARTIST_DEVICE(
	Artist_ID varchar(10) not null,
    Device_name varchar(30) not null,
    Device_type varchar(20) not null,
    primary key(Artist_ID,Device_name),
    constraint  fk_owner_artist Foreign key(Artist_ID) references ARTIST(Artist_ID) on delete cascade on update cascade
);

create table USER_FOLLOWERS(
	User_ID varchar(10) not null,
    Follower varchar(10) not null,
	primary key(User_ID,Follower),
    constraint  fk_ud1 Foreign key(User_ID) references USER_TABLE(User_ID) on delete cascade on update cascade,
    constraint  fk_ufollower Foreign key(Follower) references USER_TABLE(User_ID) on delete cascade on update cascade
);

create table USER_FOLLOWING_USER(
	User_ID varchar(10) not null,
    Following_user varchar(10) not null,
	primary key(User_ID,Following_user),
    constraint  fk_ud2 Foreign key(User_ID) references USER_TABLE(User_ID) on delete cascade on update cascade,
    constraint  fk_ufollowing Foreign key(Following_user) references USER_TABLE(User_ID) on delete cascade on update cascade
);


create table USER_FOLLOWING_ARTIST(
	User_ID varchar(10) not null,
    Following_artist varchar(10) not null,
	primary key(User_ID,Following_artist),
    constraint  fk_ud3 Foreign key(User_ID) references USER_TABLE(User_ID) on delete cascade on update cascade,
    constraint  fk_ufartist Foreign key(Following_artist) references ARTIST(Artist_ID) on delete cascade on update cascade
);

create table ARTIST_FOLLOWERS(
	Artist_ID varchar(10) not null,
    Follower varchar(10) not null,
	primary key(Artist_ID,Follower),
    constraint  fk_art Foreign key(Artist_ID) references ARTIST(Artist_ID) on delete cascade on update cascade,
    constraint  fk_artfollower Foreign key(Follower) references USER_TABLE(User_ID) on delete cascade on update cascade
);

create table SUBSCRIPTION_PLAN_FEATURES(
	Subscription_ID varchar(10) not null,
    Feature varchar(50) not null,
	primary key(Subscription_ID,Feature),
    constraint  fk_subs Foreign key(Subscription_ID) references SUBSCRIPTION_PLAN(Subscription_ID) on delete cascade on update cascade
);


-- Data Insertion

INSERT INTO SUBSCRIPTION_PLAN 
VALUES ('6001', 'Free',  '730:00:00', 0.00 );
INSERT INTO SUBSCRIPTION_PLAN 
VALUES ('6002', 'Premium',  '730:00:00', 9.99 );
INSERT INTO SUBSCRIPTION_PLAN 
VALUES ('6003', 'Family',  '730:00:00', 14.99 );
INSERT INTO SUBSCRIPTION_PLAN 
VALUES ('6004', 'Student',  '730:00:00', 4.99 );
INSERT INTO SUBSCRIPTION_PLAN 
VALUES ('6005', 'Annual',  '730:00:00', 99.99 );
INSERT INTO SUBSCRIPTION_PLAN 
VALUES ('6006', 'Ultimate',  '730:00:00', 19.99 );
INSERT INTO SUBSCRIPTION_PLAN 
VALUES ('6007', 'Pro Ultimate',  '730:00:00', 199.99 );

INSERT INTO USER_TABLE 
VALUES ('1001', 'john_doe',  'john.doe@123.com', 'North America', 'United States', 'California', 'https://example.com/johndoe.jpg', '0', '250', '1990-03-15', '6001' );
INSERT INTO USER_TABLE 
VALUES ('1002', 'sarah_smith',  'sarah.smith@123.com', 'North America', 'Canada', 'Ontario', 'https://example.com/sarahsmith.jpg', '0', '500', '1985-08-22', '6002' );
INSERT INTO USER_TABLE 
VALUES ('1003', 'emma_jones',  'emma.jones@123.com', 'Europe', 'United Kingdom', 'England', 'https://images.com/emmajones.jpg', '1', '750', '1995-01-10', '6001' );
INSERT INTO USER_TABLE 
VALUES ('1004', 'chris_wilson',  'chris.wilson@123.com', 'Australia', 'Australia', 'New South Wales', 'https://images.com/chriswilson.jpg', '1', '300', '1988-11-05', '6003' );
INSERT INTO USER_TABLE 
VALUES ('1005', 'maria_rodriguez',  'maria.rodriguez@123.com', 'Europe', 'Spain', 'Madrid', 'https://images.com/mariarodriguez.jpg', '3', '475', '1992-06-30', '6002' );
INSERT INTO USER_TABLE 
VALUES ('1006', 'lisa_wang',  ' lisa.wang@123.com', 'Asia', 'China', 'Beijing', 'https://images.com/lisawang.jpg', '0', '537', '1993-04-25', '6004' );
INSERT INTO USER_TABLE 
VALUES ('1007', 'mira_clark',  ' mira.clark@333.com', 'Asia', 'Australia', 'Melbourne', 'https://images.com/miraclark.jpg', '1', '57', '2000-04-25', '6004' );

INSERT INTO PLAYLIST 
VALUES ('7001', 'Rock Classics', '03:30:00', '2023-08-15', '1001');
INSERT INTO PLAYLIST 
VALUES ('7002', 'Chill Vibes', '02:15:00', '2023-08-20', '1002');
INSERT INTO PLAYLIST 
VALUES ('7003', 'Top Hits', '03:45:00', '2023-07-25', '1003');
INSERT INTO PLAYLIST 
VALUES ('7004', 'Classic Pop', '02:30:00', '2023-07-25', '1004');
INSERT INTO PLAYLIST 
VALUES ('7005', 'Epic Rock', '04:15:00', '2022-05-01', '1005');
INSERT INTO PLAYLIST 
VALUES ('7006', '80s Classics', '04:00:00', '2018-10-15', '1006');
INSERT INTO PLAYLIST 
VALUES ('7007', 'Romantic', '03:30:00', '2019-11-25', '1007');

INSERT INTO GENRE 
VALUES ('5001', 'Rock', 'A genre that encompasses a wide range of rock and roll styles');
INSERT INTO GENRE 
VALUES ('5002', 'Pop', 'Popular music characterized by catchy melodies and relatable lyrics');
INSERT INTO GENRE 
VALUES ('5003', 'Classic Rock', 'Timeless rock music from the 1960s and 1970s');
INSERT INTO GENRE 
VALUES ('5004', 'Hip-Hop', 'A genre of music characterized by rap and urban culture influences');
INSERT INTO GENRE 
VALUES ('5005', 'Pop Rock', 'A fusion of pop and rock elements, creating catchy tunes');
INSERT INTO GENRE 
VALUES ('5006', 'Electronic', 'A genre characterized by synthesized sounds and electronic beats, popular in dance and EDM music');
INSERT INTO GENRE 
VALUES ('5007', 'EDM Rock', 'A genre characterized by EDM music with combination of Rock');

INSERT INTO ARTIST
VALUES ('4001', 'Queen', 'queen@gmail.com', 'https://images.com/artists/queen.jpg', '500000');
INSERT INTO ARTIST
VALUES ('4002', 'John Lennon', 'john.lennon@gmail.com', 'https://images.com/artists/johnlennon.jpg', '250000');
INSERT INTO ARTIST
VALUES ('4003', 'Eagles', 'eagles@gmail.com', 'https://images.com/artists/eagles.jpg', '350000');
INSERT INTO ARTIST
VALUES ('4004', 'Ed Sheeran', 'edsheeran@gmail.com', 'https://images.com/artists/edsheeran.jpg', '1000000');
INSERT INTO ARTIST
VALUES ('4005', 'Mark Ronson', 'mark.ronson@gmail.com', 'https://images.com/artists/markronson.jpg', '750000');
INSERT INTO ARTIST
VALUES ('4006', 'Taylor Swift', 'taylor.swift@gmail.com', 'https://images.com/artists/taylorswift.jpg', '1500000');
INSERT INTO ARTIST
VALUES ('4007', 'Backstreet Boys', 'backstreet.boys@gmail.com', 'https://images.com/artists/backstreetboys.jpg', '5500000');

INSERT INTO ALBUM
VALUES ('2001', 'A Night at the Opera', 'https://images.com/albums/anightattheopera.jpg', '5001', '4001');
INSERT INTO ALBUM
VALUES ('2002', 'Imagine', 'https://images.com/albums/imagine.jpg', '5002', '4002');
INSERT INTO ALBUM
VALUES ('2003', 'Hotel California', 'https://images.com/albums/hotelcalifornia.jpg', '5001', '4003');
INSERT INTO ALBUM
VALUES ('2004', '÷ (Divide)', 'https://images.com/albums/divide.jpg', '5002', '4004');
INSERT INTO ALBUM
VALUES ('2005', 'Uptown Special', 'https://images.com/albums/uptownspecial.jpg', '5002', '4005');
INSERT INTO ALBUM
VALUES ('2006', 'Red', 'https://images.com/albums/red.jpg', '5002', '4006');
INSERT INTO ALBUM
VALUES ('2007', '1989', 'https://images.com/albums/1989.jpg', '5002', '4006');
INSERT INTO ALBUM
VALUES ('2008', 'As long as you', 'https://images.com/albums/aslove.jpg', '5007', '4007');

INSERT INTO TRACK
VALUES ('3001', 'Bohemian Rhapsody', 'Is this the real life? Is this just fantasy?...', '00:05:55', '1975-10-31', 'https://images.com/tracks/bohemianrhapsody.jpg', '4001', '2001', '5001');
INSERT INTO TRACK
VALUES ('3002', 'Imagine', 'Imagine there is no heaven, It is easy if you try..', '00:03:03', '1971-09-09', 'https://images.com/tracks/imagine.jpg', '4002', '2002', '5002');
INSERT INTO TRACK
VALUES ('3003', 'Hotel California', 'On a dark desert highway, cool wind in my hair...', '00:06:31', '1976-12-08', 'https://images.com/tracks/hotelcalifornia.jpg', '4003', '2003', '5001');
INSERT INTO TRACK
VALUES ('3004', 'Shape of You', 'The club isn t the best place to find a lover…', '00:03:53', '2017-01-06', 'https://images.com/tracks/shapeofyou.jpg', '4004', '2004', '5002');
INSERT INTO TRACK
VALUES ('3005', 'Uptown Funk', 'This hit, that ice-cold Michelle Pfeiffer...', '00:04:30', '2014-11-10', 'https://images.com/tracks/uptownfunk.jpg', '4005', '2005', '5002');
INSERT INTO TRACK
VALUES ('3006', 'Everything Has Changed', 'You good to go, and I m watching you...', '00:04:00', '2013-06-25', 'https://images.com/tracks/everythinghaschanged.jpg', '4006', '2006', '5002');
INSERT INTO TRACK
VALUES ('3007', 'Perfect', 'I found a love for me, darling just dive right in...', '00:04:30', '2017-03-03', 'https://images.com/tracks/perfect.jpg', '4004', '2004', '5002');
INSERT INTO TRACK
VALUES ('3008', 'Blank Space', 'Nice to meet you, where you been? I could show you incredible things...', '00:03:51', '2014-11-07', 'https://images.com/tracks/blankspace.jpg', '4006', '2007', '5002');
INSERT INTO TRACK
VALUES ('3009', 'as long as you', 'Although loneliness has always been a friend of mine...', '00:03:47', '2018-11-07', 'https://images.com/tracks/aslove.jpg', '4007', '2008', '5004');


INSERT INTO PLAYLIST_TRACK VALUES ('7001', '3001');
INSERT INTO PLAYLIST_TRACK VALUES ('7001', '3003');
INSERT INTO PLAYLIST_TRACK VALUES ('7002', '3002');
INSERT INTO PLAYLIST_TRACK VALUES ('7002', '3004');
INSERT INTO PLAYLIST_TRACK VALUES ('7003', '3005');
INSERT INTO PLAYLIST_TRACK VALUES ('7003', '3006');
INSERT INTO PLAYLIST_TRACK VALUES ('7004', '3002');
INSERT INTO PLAYLIST_TRACK VALUES ('7004', '3005');
INSERT INTO PLAYLIST_TRACK VALUES ('7005', '3003');
INSERT INTO PLAYLIST_TRACK VALUES ('7005', '3006');
INSERT INTO PLAYLIST_TRACK VALUES ('7006', '3001');
INSERT INTO PLAYLIST_TRACK VALUES ('7006', '3002');
INSERT INTO PLAYLIST_TRACK VALUES ('7007', '3006');

INSERT INTO ALBUM_TRACK VALUES ('2001', '3001');
INSERT INTO ALBUM_TRACK VALUES ('2002', '3002');
INSERT INTO ALBUM_TRACK VALUES ('2003', '3003');
INSERT INTO ALBUM_TRACK VALUES ('2004', '3004');
INSERT INTO ALBUM_TRACK VALUES ('2005', '3005');
INSERT INTO ALBUM_TRACK VALUES ('2006', '3006');
INSERT INTO ALBUM_TRACK VALUES ('2004', '3007');
INSERT INTO ALBUM_TRACK VALUES ('2007', '3008');
INSERT INTO ALBUM_TRACK VALUES ('2008', '3009');

INSERT INTO ALBUM_ARTIST VALUES ('2001', '4001', null);
INSERT INTO ALBUM_ARTIST VALUES ('2002', '4002', null);
INSERT INTO ALBUM_ARTIST VALUES ('2003', '4003', null);
INSERT INTO ALBUM_ARTIST VALUES ('2004', '4004', null);
INSERT INTO ALBUM_ARTIST VALUES ('2005', '4005', 'Bruno Mars');
INSERT INTO ALBUM_ARTIST VALUES ('2006', '4006', 'Ed Sheeran');
INSERT INTO ALBUM_ARTIST VALUES ('2007', '4006', null);
INSERT INTO ALBUM_ARTIST VALUES ('2008', '4007', 4002);

INSERT INTO ARTIST_ALBUM VALUES ('4001', '2001');
INSERT INTO ARTIST_ALBUM VALUES ('4002', '2002');
INSERT INTO ARTIST_ALBUM VALUES ('4003', '2003');
INSERT INTO ARTIST_ALBUM VALUES ('4004', '2004');
INSERT INTO ARTIST_ALBUM VALUES ('4005', '2005');
INSERT INTO ARTIST_ALBUM VALUES ('4006', '2006');
INSERT INTO ARTIST_ALBUM VALUES ('4006', '2007');
INSERT INTO ARTIST_ALBUM VALUES ('4007', '2008');

INSERT INTO FAVOURITE VALUES ('1001', '3001', '2023-08-10');
INSERT INTO FAVOURITE VALUES ('1002', '3003', '2022-07-14');
INSERT INTO FAVOURITE VALUES ('1003', '3004', '2023-11-13');
INSERT INTO FAVOURITE VALUES ('1004', '3004', '2019-08-24');
INSERT INTO FAVOURITE VALUES ('1005', '3005', '2020-03-09');
INSERT INTO FAVOURITE VALUES ('1005', '3006', '2021-05-10');
INSERT INTO FAVOURITE VALUES ('1006', '3002', '2023-05-10');

INSERT INTO TRACK_ARTIST VALUES ('3001', '4001', null);
INSERT INTO TRACK_ARTIST VALUES ('3002', '4002', null);
INSERT INTO TRACK_ARTIST VALUES ('3003', '4003', null);
INSERT INTO TRACK_ARTIST VALUES ('3004', '4004', null);
INSERT INTO TRACK_ARTIST VALUES ('3005', '4005', 'Bruno Mars');
INSERT INTO TRACK_ARTIST VALUES ('3006', '4006', 'Ed Sheeran');
INSERT INTO TRACK_ARTIST VALUES ('3007', '4004', null);
INSERT INTO TRACK_ARTIST VALUES ('3008', '4006', null);
INSERT INTO TRACK_ARTIST VALUES ('3009', '4007', null);

INSERT INTO USER_DEVICE VALUES ('1001', 'iPhone 12', 'Mobile');
INSERT INTO USER_DEVICE VALUES ('1002', 'Samsung Galaxy S21', 'Mobile');
INSERT INTO USER_DEVICE VALUES ('1002', 'MacBook Pro', 'Laptop');
INSERT INTO USER_DEVICE VALUES ('1004', 'iPad Pro', 'Tablet');
INSERT INTO USER_DEVICE VALUES ('1004', 'Samsung A12', 'Mobile');
INSERT INTO USER_DEVICE VALUES ('1005', 'Google Pixel 6', 'Mobile');
INSERT INTO USER_DEVICE VALUES ('1006', 'redmi12', 'Mobile');

INSERT INTO ARTIST_DEVICE VALUES ('4001', 'iPad Pro', 'Tablet');
INSERT INTO ARTIST_DEVICE VALUES ('4002', 'MacBook Pro', 'Laptop');
INSERT INTO ARTIST_DEVICE VALUES ('4003', 'Dell XPS 15', 'Laptop');
INSERT INTO ARTIST_DEVICE VALUES ('4003', 'Acer Aspire 5', 'Laptop');
INSERT INTO ARTIST_DEVICE VALUES ('4004', 'MacBook Pro', 'Laptop');
INSERT INTO ARTIST_DEVICE VALUES ('4005', 'Samsung Galaxy Tab S7', 'Tablet');
INSERT INTO ARTIST_DEVICE VALUES ('4006', 'redmi9', 'Tablet');

INSERT INTO USER_FOLLOWERS VALUES ('1003', '1004');
INSERT INTO USER_FOLLOWERS VALUES ('1004', '1001');
INSERT INTO USER_FOLLOWERS VALUES ('1005', '1001');
INSERT INTO USER_FOLLOWERS VALUES ('1005', '1002');
INSERT INTO USER_FOLLOWERS VALUES ('1005', '1003');
INSERT INTO USER_FOLLOWERS VALUES ('1006', '1001');
INSERT INTO USER_FOLLOWERS VALUES ('1007', '1003');

INSERT INTO USER_FOLLOWING_USER VALUES ('1001', '1004');
INSERT INTO USER_FOLLOWING_USER VALUES ('1001', '1005');
INSERT INTO USER_FOLLOWING_USER VALUES ('1001', '1006');
INSERT INTO USER_FOLLOWING_USER VALUES ('1002', '1005');
INSERT INTO USER_FOLLOWING_USER VALUES ('1003', '1005');
INSERT INTO USER_FOLLOWING_USER VALUES ('1004', '1003');
INSERT INTO USER_FOLLOWING_USER VALUES ('1004', '1002');

INSERT INTO USER_FOLLOWING_ARTIST VALUES ('1001', '4001');
INSERT INTO USER_FOLLOWING_ARTIST VALUES ('1001', '4002');
INSERT INTO USER_FOLLOWING_ARTIST VALUES ('1001', '4004');
INSERT INTO USER_FOLLOWING_ARTIST VALUES ('1003', '4004');
INSERT INTO USER_FOLLOWING_ARTIST VALUES ('1004', '4005');
INSERT INTO USER_FOLLOWING_ARTIST VALUES ('1005', '4006');
INSERT INTO USER_FOLLOWING_ARTIST VALUES ('1005', '4001');
INSERT INTO USER_FOLLOWING_ARTIST VALUES ('1005', '4007');

INSERT INTO ARTIST_FOLLOWERS VALUES ('4001', '1001');
INSERT INTO ARTIST_FOLLOWERS VALUES ('4002', '1001');
INSERT INTO ARTIST_FOLLOWERS VALUES ('4004', '1003');
INSERT INTO ARTIST_FOLLOWERS VALUES ('4005', '1003');
INSERT INTO ARTIST_FOLLOWERS VALUES ('4006', '1002');
INSERT INTO ARTIST_FOLLOWERS VALUES ('4006', '1005');
INSERT INTO ARTIST_FOLLOWERS VALUES ('4004', '1002');

INSERT INTO SUBSCRIPTION_PLAN_FEATURES VALUES ('6001', 'Ad-supported listening');
INSERT INTO SUBSCRIPTION_PLAN_FEATURES VALUES ('6001', 'Limited skips');
INSERT INTO SUBSCRIPTION_PLAN_FEATURES VALUES ('6001', 'Can play unlimited track');
INSERT INTO SUBSCRIPTION_PLAN_FEATURES VALUES ('6002', 'Ad-free listening');
INSERT INTO SUBSCRIPTION_PLAN_FEATURES VALUES ('6002', 'Can play unlimited track');
INSERT INTO SUBSCRIPTION_PLAN_FEATURES VALUES ('6002', 'Unlimited skips');
INSERT INTO SUBSCRIPTION_PLAN_FEATURES VALUES ('6003', 'Ad-free listening');
INSERT INTO SUBSCRIPTION_PLAN_FEATURES VALUES ('6003', 'Can play unlimited track');
INSERT INTO SUBSCRIPTION_PLAN_FEATURES VALUES ('6003', 'Up to 6 separate accounts for family members');
INSERT INTO SUBSCRIPTION_PLAN_FEATURES VALUES ('6004', 'Can play unlimited track');
INSERT INTO SUBSCRIPTION_PLAN_FEATURES VALUES ('6004', 'Limited skips');
INSERT INTO SUBSCRIPTION_PLAN_FEATURES VALUES ('6005', 'Can play unlimited track');
INSERT INTO SUBSCRIPTION_PLAN_FEATURES VALUES ('6006', 'Can play unlimited track');
INSERT INTO SUBSCRIPTION_PLAN_FEATURES VALUES ('6006', 'Ad-free listening');
INSERT INTO SUBSCRIPTION_PLAN_FEATURES VALUES ('6005', 'free netflix access');

-- Definitions

/*
SHOW CREATE TABLE album;
SHOW CREATE TABLE album_artist;
SHOW CREATE TABLE album_track;
SHOW CREATE TABLE artist;
SHOW CREATE TABLE artist_album;
SHOW CREATE TABLE artist_device;
SHOW CREATE TABLE artist_followers;
SHOW CREATE TABLE favourite;
SHOW CREATE TABLE genre;
SHOW CREATE TABLE playlist;	
SHOW CREATE TABLE playlist_track;
SHOW CREATE TABLE subscription_plan;
SHOW CREATE TABLE subscription_plan_features;
SHOW CREATE TABLE track;
SHOW CREATE TABLE track_artist;
SHOW CREATE TABLE user_device;
SHOW CREATE TABLE user_followers;
SHOW CREATE TABLE user_following_artist;
SHOW CREATE TABLE user_following_user;
SHOW CREATE TABLE user_table;
*/
-- Update Queries

-- select * from album;
Update album 
set Album_name =  "A evening at a Opera",
	Genre = '5004',
    Artist = '4001'
where Album_ID = '2001';

Update album 
set Album_name =  "sympony of sonatas",
	Genre = '5004'
where Album_ID = '2004';
-- select * from album;


-- select * from album_artist;
Update album_artist 
set Co_artist = '4001'
where (Album_ID = '2001' and Artist = '4003');

Update album_artist 
set Co_artist = '4003',
    Artist = '4004'
where Album_ID = '2003';
-- select * from album_artist;


-- select * from album_track;
Update album_track
set Track =  '3008'
where (Album_ID = '2004' and Track = '3007');

Update album_track
set Track =  '3007'
where (Album_ID = '2007' and Track = '3008');
-- select * from album_track;


-- select * from artist;
Update artist 
set Artist_name =  "john samson",
	Email = 'joghn@xyzsds'
where Artist_ID = '4003';

Update artist 
set Artist_name =  "mark perera",
	Email = 'anvfhc@sdsdsd',
    Follower_count = 2300
where Artist_ID = '4005';
-- select * from artist;


-- select * from ARTIST_ALBUM;
Update ARTIST_ALBUM
set Artist_ID =  '4004'
where (Artist_ID = '4003' and Album = '2003') ;

Update ARTIST_ALBUM
set Artist_ID =  '4005'
where (Artist_ID = '4006' and Album = '2006') ;
-- select * from ARTIST_ALBUM;


-- select * from artist_device;
Update artist_device
set Device_name =  'iPad Pro max'
where (Artist_ID = '4001' and Device_name = 'iPad Pro') ;

Update artist_device
set Device_name =  'MacBook Pro max'
where (Artist_ID = '4002' and Device_name = 'MacBook Pro') ;
-- select * from artist_device;


-- select * from ARTIST_FOLLOWERS;
Update ARTIST_FOLLOWERS
set Follower =  '1005'
where (Artist_ID = '4005' and Follower = '1003') ;

Update ARTIST_FOLLOWERS
set Follower =  '1004'
where (Artist_ID = '4002' and Follower = '1001');
-- select * from ARTIST_FOLLOWERS;


-- select * from favourite;
Update favourite
set Track =  '3002'
where (User_ID = '1002' and Track = '3003');

Update favourite
set Date_added =  '2023-11-15 08:00:00'
where (User_ID = '1003' and Track = '3004');
-- select * from favourite;

-- select * from genre;
Update genre
set Genre_type =  'Dance-Rock',
	Genre_description = 'a genre that blends rock and electronic dance music (EDM) elements'
where Genre_ID = '5005';

Update genre
set Genre_type =  'Folk-Rock',
	Genre_description = 'a genre that blends the folk music with rock and roll'
where Genre_ID = '5003';
-- select * from genre;


-- select * from PLAYLIST;
Update PLAYLIST
set Playlist_name =  'Dance-Pop'
where Playlist_ID = '7004';

Update PLAYLIST
set Created_date =  '2022-05-11'
where Playlist_ID = '7005';
-- select * from PLAYLIST;

-- select * from PLAYLIST_TRACK;
Update PLAYLIST_TRACK
set Track =  '3007'
where (Playlist_ID = '7005' and Track = '3003');

Update PLAYLIST_TRACK
set Track =  '3005'
where (Playlist_ID = '7002' and Track = '3002');
-- select * from PLAYLIST_TRACK;


-- select * from SUBSCRIPTION_PLAN;
Update SUBSCRIPTION_PLAN
set Duration =  '740:00:00'
where Subscription_ID = '6003';

Update SUBSCRIPTION_PLAN
set Price =  '15'
where Subscription_ID = '6002';
-- select * from SUBSCRIPTION_PLAN;


-- select * from SUBSCRIPTION_PLAN_FEATURES;
Update SUBSCRIPTION_PLAN_FEATURES
set Feature =  'Limited skips'
where (Subscription_ID = '6001' and Feature = 'no skips');

Update SUBSCRIPTION_PLAN_FEATURES
set Feature =  'Up to 7 separate accounts for family members'
where (Subscription_ID = '6003' and Feature = 'Up to 6 separate accounts for family members');

Update TRACK
set Duration  =  '00:06:41'
where Track_ID = '3003';

Update TRACK
set Release_date  =  '2017-05-06'
where Track_ID = '3004';

Update TRACK_ARTIST
set Co_artist =  'Jim Brown'
where (Track_ID = '3001' and Artist = '4001');

Update TRACK_ARTIST
set Co_artist =  'Katy Perry'
where (Track_ID = '3008' and Artist = '4006');

Update USER_DEVICE
set Device_name =  'Samsung Galaxy Note12'
where (User_ID = '1002' and Device_name = 'Samsung Galaxy S21');

Update USER_DEVICE
set Device_name =  'iPhone 11 max'
where (User_ID = '1001' and Device_name = 'iPhone 12');



Update USER_FOLLOWERS
set Follower =  '1004'
where (User_ID = '1005' and Follower = '1002');

Update USER_FOLLOWERS
set Follower =  '1002'
where (User_ID = '1006' and Follower = '1001');

Update USER_FOLLOWING_ARTIST
set Following_artist =  '4003'
where (User_ID = '1001' and Following_artist = '4002');

Update USER_FOLLOWING_ARTIST
set User_ID =  '1002'
where (User_ID = '1001' and Following_artist = '4004');

Update USER_FOLLOWING_USER
set Following_user =  '1001',
	User_ID = '1006'
where (User_ID = '1001' and Following_user = '1006');

Update USER_FOLLOWING_USER
set Following_user =  '1006'
where (User_ID = '1002' and Following_user = '1005');

Update USER_FOLLOWING_USER
set User_ID =  '1004'
where (User_ID = '1003' and Following_user = '1005');

Update USER_TABLE
set User_name =  "sarah_jane",
	Email = 'sarah.jane@gmail.com',
    Image = 'https://example.com/sarahjane.jpg'
where User_ID = '1002';

Update USER_TABLE
set Subscription_plan =  "6003"
where User_ID = '1003';



-- Delete Queries


Delete from album
where Album_ID = "2008";



Delete from album_artist
where Album_ID = "2007" and artist ="4006";



Delete from album_track
where (Album_ID = '2004' and Track = '3008');



Delete from artist
where Artist_ID = '4007';

Delete from ARTIST_ALBUM
where Artist_ID = '4005' and Album = '2006';


Delete from artist_device
where (Artist_ID = '4006' and Device_name = 'redmi9') ;


Delete from ARTIST_FOLLOWERS
where (Artist_ID = '4004' and Follower = '1002');


Delete from favourite
where User_ID = '1006' and Track = '3002';

Delete from genre
where Genre_ID = '5007';


Delete from PLAYLIST
where Playlist_ID = '7007';


Delete from PLAYLIST_TRACK
where (Playlist_ID = '7005' and Track = '3007');



Delete from SUBSCRIPTION_PLAN
where Subscription_ID = '6007';



Delete from SUBSCRIPTION_PLAN_FEATURES
where (Subscription_ID = '6005' and Feature = 'free netflix access');



Delete from track
where track_ID = "3009";



Delete from TRACK_ARTIST
where (Track_ID = '3008' and Artist = '4006');



Delete from USER_DEVICE
where (User_ID = '1006' and Device_name = 'redmi12');



Delete from USER_FOLLOWERS
where (User_ID = '1007' and Follower = '1003');


Delete from USER_FOLLOWING_ARTIST
where (User_ID = '1005' and Following_artist = '4006');



Delete from USER_FOLLOWING_USER
where (User_ID = '1004' and Following_user = '1002');



Delete from USER_TABLE
where User_ID = '1007';


-- Simple Queries


-- select
select * from genre;
Select * from track Where Artist = "4001";

-- project
select Artist_ID,Artist_name,Email from ARTIST;

#cartesian product
select * from artist cross join album;

-- user view
create view uv1 as select track_id,track_name,Genre from track where genre = '5001';
create view uv2 as select t.track_id,t.track_name from track as t inner join album as a
on t.album = a.album_id where t.Genre = '5001';
-- select * from uv1;
-- select * from uv2;
drop view uv1;
drop view uv2;

-- rename
Rename table favourite to user_favourite;
-- select * from subscription_plan;
Alter table subscription_plan
Rename column subscription_name to subscription_package; 
-- select * from subscription_plan;

-- aggregation function
select genre, count(genre) as track_count from track
group by genre;
select artist_id,artist_name, max(follower_count) as followercount from artist
group by Artist_ID;

-- LIKE keyword
select user_id, user_name, Birthday from user_table where birthday like '199_-__-__';


-- Complex Queries

-- 01. Union  
-- SELECT * FROM playlist;
(SELECT  Playlist_name AS pName, Duration AS tDuration FROM playlist WHERE Created_date > '2020-12-31')
UNION
(SELECT Playlist_name AS pName, Duration AS tDuration FROM playlist WHERE Created_date < '2023-01-01');

-- 02. Intersection
/*
SELECT * FROM track;
(SELECT Track_name AS tName, Artist AS A_ID FROM track WHERE Duration > '00:04:00')
INTERSECT
(SELECT tName AS Track_name, Artist AS A_ID FROM track WHERE (Genre = '5002');
*/
-- SELECT * FROM track;
SELECT DISTINCT T1.Track_name, T1.Artist FROM track AS T1
INNER JOIN track AS T2 ON T1.Track_name = T2.Track_name AND T1.Artist = T2.Artist 
WHERE T1.Duration > '00:03:30' AND T2.Genre = '5002';


-- 03. Set difference
/*
SELECT * FROM user_table;
(SELECT User_name AS uName, Country AS uCountry FROM user_table)
EXCEPT
(SELECT User_name AS uName, Country AS uCountry FROM user_table WHERE Country = 'North America');
*/
-- SELECT * FROM user_table;
SELECT U1.User_name AS uName, U1.Country AS uCountry FROM user_table AS U1
LEFT JOIN ( SELECT User_name, Country FROM user_table WHERE Country = 'North America') AS U2 
ON U1.User_name = U2.User_name AND U1.Country = U2.Country WHERE U2.User_name IS NULL;

-- 04. Division
-- Retrieving the common features in all subscription plan
/*
SELECT * FROM track_artist;
CREATE VIEW UV1 AS (SELECT DISTINCT Track_ID FROM track_artist WHERE Track_ID = '3001' OR Track_ID ='3003');
SELECT DISTINCT Co_artist FROM track_artist as T1; WHERE NOT EXISTS 
((SELECT * FROM UV1)
EXCEPT
(SELECT T2.Track_ID FROM track_artist as T2 where T1.Co_artist = T2.Co_artist));
*/
-- SELECT * FROM subscription_plan_features;
SELECT DISTINCT S.Feature, S.Subscription_ID FROM subscription_plan_features AS S WHERE NOT EXISTS (SELECT SP.Subscription_ID FROM subscription_plan AS SP
WHERE NOT EXISTS (SELECT S1.Feature FROM subscription_plan_features AS S1 WHERE S1.Feature = S.Feature AND
S1.Subscription_ID = SP.Subscription_ID));

-- 05. Inner join
CREATE VIEW UV2 AS (SELECT User_ID, User_name, Country FROM user_table);
CREATE VIEW UV3 AS (SELECT Creator, Playlist_name, Created_date FROM playlist);
SELECT * FROM UV2 AS V2 INNER JOIN UV3 AS V3 ON V2.User_ID = V3.Creator WHERE Created_date > '2020-12-31';

-- 06. Natural Join 
CREATE VIEW UV4 AS (SELECT user_ID, User_name, Country FROM user_table);
CREATE VIEW UV5 AS (SELECT * FROM user_device);
SELECT * FROM UV4 AS V4 NATURAL JOIN UV5 AS V5 WHERE V5.user_ID = '1004';

-- 07. Left outer join
CREATE VIEW UV6 AS (SELECT Track_ID, Track_name, Artist FROM track);
CREATE VIEW UV7 AS (SELECT * FROM user_favourite);
SELECT * FROM UV7 AS V7 LEFT OUTER JOIN UV6 AS V6 ON V7.Track = V6.Track_ID WHERE V7.Date_added < '2021-01-01';

-- 08. Right outer join
SELECT * FROM UV7 AS V7 RIGHT OUTER JOIN UV6 AS V6 ON V7.Track = V6.Track_ID WHERE V7.Date_added < '2021-01-01';

-- 09. Full outer join
(SELECT * FROM UV7 AS V7 LEFT OUTER JOIN UV6 AS V6 ON V7.Track = V6.Track_ID WHERE V7.Date_added < '2021-01-01')
UNION
(SELECT * FROM UV7 AS V7 RIGHT OUTER JOIN UV6 AS V6 ON V7.Track = V6.Track_ID WHERE V7.Date_added < '2021-01-01');

-- 10. Outer Union
/*
CREATE VIEW UV8 AS (SELECT User_ID, User_name,Subscription_plan FROM user_table AS U NATURAL JOIN user_device AS UD);
CREATE VIEW UV9 AS (SELECT U.User_ID, U.User_name, U.Follower_count,U.Subscription_plan, NULL FROM user_table AS U);
CREATE VIEW UV10 AS ((SELECT * FROM UV8) 
UNION
(SELECT * FROM UV9));
(SELECT * FROM UV10)
EXCEPT
(SELECT * FROM UV10 WHERE ((User_ID IN (SELECT User_ID FROM user_table)) AND (Device_name is NULL)));
*/

CREATE VIEW UV10 AS SELECT User_ID, User_name, Subscription_plan, Device_name
FROM (SELECT U.User_ID, U.User_name, U.Subscription_plan, UD.Device_name FROM user_table AS U
NATURAL JOIN user_device AS UD) AS UV8
UNION
SELECT User_ID, User_name, Subscription_plan, NULL AS Device_name 
FROM (SELECT U.User_ID, U.User_name, U.Subscription_plan FROM user_table AS U) AS UV9;


-- SELECT * FROM UV10;
SELECT * FROM UV10 WHERE Device_name IS NOT NULL OR User_ID NOT IN (SELECT User_ID FROM user_table);


-- 11. Nested queries 
SELECT U.User_ID, U.User_name FROM user_table as U WHERE U.User_ID IN(SELECT P.Creator FROM playlist as P 
WHERE P.Created_date = '2023-08-20');


-- 12. Nested queries 
SELECT U.User_name,U.Country FROM user_table as U WHERE User_ID IN 
(SELECT F.User_ID FROM user_favourite AS F WHERE F.Track IN
(SELECT T.Track_ID FROM track AS T WHERE T.Track_name ='Shape of You'));

-- 13. Nested queries  
SELECT U.User_ID,U.User_name,U.Country FROM user_table as U WHERE Subscription_plan IN 
(SELECT S. Subscription_ID FROM subscription_plan_features AS S WHERE Feature = 'Ad-free listening');


-- Complex Query Tuning

-- 01. Union - Tuning  

-- show index from playlist;
explain((SELECT  Playlist_name AS pName, Duration AS tDuration FROM playlist WHERE Created_date > '2020-12-31')
UNION
(SELECT Playlist_name AS pName, Duration AS tDuration FROM playlist WHERE Created_date < '2023-01-01'));

create index created_date_index using BTREE on playlist(Created_date);
explain((SELECT  Playlist_name AS pName, Duration AS tDuration FROM playlist WHERE Created_date > '2020-12-31')
UNION
(SELECT Playlist_name AS pName, Duration AS tDuration FROM playlist WHERE Created_date < '2023-01-01'));
drop index created_date_index on playlist;

-- 02. Intersection - Tuning

-- show index from track;
explain(SELECT DISTINCT T1.Track_name, T1.Artist FROM track AS T1
INNER JOIN track AS T2 ON T1.Track_name = T2.Track_name AND T1.Artist = T2.Artist 
WHERE T1.Duration > '00:03:30' AND T2.Genre = '5002');

create index duration_genre_index using BTREE on track(Duration,Genre);
explain(SELECT DISTINCT T1.Track_name, T1.Artist FROM track AS T1
INNER JOIN track AS T2 ON T1.Track_name = T2.Track_name AND T1.Artist = T2.Artist 
WHERE T1.Duration > '00:03:30' AND T2.Genre = '5002');
drop index duration_genre_index on track;


-- 03. Set difference - Tuning

-- show index from user_table;
explain(SELECT U1.User_name AS uName, U1.Country AS uCountry FROM user_table AS U1
LEFT JOIN ( SELECT User_name, Country FROM user_table WHERE Country = 'North America') AS U2 
ON U1.User_name = U2.User_name AND U1.Country = U2.Country WHERE U2.User_name IS NULL);

create index name_country_index using BTREE on user_table(user_name,country);
explain(SELECT U1.User_name AS uName, U1.Country AS uCountry FROM user_table AS U1
LEFT JOIN ( SELECT User_name, Country FROM user_table WHERE Country = 'North America') AS U2 
ON U1.User_name = U2.User_name AND U1.Country = U2.Country WHERE U2.User_name IS NULL);
drop index name_country_index on user_table;


-- 05. Inner join - Tuning

-- show index from user_table;
-- show index from playlist;
explain(SELECT * FROM UV2 AS V2 INNER JOIN UV3 AS V3 ON V2.User_ID = V3.Creator WHERE Created_date > '2020-12-31');

create index user_id_index using BTREE on user_table(User_ID);
create index create_date_index using BTREE on playlist(created_date);
explain(SELECT * FROM UV2 AS V2 INNER JOIN UV3 AS V3 ON V2.User_ID = V3.Creator WHERE Created_date > '2020-12-31');
drop index user_id_index on user_table;
drop index create_date_index on playlist;


-- 06. Natural Join - Tuning

-- show index from user_table;
-- show index from user_device;
explain(SELECT * FROM UV4 AS V4 NATURAL JOIN UV5 AS V5 WHERE V5.user_ID = '1004');

create index user_index using BTREE on user_table(user_ID);
create index device_index using BTREE on user_device(user_ID);
explain(SELECT * FROM UV4 AS V4 NATURAL JOIN UV5 AS V5 WHERE V5.user_ID = '1004');
drop index user_index on user_table;
drop index device_index on user_device;



-- 07. Left outer join - Tuning

-- show index from track;
-- show index from user_favourite;
explain(SELECT * FROM UV7 AS V7 LEFT OUTER JOIN UV6 AS V6 ON V7.Track = V6.Track_ID WHERE V7.Date_added < '2021-01-01');

create index track_index using BTREE on track(Track_ID);
create index date_added_index using BTREE on user_favourite(Date_added);
explain(SELECT * FROM UV7 AS V7 LEFT OUTER JOIN UV6 AS V6 ON V7.Track = V6.Track_ID WHERE V7.Date_added < '2021-01-01');
drop index track_index on track;
drop index date_added_index on user_favourite;


-- 08. Right outer join - Tuning

-- show index from track;
-- show index from user_favourite;
explain(SELECT * FROM UV7 AS V7 RIGHT OUTER JOIN UV6 AS V6 ON V7.Track = V6.Track_ID WHERE V7.Date_added < '2021-01-01');

create index track_index using BTREE on track(Track_ID);
create index date_added_index using BTREE on user_favourite(Date_added);
explain(SELECT * FROM UV7 AS V7 RIGHT OUTER JOIN UV6 AS V6 ON V7.Track = V6.Track_ID WHERE V7.Date_added < '2021-01-01');
drop index track_index on track;
drop index date_added_index on user_favourite;

-- 09. Full outer join - Tuning

-- show index from track;
-- show index from user_favourite;
explain((SELECT * FROM UV7 AS V7 LEFT OUTER JOIN UV6 AS V6 ON V7.Track = V6.Track_ID WHERE V7.Date_added < '2021-01-01')
UNION
(SELECT * FROM UV7 AS V7 RIGHT OUTER JOIN UV6 AS V6 ON V7.Track = V6.Track_ID WHERE V7.Date_added < '2021-01-01'));

create index track_index using BTREE on track(Track_ID);
create index date_added_index using BTREE on user_favourite(Date_added);
explain((SELECT * FROM UV7 AS V7 LEFT OUTER JOIN UV6 AS V6 ON V7.Track = V6.Track_ID WHERE V7.Date_added < '2021-01-01')
UNION
(SELECT * FROM UV7 AS V7 RIGHT OUTER JOIN UV6 AS V6 ON V7.Track = V6.Track_ID WHERE V7.Date_added < '2021-01-01'));
drop index track_index on track;
drop index date_added_index on user_favourite;

-- 11. Nested queries - Tuning

-- show index from user_table;
-- show index from playlist;
explain(SELECT U.User_ID, U.User_name FROM user_table as U WHERE U.User_ID IN(SELECT P.Creator FROM playlist as P 
WHERE P.Created_date = '2023-08-20'));

create index user_index using BTREE on user_table(user_id);
create index created_date_index using BTREE on playlist(Created_date);
explain(SELECT U.User_ID, U.User_name FROM user_table as U WHERE U.User_ID IN(SELECT P.Creator FROM playlist as P 
WHERE P.Created_date = '2023-08-20'));
drop index user_index on user_table;
drop index created_date_index on playlist;

-- 12. Nested queries - Tuning

-- show index from user_table;
-- show index from user_favourite;
-- show index from track;
explain(SELECT U.User_name,U.Country FROM user_table as U WHERE User_ID IN 
(SELECT F.User_ID FROM user_favourite AS F WHERE F.Track IN
(SELECT T.Track_ID FROM track AS T WHERE T.Track_name ='Shape of You')));

create index u_index using BTREE on user_table(User_ID);
create index t_index using BTREE on user_favourite(User_ID);
create index track_name_index using BTREE on track(Track_name);
explain(SELECT U.User_name,U.Country FROM user_table as U WHERE User_ID IN 
(SELECT F.User_ID FROM user_favourite AS F WHERE F.Track IN
(SELECT T.Track_ID FROM track AS T WHERE T.Track_name ='Shape of You')));
drop index u_index on user_table;
drop index t_index on user_favourite;
drop index track_name_index on track;

-- 13. Nested queries - Tuning
-- show index from user_table;
-- show index from subscription_plan_features;
explain(SELECT U.User_ID,U.User_name,U.Country FROM user_table as U WHERE Subscription_plan IN 
(SELECT S. Subscription_ID FROM subscription_plan_features AS S WHERE Feature = 'Ad-free listening'));

create index subs_p_index using BTREE on user_table(user_id,Subscription_plan);
create index feature_index using BTREE on subscription_plan_features(Feature);
explain(SELECT U.User_ID,U.User_name,U.Country FROM user_table as U WHERE Subscription_plan IN 
(SELECT S. Subscription_ID FROM subscription_plan_features AS S WHERE Feature = 'Ad-free listening'));
drop index subs_p_index on user_table;
drop index feature_index on subscription_plan_features;

drop view UV2;
drop view UV3;
drop view UV4;
drop view UV5;
drop view UV6;
drop view UV7;
drop view UV10;
