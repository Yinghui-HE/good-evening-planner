DROP DATABASE IF EXISTS GoodEveningDatabase;
CREATE DATABASE GoodEveningDatabase; -- create database
USE GoodEveningDatabase; -- all code after this will be used on the StudentGrades database


CREATE TABLE Users (
	-- column definitions
	userID INT(11) PRIMARY KEY AUTO_INCREMENT, -- primary key means you can't have two values that are the same in it, AUTO_INCREMENT means that it will automatically create incrementing keys
	username VARCHAR(100) NOT NULL UNIQUE,
    userPassword VARCHAR(50) NOT NULL -- password for the user's account
);
             
CREATE TABLE EveningEvents (
	eventID INT(11) PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(200) NOT NULL, -- title of the event
    location VARCHAR(200) NOT NULL, -- address of the event
    duration INT(11) NOT NULL, -- duration of the event (stored in minutes)
    startTime INT(11), -- start time (only needed for movies) - need to figure out how to store as int
    endTime INT(11), -- end time (only needed for movies) - need to figure out how to store as int
    category VARCHAR(200) NOT NULL, -- category of event
    subCategory VARCHAR(200), -- subcategory inside category (not needed for every event)
    timeDependant INT(2), -- 1 if time dependant, 0 if not time dependant,
    pictureURL VARCHAR(500)
);

CREATE TABLE EveningHistory(
	eveningID INT(11) PRIMARY KEY AUTO_INCREMENT,
    userID INT(11) NOT NULL,
	startTime VARCHAR(20) NOT NULL, -- start time of entire evening (need to figure out how we want to represent it)
    endTime VARCHAR(20) NOT NULL, -- end time of entire evening (need to figure out how we want to represent it)
    eventID1 INT(11), -- first chronological event in evening
    eventID2 INT(11), -- second chronological event in evening
    eventID3 INT(11), -- third chronological event in evening
    eventID4 INT(11), -- fourth chronological event in evening
    eventID5 INT(11), -- fifth chronological event in evening
    inUse INT(11), -- if the evening is in use by the client
	FOREIGN KEY uid2 (userID) REFERENCES Users(userID),
    FOREIGN KEY eid1 (eventID1) REFERENCES EveningEvents(eventID),
    FOREIGN KEY eid2 (eventID1) REFERENCES EveningEvents(eventID),
    FOREIGN KEY eid3 (eventID1) REFERENCES EveningEvents(eventID),
    FOREIGN KEY eid4 (eventID1) REFERENCES EveningEvents(eventID),
    FOREIGN KEY eid5 (eventID1) REFERENCES EveningEvents(eventID)
);

INSERT INTO Users(userID, username, userPassword)
	VALUES (1, 'will', 'dog');

-- Inserting Sightseeing events
INSERT INTO EveningEvents (title, location, duration, category, subCategory, timeDependant, pictureURL)
	VALUES ('Griffith Observatory', '2800 E Observatory Rd Los Angeles, CA 90027', 120, 'Sightseeing', 'Urban', 0, 'https://www.visitcalifornia.com/sites/default/files/styles/welcome_image/public/vc_spotlight_griffithpark_module1_observatory_rf_601930068_1280x640.jpg'),
					('OUE Skyscape LA', '633 W Fifth St Los Angeles, CA 90071', 120, 'Sightseeing', 'Urban',0, 'https://images.musement.com/cover/0001/100/thumb_99883_cover_header.jpeg?w=900'),
                    ('Urban Lights at LACMA', '5905 Wilshire Blvd Los Angeles, CA 90036', 120, 'Sightseeing', 'Urban', 0, 'https://a.scpr.org/i/f7c2a257da1ffad304ae1b93fd1158d7/105035-eight.jpg');
                    
