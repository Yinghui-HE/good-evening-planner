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
    pictureURL VARCHAR(200)
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
INSERT INTO EveningEvents (title, location, duration, category, timeDependant, pictureURL)
	VALUES ('Griffith Observatory', '2800 E Observatory Rd Los Angeles, CA 90027', 60, 'Sightseeing', 0, 'https://www.visitcalifornia.com/sites/default/files/styles/welcome_image/public/vc_spotlight_griffithpark_module1_observatory_rf_601930068_1280x640.jpg'),
					('OUE Skyscape LA', '633 W Fifth St Los Angeles, CA 90071', 60, 'Sightseeing', 0, 'https://images.musement.com/cover/0001/100/thumb_99883_cover_header.jpeg?w=900'),
                    ('Urban Lights at LACMA', '5905 Wilshire Blvd Los Angeles, CA 90036', 60, 'Sightseeing', 0, 'https://a.scpr.org/i/f7c2a257da1ffad304ae1b93fd1158d7/105035-eight.jpg');
                    
-- Inserting Restaurants
INSERT INTO EveningEvents (title, location, duration, category, subCategory, timeDependant, pictureURL)
	VALUES ('Catch LA', '8715 Melrose Ave, West Hollywood, CA 90069', 90, 'Dinner', 'Seafood', 0, 'https://catchrestaurants.com/catchla/wp-content/uploads/2015/07/1-Catch-LA_Arrivals-1-1030x687.jpg'),
					('Providence', '5955 Melrose Ave, Los Angeles, CA 90038', 90, 'Dinner', 'Seafood', 0, 'https://media.timeout.com/images/100513671/630/472/image.jpg'),
                    ('Craft LA', '10100 Constellation Blvd, Los Angeles, CA 90067', 90, 'Dinner', 'Mixed', 0, 'http://www.dinedelish.com/wp-content/uploads/2014/07/Craft-LA-Inside.jpg');
                    
INSERT INTO EveningHistory (userID, startTime, endTime, eventID1, eventID2 ,eventID3 ,eventID4 ,eventID5)
	VALUES (1, '6:30 PM', '10:00 PM', 1, 2, 1, 3, 4);

