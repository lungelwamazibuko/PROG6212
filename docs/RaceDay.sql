-- ============================================================
-- STEP 1: CREATE DATABASE
-- ============================================================
CREATE DATABASE RaceDayDB;
USE RaceDayDB;

-- ============================================================
-- STEP 2: CREATE ROLE TABLE
-- ============================================================

CREATE TABLE tblRoles (
RoleID      INT PRIMARY KEY,
RoleName    VARCHAR(50) NOT NULL UNIQUE,
RoleDescription VARCHAR(255) NULL
);

-- ============================================================
-- STEP 3: CREATE USER TABLE
-- ============================================================

CREATE TABLE tblUsers (
UserID       INT PRIMARY KEY,
RoleID       INT NOT NULL,
FullName     VARCHAR(100) NOT NULL,
Email        VARCHAR(150) NOT NULL UNIQUE,
PasswordHash VARCHAR(255) NOT NULL,
PhoneNumber  VARCHAR(20) NULL,
CreatedAt    DATETIME NOT NULL DEFAULT GETDATE(),
AccountStatus VARCHAR(20) NOT NULL DEFAULT 'Active',
CONSTRAINT FK_User_Role FOREIGN KEY (RoleID) REFERENCES tblRoles(RoleID)
);

-- ============================================================
-- STEP 4: CREATE EVENT TABLE
-- ============================================================

CREATE TABLE tblEvents (
EventID      INT PRIMARY KEY,
OrganiserID  INT NOT NULL,
EventName    VARCHAR(150) NOT NULL,
EventDescription  VARCHAR(500) NULL,
EventDate    DATE NOT NULL,
EventLocation     VARCHAR(150) NOT NULL,
EventStatus       VARCHAR(30) NOT NULL DEFAULT 'Scheduled',
CreatedAt    DATETIME NOT NULL DEFAULT GETDATE(),
CONSTRAINT FK_Event_Organiser FOREIGN KEY (OrganiserID) REFERENCES tblUsers(UserID)
);

-- ============================================================
-- STEP 5: CREATE WEATHER TABLE
-- ============================================================

CREATE TABLE tblWeather (
WeatherID        INT PRIMARY KEY,
EventID          INT NOT NULL,
Temperature      DECIMAL(5,2) NOT NULL,
WeatherCondition VARCHAR(100) NOT NULL,
WindSpeed        DECIMAL(6,2) NOT NULL,
Humidity         INT NOT NULL,
ForecastTime     DATETIME NOT NULL,
CONSTRAINT FK_Weather_Event FOREIGN KEY (EventID) REFERENCES tblEvents(EventID),
CONSTRAINT CK_Weather_Humidity CHECK (Humidity BETWEEN 0 AND 100),
CONSTRAINT CK_Weather_WindSpeed CHECK (WindSpeed >= 0)
);


-- ============================================================
-- STEP 6: CREATE ROUTE TABLE
-- ============================================================

CREATE TABLE tblRoutes (
RouteID       INT PRIMARY KEY,
EventID       INT NOT NULL,
RouteName     VARCHAR(150) NOT NULL,
DistanceKM    DECIMAL(8,2) NOT NULL,
ElevationGain DECIMAL(8,2) NOT NULL,
StartPoint    VARCHAR(150) NOT NULL,
RouteEndPoint      VARCHAR(150) NOT NULL,
MapDataURL    VARCHAR(500) NULL,
CONSTRAINT FK_Route_Event FOREIGN KEY (EventID) REFERENCES tblEvents(EventID),
CONSTRAINT CK_Route_Distance CHECK (DistanceKM > 0),
CONSTRAINT CK_Route_Elevation CHECK (ElevationGain >= 0)
);


-- ============================================================
-- STEP 7: CREATE CATEGORY TABLE
-- ============================================================

CREATE TABLE tblCategory (
CategoryID        INT PRIMARY KEY,
EventID           INT NOT NULL,
RouteID           INT NOT NULL,
CategoryName      VARCHAR(100) NOT NULL,
DistanceKM        DECIMAL(8,2) NOT NULL,
EntryFee          DECIMAL(10,2) NOT NULL,
MaxParticipants   INT NOT NULL,
GenderRestriction VARCHAR(30) NOT NULL DEFAULT 'Open',
AgeGroup          VARCHAR(50) NOT NULL,
CONSTRAINT FK_Category_Event FOREIGN KEY (EventID) REFERENCES tblEvents(EventID),
CONSTRAINT FK_Category_Route FOREIGN KEY (RouteID) REFERENCES tblRoutes(RouteID),
CONSTRAINT CK_Category_Distance CHECK (DistanceKM > 0),
CONSTRAINT CK_Category_EntryFee CHECK (EntryFee >= 0),
CONSTRAINT CK_Category_MaxParticipants CHECK (MaxParticipants > 0)
);