-- Inserting Restaurants
INSERT INTO EveningEvents (title, location, duration, category, subCategory, timeDependant, pictureURL)
	VALUES ('Catch LA', '8715 Melrose Ave, West Hollywood, CA 90069', 90, 'Restaurant', 'Seafood', 0, 'https://catchrestaurants.com/catchla/wp-content/uploads/2015/07/1-Catch-LA_Arrivals-1-1030x687.jpg'),
					('Providence', '5955 Melrose Ave, Los Angeles, CA 90038', 90, 'Restaurant', 'Seafood', 0, 'https://media.timeout.com/images/100513671/630/472/image.jpg'),
                    ('Craft LA', '10100 Constellation Blvd, Los Angeles, CA 90067', 90, 'Restaurant', 'Mixed', 0, 'http://www.dinedelish.com/wp-content/uploads/2014/07/Craft-LA-Inside.jpg'),
					("Mastro's Penthouse", '246 N Canon Dr, Beverly Hills, CA 90210', 90, 'Restaurant', 'Steakhouse', 0, 'https://www.mastrosrestaurants.com/img/Private-Dining/Beverly-Hills-Penthouse/IMG_0425.jpg'),
                    ('Bottega Louie', '700 S Grand Ave, Los Angeles, CA 90017', 90, 'Restaurant', 'Italian', 0, 'https://tomostyle.files.wordpress.com/2009/10/img_1366.jpg'),
                    ("Jon and Vinny's", '412 N Fairfax Ave, Los Angeles, CA 90036', 90, 'Restaurant', 'Italian', 0, 'https://cdn.vox-cdn.com/uploads/chorus_asset/file/3624474/2015-04-18-JonVinnys-004.0.jpg'),
                    ('Bestia', '2121 E 7th Pl, Los Angeles, CA 90021', 90, 'Restaurant', 'Italian', 0, 'https://www.we-heart.com/upload-images/bestialosangeles1753.jpg'),
					('Chi Spacca', '6610 Melrose Ave, Los Angeles, CA 90038', 90, 'Restaurant', 'Italian', 0, 'https://rogersdigest.files.wordpress.com/2014/07/screen-shot-2014-07-18-at-12-12-27-pm.png'),
                    ('Felix Trattoria', '3386, 1023 Abbot Kinney Blvd, Venice, CA 90291', 90, 'Restaurant', 'Italian', 0, 'https://static1.squarespace.com/static/5053619d24ac3b03d535ba23/t/59e90b1bf6576ebb73e11d53/1508444960763/2017_03_31_Felix_010.jpg'),
                    ('Alimento', '1710 Silver Lake Blvd, Los Angeles, CA 90026', 90, 'Restaurant', 'Italian', 0, 'https://cdn.vox-cdn.com/thumbor/Fnfbp3PoP3riisylWNikDGYdXfk=/60x0:946x665/1200x800/filters:focal(60x0:946x665)/cdn.vox-cdn.com/uploads/chorus_image/image/41730788/2014-06-25-alimento-005.0.0.jpg'),
                    ('Petit Trois',	'718 N Highland Ave, Los Angeles, CA 90038', 90, 'Restaurant', 'French', 0, 'https://cdn.vox-cdn.com/thumbor/T5mmIhUvrKdfCKb6MtiIrssBMbg=/0x0:2000x1335/1200x675/filters:focal(840x508:1160x828)/cdn.vox-cdn.com/uploads/chorus_image/image/59451103/2018_04_18_PetitTrois_LeValley_013.0.jpg'),
                    ('Spago', '176 N Canon Dr, Beverly Hills, CA 90210', 90, 'Restaurant', 'Californian', 0, 'https://beverlyhillsmagazine.com/wp-content/uploads/SPAGO-Beverly-Hills-Restaurant-Beverly-Hills-restaurant-beverly-hills-magazine-7.jpg'),
                    ('Wolfgang Puck', '800 W Olympic Blvd, Los Angeles, CA 90015', 90, 'Restaurant', 'Californian', 0, 'https://ritzcarlton-h.assetsadobe.com/is/image/content/dam/the-ritz-carlton/hotels/usa-and-canada/california/los-angeles/dining/RCLOSAN_00159.png?$XlargeViewport100pct$'),
                    ('Broken Spanish', '1050 S Flower St, Los Angeles, CA 90015', 90, 'Restaurant', 'Mexican', 0, 'https://archinect.imgix.net/uploads/kx/kxauqchk3q4qsve7.jpg?fit=crop&auto=compress%2Cformat&w=615'),
                    ('Guelaguetza', '3014 W Olympic Blvd, Los Angeles, CA 90006', 90, 'Restaurant', 'Mexican', 0, 'https://static1.squarespace.com/static/568b10bd841aba419c386869/569865149cadb68b382731b3/5698671869a91abbe6d8205f/1452828446985/IMG_2347.jpg?format=1500w');
                    
-- Inserting Exhibitions

INSERT INTO EveningEvents (title, location, duration, category, subCategory, timeDependant, pictureURL)
	VALUES ('Getty Center','1200 Getty Center Dr, Los Angeles, CA 90049', 120, 'Exhibition', 'Art', 0, 'http://news.getty.edu/content/1208/images/gettyvillaatnightcollegenight.jpg'),
					('Natural History Museum', '900 W Exposition Blvd, Los Angeles, CA 90007',  120, 'Exhibition', 'History',0, 'https://www.ioes.ucla.edu/wp-content/uploads/nhmla_pic.jpg'),
                    ('The Broad', '221 S Grand Ave, Los Angeles, CA 90012', 120, 'Exhibition', 'Art', 0, 'http://www.detourla.com/uploads/9/6/6/6/9666388/1588894_orig.jpg'),
                    ('Petersen Automotive Museum', '6060 Wilshire Blvd, Los Angeles, CA 90036', 120, 'Exhibition', 'Science', 0, 'https://static1.squarespace.com/static/5468083be4b06c4ea4b49a81/56959e422399a3e236acc20f/56959e81c21b863e1119c0b4/1452646023097/2C9A2926-L.jpg'),
                    ('California Science Center', '700 Exposition Park Dr, Los Angeles, CA 90037', 120, 'Exhibition', 'Science', 0, 'https://bizbash-production.imgix.net/content/resource/ResourceImage/big/1-samueloschinspaceshuttleendeavourdisplaypavilion-photobynadinefrogerphotography.jpg?auto=format'),
                    ('Annenberg Space for Photography', '2000 Avenue of the Stars #10, Los Angeles, CA 90067', 120, 'Exhibition', 'Art',  0, 'https://annenbergphotospace.org/wp-content/uploads/2017/12/placeholder-1920x1000-hero.jpg'),
                    ('Hammer Museum', '10899 Wilshire Blvd, Los Angeles, CA 90024', 120, 'Exhibition', 'Art', 0, 'https://media-cdn.tripadvisor.com/media/photo-s/0e/b1/8b/9f/hammer-museum-courtyard.jpg');


INSERT INTO EveningHistory (userID, startTime, endTime, eventID1, eventID2 ,eventID3 ,eventID4 ,eventID5, inUse)
    VALUES (1, '6:30 PM', '10:00 PM', 1, 2, 1, 3, 4, 1),
                    (1,'7:00 PM', '11:00 PM', 3, 4, 1, 2, 4, 1),
                    (1, '6:30 PM', '10:00 PM', 1, 2, 1, 3, 4, 1),
                    (1,'7:35 PM', '11:00 PM', 3, 4, 1, 2, 4,1),
                    (1,'7:30 PM', '11:00 PM', 3, 4, 1, 2, 4,0);

