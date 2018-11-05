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
    timeDependant INT(2) -- 1 if time dependant, 0 if not time dependant
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