-- ============================================================
-- STEP 8: CREATE REGISTRATION TABLE
-- ============================================================

CREATE TABLE tblRegistrations (
RegistrationID     INT PRIMARY KEY,
UserID             INT NOT NULL,
CategoryID         INT NOT NULL,
RegistrationDate   DATETIME NOT NULL DEFAULT GETDATE(),
BibNumber          INT NOT NULL UNIQUE,
RegistrationStatus VARCHAR(30) NOT NULL DEFAULT 'Confirmed',
CONSTRAINT FK_Registration_User FOREIGN KEY (UserID) REFERENCES tblUsers(UserID),
CONSTRAINT FK_Registration_Category FOREIGN KEY (CategoryID) REFERENCES tblCategory(CategoryID),
CONSTRAINT CK_Registration_BibNumber CHECK (BibNumber > 0)
);

-- ============================================================
-- STEP 9: CREATE RESULT TABLE
-- ============================================================

CREATE TABLE tblResults (
ResultID       INT PRIMARY KEY,
RegistrationID INT NOT NULL,
StartTime      TIME NOT NULL,
FinishTime     TIME NULL,
Position       INT NULL,
Pace           DECIMAL(6,2) NULL,
ResultStatus   VARCHAR(30) NOT NULL DEFAULT 'Completed',
CONSTRAINT FK_Result_Registration FOREIGN KEY (RegistrationID) REFERENCES tblRegistrations(RegistrationID),
CONSTRAINT CK_Result_Position CHECK (Position IS NULL OR Position > 0),
CONSTRAINT CK_Result_Pace CHECK (Pace IS NULL OR Pace > 0)
);

-- ============================================================
-- STEP 10: INSERT ROLES
-- ============================================================

INSERT INTO tblRoles (RoleID, RoleName, RoleDescription) VALUES
(1, 'Admin', 'System administrator'),
(2, 'Organiser', 'Creates and manages RaceDay events'),
(3, 'Participant', 'Registers for and participates in events');

-- ============================================================
-- STEP 11: INSERT USERS
-- Minimum required:
-- 2 Organisers and 2 Participants
-- ============================================================

INSERT INTO tblUsers (UserID, RoleID, FullName, Email, PasswordHash, PhoneNumber, CreatedAt, AccountStatus) VALUES
(1, 2, 'Thabo Mokoena', 'thabo.mokoena@gmail.com',
    'HASH_001', '0825551001', '2026-01-10 09:00:00', 'Active'),
(2, 2, 'Lerato Dlamini', 'lerato.dlamini@gmail.com',
    'HASH_002', '0894853203', '2026-01-12 10:30:00', 'Active'),
(3, 3, 'Sipho Nkosi', 'sipho.nkosi@gmail.com',
    'HASH_003', '0742471773', '2026-02-01 08:15:00', 'Active'),
(4, 3, 'Nomsa Khumalo', 'nomsa.khumalo@gmail.com',
    'HASH_004', '0855558954', '2026-02-03 11:45:00', 'Active'),
(5, 1, 'Admin User', 'admin@raceday.gmail.com',
    'HASH_005', '0629964322', '2026-01-01 08:00:00', 'Active');


-- ============================================================
-- STEP 12: INSERT EVENTS
-- Minimum required: 3 Events
-- ============================================================

INSERT INTO tblEvents (EventID, OrganiserID, EventName, EventDescription, EventDate, EventLocation, EventStatus, CreatedAt) VALUES
(1, 1, 'Durban Coastal Run',
    'A coastal road race along the Durban beachfront.',
    '2026-09-12', 'Durban, KwaZulu-Natal', 'Scheduled', '2026-03-01 09:00:00'),
(2, 2, 'Umhlanga Charity Marathon',
    'A charity running event supporting local community projects.',
    '2026-10-10', 'Umhlanga, KwaZulu-Natal', 'Scheduled', '2026-03-05 10:00:00'),
(3, 1, 'Richards Bay Spring Run',
    'A spring running event suitable for competitive and recreational runners.',
    '2026-11-07', 'Richards Bay, KwaZulu-Natal', 'Scheduled', '2026-03-10 11:00:00');

-- ============================================================
-- STEP 13: INSERT WEATHER
-- ============================================================

