INSERT INTO Faculty (Faculty_Name) 
VALUES 
    ('Faculty of Engineering'),
    ('Faculty of Science');

INSERT INTO Department (Faculty_ID, Dept_Name) 
VALUES 
    (1, 'Robotics and Artificial Intelligence'),
    (1, 'Electrical Engineering'),
    (1, 'Computer Engineering'),
    (2, 'Physics'),
    (2, 'Chemistry');

INSERT INTO Users (Score, FName, LName, Dept_ID) 
VALUES 
    (100, 'Professor', 'Ronnapee', 1),
    (100, 'Suttikarn', 'Panla', 2),
    (100, 'Tee', 'Hemjinda', 3),
    (100, 'Sorrawit', 'Poomseetong', 3),
    (100, 'Saranyapong', 'Wongrintramaytee', 3),
    (100, 'Pralod', 'Charoenvanitchakorn', 3),
    (100, 'Phrompiriya', 'Minbumrung', 3);

INSERT INTO Image (Image_Path)
VALUES
    ('/images/equipment/oscilloscope.jpg'),
    ('/images/equipment/3d_printer.jpg'),
    ('/images/equipment/soldering_station.jpg'),
    ('/images/equipment/drone_matrice.jpg'),
    ('/images/equipment/raspberry_pi_5.jpg');

INSERT INTO Category (Category_Label)
VALUES
    ('Electronics'),
    ('Fabrication'),
    ('Prototyping'),
    ('Aerial Robotics');

INSERT INTO Contain (Parent_ID, Child_ID)
VALUES
    (8, 6), -- Prototyping contains Electronics
    (8, 7), -- Prototyping contains Fabrication
    (1, 9); -- Robotics contains Aerial Robotics

INSERT INTO Equipment_Type (Label, Cost, Spec_Doc)
VALUES
    ('Digital Oscilloscope', 850.00, '<Dummy Object ID>'),
    ('Prusa i3 3D Printer', 999.00, '<Dummy Object ID>'),
    ('Weller Soldering Station', 150.00, '<Dummy Object ID>'),
    ('DJI Matrice Drone', 6500.00, '<Dummy Object ID>'),
    ('Raspberry Pi 5', 80.00, '<Dummy Object ID>');

INSERT INTO Part_Of (Category_ID, Type_ID)
VALUES
    (6, 4), -- Digital Oscilloscope is Electronics
    (7, 5), -- Prusa i3 is Fabrication
    (6, 6), -- Weller Soldering Station is Electronics
    (9, 7), -- DJI Matrice Drone is Aerial Robotics
    (4, 8), -- Raspberry Pi 5 is Computing (Category 4 from your original script)
    (8, 8); -- Raspberry Pi 5 is also under Prototyping

INSERT INTO Equipment (Type_ID, Current_Status, AccessRule_Doc, Owner_ID, Cover_Image)
VALUES
    (4, 1, '<Dummy Object ID>', 4, 6),  -- ID 5: Available Oscilloscope (Owned by Phrompiriya)
    (4, 3, '<Dummy Object ID>', 4, 6),  -- ID 6: Oscilloscope under maintenance
    (5, 2, '<Dummy Object ID>', 5, 7),  -- ID 7: Lent out 3D Printer (Owned by Professor)
    (5, 1, '<Dummy Object ID>', 5, 7),  -- ID 8: Available 3D Printer
    (6, 1, '<Dummy Object ID>', 2, 8),  -- ID 9: Available Soldering Station (Owned by Saranyapong)
    (6, 1, '<Dummy Object ID>', 2, 8),  -- ID 10: Another Available Soldering Station
    (7, 1, '<Dummy Object ID>', 1, 9),  -- ID 11: Available Drone (Owned by Sorrawit)
    (8, 1, '<Dummy Object ID>', 3, 10), -- ID 12: Available Raspberry Pi (Owned by Pralod)
    (8, 1, '<Dummy Object ID>', 3, 10), -- ID 13: Available Raspberry Pi
    (8, 1, '<Dummy Object ID>', 3, 10); -- ID 14: Available Raspberry Pi

INSERT INTO Transactions (Status, Request_Time, Approve_Time, Pickup_Time, Return_Time, Due_Time, Requester_ID, Lending, Pickup_Image, Return_Image)
VALUES
    ('Approved', '2026-04-18 10:00:00', '2026-04-18 11:30:00', NULL, NULL, '2026-04-22 17:00:00', 3, 7, NULL, NULL), -- Pralod borrowing the 3D Printer
    ('Returned', '2026-04-01 08:00:00', '2026-04-01 09:00:00', '2026-04-01 10:00:00', '2026-04-03 16:00:00', '2026-04-03 17:00:00', 1, 6, NULL, NULL); -- Sorrawit successfully returned a soldering station

INSERT INTO Penalty (T_ID, Fine, Score_deduction, Reason)
VALUES
    (1, 50.00, 10, 'Item returned 1 day past the approved due date.');

INSERT INTO Review (T_ID, Stars)
VALUES
    (1, 4);
