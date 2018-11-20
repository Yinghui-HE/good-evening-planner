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
    subCategory VARCHAR(200) NOT NULL, -- subcategory inside category (not needed for every event)
    timeDependant INT(2), -- 1 if time dependant, 0 if not time dependant,
    pictureURL VARCHAR(500)
);

CREATE TABLE EveningHistory(
	eveningID INT(11) PRIMARY KEY AUTO_INCREMENT,
    userID INT(11) NOT NULL,
	startTime INT(11) NOT NULL, -- start time of entire evening (need to figure out how we want to represent it)
    endTime INT(11) NOT NULL, -- end time of entire evening (need to figure out how we want to represent it)
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
INSERT INTO EveningEvents (title, location, duration, category, subCategory, timeDependant, pictureURL, startTime, endTime)
	VALUES ('Griffith Observatory', '2800 E Observatory Rd Los Angeles, CA 90027', 120, 'Sightseeing', 'Urban', 0, 'https://www.visitcalifornia.com/sites/default/files/styles/welcome_image/public/vc_spotlight_griffithpark_module1_observatory_rf_601930068_1280x640.jpg', 1700, 1900),
					('OUE Skyscape LA', '633 W Fifth St Los Angeles, CA 90071', 120, 'Sightseeing', 'Urban',0, 'https://images.musement.com/cover/0001/100/thumb_99883_cover_header.jpeg?w=900', 1600, 1800),
                    ('Urban Lights at LACMA', '5905 Wilshire Blvd Los Angeles, CA 90036', 120, 'Sightseeing', 'Urban', 0, 'https://a.scpr.org/i/f7c2a257da1ffad304ae1b93fd1158d7/105035-eight.jpg', 2000, 2200),
                    ('The Wisdom Tree Trail', 'Tree of Life Trail, Los Angeles, CA 90068', 120, 'Sightseeing','Outdoors', 0, 'https://cdn2.lamag.com/wp-content/uploads/sites/6/2016/03/52WisdomTree-1.jpg', 1800, 2000),
					('George F Canyon', '27305 Palos Verdes Dr East, Rolling Hills Estates', 120, 'Sightseeing', 'Outdoors', 0, 'https://media.timeout.com/images/104085830/630/472/image.jpg', 1700, 1900),
					('Echo Mountain', 'Echo Mountain (Mount Lowe Railroad Trail), Altadena, CA 91001', 120, 'Sightseeing', 'Outdoors', 0, 'https://images1.laweekly.com/imager/u/745xauto/6044483/echo-mountain-best-night-hike-clarissa-wei.jpg', 1900, 2100),
					('Runyon Canyon', '2000 N Fuller Ave, Los Angeles, CA 90046', 120, 'Sightseeing', 'Outdoors', 0, 'http://1.bp.blogspot.com/-uAKPHQLKg5A/WIqI3MccHpI/AAAAAAAAB3E/xpQKUiH__cEDMs_UuDURjreWBUnbsQ0GgCK4B/s1600/IMG_8353.JPG', 2000, 2200),
					('Hollywood Walk of Fame', 'N Highland Ave & Hollywood Boulevard, Los Angeles, CA 90028', 120, 'Sightseeing', 'Urban', 0, 'https://d2v9y0dukr6mq2.cloudfront.net/video/thumbnail/GbbtDTW/hollywood-walk-of-fame-stars-at-dusk-timelapse_ny_ssayh__F0013.png', 1900, 2100),
					('Pacific Park', 'Pacific Park, 380 Santa Monica Pier, Santa Monica, CA', 120, 'Sightseeing', 'Urban', 0, 'https://ssl.c.photoshelter.com/img-get2/I0000CsAXftKLbaU/fit=1000x750/04-Santa-Monica-Pier-Pacific-Park-Entrance.jpg', 2100, 2300),
					('Universal CityWalk', 'Universal City Walk, 100 Universal City Plaza, Universal City, CA', 120, 'Sightseeing', 'Urban', 0, 'https://www.travelingmom.com/wp-content/uploads/2016/05/78.jpg', 1800, 2000),
					('Downtown LA Art Walk', '4th St & Spring St, Los Angeles, CA 90013', 120, 'Sightseeing', 'Urban', 0, 'https://culturela.org/wp-content/uploads/2017/02/418034_304725559582175_1754485111_n.jpg', 2200, 2400);

                    
-- Inserting Restaurants
INSERT INTO EveningEvents (title, location, duration, category, subCategory, timeDependant, pictureURL, startTime, endTime)
	VALUES ('Catch LA', '8715 Melrose Ave, West Hollywood, CA 90069', 60, 'Restaurant', 'Seafood', 0, 'https://catchrestaurants.com/catchla/wp-content/uploads/2015/07/1-Catch-LA_Arrivals-1-1030x687.jpg', 1800, 1900),
					('Catch LA', '8715 Melrose Ave, West Hollywood, CA 90069', 60, 'Restaurant', 'Seafood', 0, 'https://catchrestaurants.com/catchla/wp-content/uploads/2015/07/1-Catch-LA_Arrivals-1-1030x687.jpg', 1900, 2000),
					('Providence', '5955 Melrose Ave, Los Angeles, CA 90038', 60, 'Restaurant', 'Seafood', 0, 'https://media.timeout.com/images/100513671/630/472/image.jpg', 2000, 2100),
                    ('Providence', '5955 Melrose Ave, Los Angeles, CA 90038', 60, 'Restaurant', 'Seafood', 0, 'https://media.timeout.com/images/100513671/630/472/image.jpg', 2100, 2200),
                    ('Providence', '5955 Melrose Ave, Los Angeles, CA 90038', 60, 'Restaurant', 'Seafood', 0, 'https://media.timeout.com/images/100513671/630/472/image.jpg', 2200, 2300),
                    ('Craft LA', '10100 Constellation Blvd, Los Angeles, CA 90067', 60, 'Restaurant', 'Mixed', 0, 'http://www.dinedelish.com/wp-content/uploads/2014/07/Craft-LA-Inside.jpg', 1800, 1900),
                    ('Craft LA', '10100 Constellation Blvd, Los Angeles, CA 90067', 60, 'Restaurant', 'Mixed', 0, 'http://www.dinedelish.com/wp-content/uploads/2014/07/Craft-LA-Inside.jpg', 1900, 2000),
                    ('Craft LA', '10100 Constellation Blvd, Los Angeles, CA 90067', 60, 'Restaurant', 'Mixed', 0, 'http://www.dinedelish.com/wp-content/uploads/2014/07/Craft-LA-Inside.jpg', 2000, 2100),
					('Mastros Penthouse', '246 N Canon Dr, Beverly Hills, CA 90210', 60, 'Restaurant', 'Steakhouse', 0, 'https://www.mastrosrestaurants.com/img/Private-Dining/Beverly-Hills-Penthouse/IMG_0425.jpg', 1800, 1900),
                    ('Mastros Penthouse', '246 N Canon Dr, Beverly Hills, CA 90210', 60, 'Restaurant', 'Steakhouse', 0, 'https://www.mastrosrestaurants.com/img/Private-Dining/Beverly-Hills-Penthouse/IMG_0425.jpg', 1900, 2000),
                    ('Mastros Penthouse', '246 N Canon Dr, Beverly Hills, CA 90210', 60, 'Restaurant', 'Steakhouse', 0, 'https://www.mastrosrestaurants.com/img/Private-Dining/Beverly-Hills-Penthouse/IMG_0425.jpg', 2000, 2100),
                    ('Mastros Penthouse', '246 N Canon Dr, Beverly Hills, CA 90210', 60, 'Restaurant', 'Steakhouse', 0, 'https://www.mastrosrestaurants.com/img/Private-Dining/Beverly-Hills-Penthouse/IMG_0425.jpg', 2100, 2200),
                    ('Bottega Louie', '700 S Grand Ave, Los Angeles, CA 90017', 60, 'Restaurant', 'Italian', 0, 'https://tomostyle.files.wordpress.com/2009/10/img_1366.jpg', 1800, 1900),
                    ('Jon and Vinnys', '412 N Fairfax Ave, Los Angeles, CA 90036', 60, 'Restaurant', 'Italian', 0, 'https://cdn.vox-cdn.com/uploads/chorus_asset/file/3624474/2015-04-18-JonVinnys-004.0.jpg', 1900, 2000),
                    ('Bestia', '2121 E 7th Pl, Los Angeles, CA 90021', 60, 'Restaurant', 'Italian', 0, 'https://www.we-heart.com/upload-images/bestialosangeles1753.jpg', 2000, 2100),
					('Chi Spacca', '6610 Melrose Ave, Los Angeles, CA 90038', 60, 'Restaurant', 'Italian', 0, 'https://rogersdigest.files.wordpress.com/2014/07/screen-shot-2014-07-18-at-12-12-27-pm.png', 2100, 2200),
                    ('Felix Trattoria', '3386, 1023 Abbot Kinney Blvd, Venice, CA 90291', 60, 'Restaurant', 'Italian', 0, 'https://static1.squarespace.com/static/5053619d24ac3b03d535ba23/t/59e90b1bf6576ebb73e11d53/1508444960763/2017_03_31_Felix_010.jpg', 2200, 2300),
                    ('Alimento', '1710 Silver Lake Blvd, Los Angeles, CA 90026', 60, 'Restaurant', 'Italian', 0, 'https://cdn.vox-cdn.com/thumbor/Fnfbp3PoP3riisylWNikDGYdXfk=/60x0:946x665/1200x800/filters:focal(60x0:946x665)/cdn.vox-cdn.com/uploads/chorus_image/image/41730788/2014-06-25-alimento-005.0.0.jpg', 2300, 2400),
                    ('Petit Trois',	'718 N Highland Ave, Los Angeles, CA 90038', 60, 'Restaurant', 'French', 0, 'https://cdn.vox-cdn.com/thumbor/T5mmIhUvrKdfCKb6MtiIrssBMbg=/0x0:2000x1335/1200x675/filters:focal(840x508:1160x828)/cdn.vox-cdn.com/uploads/chorus_image/image/59451103/2018_04_18_PetitTrois_LeValley_013.0.jpg', 1800, 1900),
                    ('Petit Trois',	'718 N Highland Ave, Los Angeles, CA 90038', 60, 'Restaurant', 'French', 0, 'https://cdn.vox-cdn.com/thumbor/T5mmIhUvrKdfCKb6MtiIrssBMbg=/0x0:2000x1335/1200x675/filters:focal(840x508:1160x828)/cdn.vox-cdn.com/uploads/chorus_image/image/59451103/2018_04_18_PetitTrois_LeValley_013.0.jpg', 1900, 2000),
                    ('Petit Trois',	'718 N Highland Ave, Los Angeles, CA 90038', 60, 'Restaurant', 'French', 0, 'https://cdn.vox-cdn.com/thumbor/T5mmIhUvrKdfCKb6MtiIrssBMbg=/0x0:2000x1335/1200x675/filters:focal(840x508:1160x828)/cdn.vox-cdn.com/uploads/chorus_image/image/59451103/2018_04_18_PetitTrois_LeValley_013.0.jpg', 2000, 2100),
                    ('Petit Trois',	'718 N Highland Ave, Los Angeles, CA 90038', 60, 'Restaurant', 'French', 0, 'https://cdn.vox-cdn.com/thumbor/T5mmIhUvrKdfCKb6MtiIrssBMbg=/0x0:2000x1335/1200x675/filters:focal(840x508:1160x828)/cdn.vox-cdn.com/uploads/chorus_image/image/59451103/2018_04_18_PetitTrois_LeValley_013.0.jpg', 2100, 2200),
                    ('Spago', '176 N Canon Dr, Beverly Hills, CA 90210', 60, 'Restaurant', 'Californian', 0, 'https://beverlyhillsmagazine.com/wp-content/uploads/SPAGO-Beverly-Hills-Restaurant-Beverly-Hills-restaurant-beverly-hills-magazine-7.jpg', 1800, 1900),
                    ('Wolfgang Puck', '800 W Olympic Blvd, Los Angeles, CA 90015', 60, 'Restaurant', 'Californian', 0, 'https://ritzcarlton-h.assetsadobe.com/is/image/content/dam/the-ritz-carlton/hotels/usa-and-canada/california/los-angeles/dining/RCLOSAN_00159.png?$XlargeViewport100pct$', 1900, 2000),
                    ('Wolfgang Puck', '800 W Olympic Blvd, Los Angeles, CA 90015', 60, 'Restaurant', 'Californian', 0, 'https://ritzcarlton-h.assetsadobe.com/is/image/content/dam/the-ritz-carlton/hotels/usa-and-canada/california/los-angeles/dining/RCLOSAN_00159.png?$XlargeViewport100pct$', 2000, 2100),
                    ('Wolfgang Puck', '800 W Olympic Blvd, Los Angeles, CA 90015', 60, 'Restaurant', 'Californian', 0, 'https://ritzcarlton-h.assetsadobe.com/is/image/content/dam/the-ritz-carlton/hotels/usa-and-canada/california/los-angeles/dining/RCLOSAN_00159.png?$XlargeViewport100pct$', 2100, 2200),
                    ('Broken Spanish', '1050 S Flower St, Los Angeles, CA 90015', 60, 'Restaurant', 'Mexican', 0, 'https://archinect.imgix.net/uploads/kx/kxauqchk3q4qsve7.jpg?fit=crop&auto=compress%2Cformat&w=615', 1800, 1900),
                    ('Broken Spanish', '1050 S Flower St, Los Angeles, CA 90015', 60, 'Restaurant', 'Mexican', 0, 'https://archinect.imgix.net/uploads/kx/kxauqchk3q4qsve7.jpg?fit=crop&auto=compress%2Cformat&w=615', 1900, 2000),
                    ('Broken Spanish', '1050 S Flower St, Los Angeles, CA 90015', 60, 'Restaurant', 'Mexican', 0, 'https://archinect.imgix.net/uploads/kx/kxauqchk3q4qsve7.jpg?fit=crop&auto=compress%2Cformat&w=615', 2000, 2100),
                    ('Guelaguetza', '3014 W Olympic Blvd, Los Angeles, CA 90006', 60, 'Restaurant', 'Mexican', 0, 'https://static1.squarespace.com/static/568b10bd841aba419c386869/569865149cadb68b382731b3/5698671869a91abbe6d8205f/1452828446985/IMG_2347.jpg?format=1500w', 2100, 2200),
                    ('Parks BBQ', '955 S Vermont Ave G, Los Angeles, CA 90006', 60, 'Restaurant', 'Koreanbarbecue', 0, 'https://c1.staticflickr.com/8/7189/6942927829_f00f0628de_b.jpg', 1900, 2000),
                    ('Parks BBQ', '955 S Vermont Ave G, Los Angeles, CA 90006', 60, 'Restaurant', 'Koreanbarbecue', 0, 'https://c1.staticflickr.com/8/7189/6942927829_f00f0628de_b.jpg', 2000, 2100),
                    ('Parks BBQ', '955 S Vermont Ave G, Los Angeles, CA 90006', 60, 'Restaurant', 'Koreanbarbecue', 0, 'https://c1.staticflickr.com/8/7189/6942927829_f00f0628de_b.jpg', 2100, 2200),
                    ('Parks BBQ', '955 S Vermont Ave G, Los Angeles, CA 90006', 60, 'Restaurant', 'Koreanbarbecue', 0, 'https://c1.staticflickr.com/8/7189/6942927829_f00f0628de_b.jpg', 2200, 2300),
					('Shibumi', '815 S Hill St, Los Angeles, CA 90014', 60, 'Restaurant', 'Asian', 0, 'http://www.whiteguide-nordic.com/sites/default/files/imagecache/lightbox/bs_shibumi_bar-press.jpg', 1800, 1900),
                    ('Shibumi', '815 S Hill St, Los Angeles, CA 90014', 60, 'Restaurant', 'Asian', 0, 'http://www.whiteguide-nordic.com/sites/default/files/imagecache/lightbox/bs_shibumi_bar-press.jpg', 1900, 2000),
					('Orsa and Winston', '122 W 4th St, Los Angeles, CA 90013', 60, 'Restaurant', 'Asian', 0, 'https://cdn.vox-cdn.com/thumbor/_gi59G0sjThxV_xhqtpfq84xM0g=/77x0:1470x1045/1200x800/filters:focal(77x0:1470x1045)/cdn.vox-cdn.com/uploads/chorus_image/image/44359928/orsa_winston.0.0.jpg', 2000, 2100),
                    ('Orsa and Winston', '122 W 4th St, Los Angeles, CA 90013', 60, 'Restaurant', 'Asian', 0, 'https://cdn.vox-cdn.com/thumbor/_gi59G0sjThxV_xhqtpfq84xM0g=/77x0:1470x1045/1200x800/filters:focal(77x0:1470x1045)/cdn.vox-cdn.com/uploads/chorus_image/image/44359928/orsa_winston.0.0.jpg', 2100, 2200),
                    ('Orsa and Winston', '122 W 4th St, Los Angeles, CA 90013', 60, 'Restaurant', 'Asian', 0, 'https://cdn.vox-cdn.com/thumbor/_gi59G0sjThxV_xhqtpfq84xM0g=/77x0:1470x1045/1200x800/filters:focal(77x0:1470x1045)/cdn.vox-cdn.com/uploads/chorus_image/image/44359928/orsa_winston.0.0.jpg', 2200, 2300);
      
-- Inserting Exhibitions

INSERT INTO EveningEvents (title, location, duration, category, subCategory, timeDependant, pictureURL, startTime, endTime)
	VALUES ('Getty Center','1200 Getty Center Dr, Los Angeles, CA 90049', 120, 'Exhibition', 'Art', 0, 'http://news.getty.edu/content/1208/images/gettyvillaatnightcollegenight.jpg', 1800, 2000),
					('Natural History Museum', '900 W Exposition Blvd, Los Angeles, CA 90007',  120, 'Exhibition', 'History',0, 'https://www.ioes.ucla.edu/wp-content/uploads/nhmla_pic.jpg', 1600, 1800),
                    ('Natural History Museum', '900 W Exposition Blvd, Los Angeles, CA 90007',  120, 'Exhibition', 'History',0, 'https://www.ioes.ucla.edu/wp-content/uploads/nhmla_pic.jpg', 1700, 1900),
                    ('The Broad', '221 S Grand Ave, Los Angeles, CA 90012', 120, 'Exhibition', 'Art', 0, 'http://www.detourla.com/uploads/9/6/6/6/9666388/1588894_orig.jpg', 1900, 2100),
                    ('Petersen Automotive Museum', '6060 Wilshire Blvd, Los Angeles, CA 90036', 120, 'Exhibition', 'Science', 0, 'https://static1.squarespace.com/static/5468083be4b06c4ea4b49a81/56959e422399a3e236acc20f/56959e81c21b863e1119c0b4/1452646023097/2C9A2926-L.jpg', 1700, 1900),
					('Petersen Automotive Museum', '6060 Wilshire Blvd, Los Angeles, CA 90036', 120, 'Exhibition', 'Science', 0, 'https://static1.squarespace.com/static/5468083be4b06c4ea4b49a81/56959e422399a3e236acc20f/56959e81c21b863e1119c0b4/1452646023097/2C9A2926-L.jpg', 1600, 1800),
                    ('California Science Center', '700 Exposition Park Dr, Los Angeles, CA 90037', 120, 'Exhibition', 'Science', 0, 'https://bizbash-production.imgix.net/content/resource/ResourceImage/big/1-samueloschinspaceshuttleendeavourdisplaypavilion-photobynadinefrogerphotography.jpg?auto=format', 1800, 2000),
                    ('Annenberg Space for Photography', '2000 Avenue of the Stars #10, Los Angeles, CA 90067', 120, 'Exhibition', 'Art',  0, 'https://annenbergphotospace.org/wp-content/uploads/2017/12/placeholder-1920x1000-hero.jpg', 2000, 2200),
                    ('Hammer Museum', '10899 Wilshire Blvd, Los Angeles, CA 90024', 120, 'Exhibition', 'Art', 0, 'https://media-cdn.tripadvisor.com/media/photo-s/0e/b1/8b/9f/hammer-museum-courtyard.jpg', 1700, 1900);


INSERT INTO EveningHistory (userID, startTime, endTime, eventID1, eventID2 ,eventID3 ,eventID4 ,eventID5, inUse)
    VALUES (1, 1830, 2100, 1, 2, 1, 3, 4, 1),
                    (1, 1900, 2300, 3, 4, 1, 2, 4, 1),
                    (1, 1830, 2000, 1, 2, 1, 3, 4, 1),
                    (1, 1935, 2300, 3, 4, 1, 2, 4,1),
                    (1, 1930, 2300, 3, 4, 1, 2, 4,0);