INSERT INTO tblWeather (WeatherID, EventID, Temperature, WeatherCondition, WindSpeed, Humidity, ForecastTime) VALUES
    (1, 1, 22.50, 'Partly Cloudy', 12.00, 68, '2026-09-12 06:00:00'),
    (2, 2, 23.00, 'Sunny', 10.50, 62, '2026-10-10 06:00:00'),
    (3, 3, 21.00, 'Clear', 8.00, 60, '2026-11-07 06:00:00');


-- ============================================================
-- STEP 14: INSERT ROUTES
-- Each event has a route.
-- ============================================================

INSERT INTO tblRoutes (RouteID, EventID, RouteName, DistanceKM, ElevationGain, StartPoint, RouteEndPoint, MapDataURL) VALUES
(1, 1, 'Durban Beachfront Route', 10.00, 85.00,
    'Moses Mabhida Stadium', 'Golden Mile',
    'https://www.google.com/maps/dir/?api=1&origin=Moses+Mabhida+Stadium,+Durban,+South+Africa&destination=Golden+Mile,+Durban,+South+Africa'),

(2, 2, 'Umhlanga Charity Route', 21.10, 140.00,
    'Umhlanga Arch', 'Umhlanga Promenade',
    'https://www.google.com/maps/dir/?api=1&origin=Umhlanga+Arch,+1+Ncondo+Place,+Umhlanga,+South+Africa&destination=Umhlanga+Promenade,+Umhlanga,+South+Africa'),

(3, 3, 'Richards Bay Spring Route', 15.00, 95.00,
    'Richards Bay Waterfront', 'Enseleni Road',
    'https://www.google.com/maps/dir/?api=1&origin=Richards+Bay+Waterfront,+Richards+Bay,+South+Africa&destination=Enseleni+Road,+Richards+Bay,+South+Africa');


-- ============================================================
-- STEP 15: INSERT CATEGORIES
-- Categories are linked to both an Event and its Route.
-- Each of the three events has multiple categories.
-- ============================================================

INSERT INTO tblCategory (CategoryID, EventID, RouteID, CategoryName, DistanceKM, EntryFee, MaxParticipants, GenderRestriction, AgeGroup) VALUES
(1, 1, 1, '10 KM Open', 10.00, 150.00, 500, 'Open', '18+'),
(2, 1, 1, '10 KM Women', 10.00, 150.00, 300, 'Female', '18+'),
(3, 2, 2, 'Half Marathon Open', 21.10, 250.00, 600, 'Open', '18+'),
(4, 2, 2, 'Half Marathon Women', 21.10, 250.00, 350, 'Female', '18+'),
(5, 3, 3, '15 KM Open', 15.00, 180.00, 400, 'Open', '18+'),
(6, 3, 3, '15 KM Juniors', 15.00, 100.00, 200, 'Open', '13-17');


-- ============================================================
-- STEP 16: INSERT REGISTRATIONS
-- Sample participant enrolments.
-- ============================================================

INSERT INTO tblRegistrations (RegistrationID, UserID, CategoryID, RegistrationDate, BibNumber, RegistrationStatus) VALUES
(1, 3, 1, '2026-06-01 09:30:00', 1001, 'Confirmed'),
(2, 4, 1, '2026-06-02 10:15:00', 1002, 'Confirmed'),
(3, 3, 3, '2026-06-05 11:00:00', 2001, 'Confirmed'),
(4, 4, 4, '2026-06-06 12:20:00', 2002, 'Confirmed'),
(5, 3, 5, '2026-06-10 14:00:00', 3001, 'Confirmed');


-- ============================================================
-- STEP 17: INSERT RESULTS
-- Results are optional because a registration may exist
-- before the participant completes the event.
-- ============================================================

INSERT INTO tblResults (ResultID, RegistrationID, StartTime, FinishTime, Position, Pace, ResultStatus) VALUES
(1, 1, '07:00:00', '07:52:30', 12, 5.25, 'Completed'),
(2, 2, '07:00:00', '08:05:10', 25, 6.52, 'Completed'),
(3, 3, '06:30:00', '08:18:45', 18, 5.11, 'Completed');


-- ============================================================
-- STEP 18: BASIC VERIFICATION QUERIES
-- These queries confirm that the inserted data and
-- relationships can be retrieved successfully.
-- ============================================================

SELECT * FROM tblRoles;
SELECT * FROM tblUsers;
SELECT * FROM tblEvents;
SELECT * FROM tblWeather;
SELECT * FROM tblRoutes;
SELECT * FROM tblCategory;
SELECT * FROM tblRegistrations;
SELECT * FROM tblResults;

-- ============================================================
-- END OF RACEDAY DATABASE SCRIPT
-- ============================================================
