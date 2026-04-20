INSERT INTO Faculty (Faculty_Name) 
VALUES 
    ('Faculty of Engineering'),
    ('Faculty of Science');

INSERT INTO Department (Faculty_ID, Dept_Name) 
VALUES 
    (1, 'Robotics and Artificial Intelligence'),
    (1, 'Computer Engineering');

INSERT INTO "User" (Score, FName, LName, Dept_ID) 
VALUES 
    (100, 'Saranyapong', 'Wongrintramaytee', 1),
    (100, 'Sorrawit', 'Poomseetong', 2),
    (100, 'Pralod', 'Charoenvanitchakorn', 1),
    (100, 'Phrompiriya', 'Minbumrung', 1),
    (100, 'Professor', 'Redacted', 1);

INSERT INTO Image (Image_Path) 
VALUES 
    ('/images/equipment/cubemars_motor.jpg'),
    ('/images/equipment/vr_controller.jpg'),
    ('/images/equipment/gpu_node.jpg'),
    ('/images/transactions/pickup_proof_1.jpg'),
    ('/images/transactions/return_proof_1.jpg');

INSERT INTO Category (Category_Label) 
VALUES 
    ('Robotics'),
    ('Actuators'),
    ('Hydraulic'),
    ('Computing'),
    ('Virtual Reality');

INSERT INTO Contain (Parent_ID, Child_ID) 
VALUES 
    (1, 2),
    (2, 3);

INSERT INTO Equipment_Type (Label, Cost, Spec_Doc) 
VALUES 
    ('Cubemars Motor', 1500.00, '<Dummy Object ID>'),
    ('VR Controller', 350.00, '<Dummy Object ID>'),
    ('GPU Node', 15000.00, '<Dummy Object ID>');

INSERT INTO Part_Of (Category_ID, Type_ID)
VALUES
    (2, 1), -- Cubemars Motor is an Actuator
    (5, 2), -- VR Controller is Virtual Reality
    (4, 3); -- GPU Node is Computing

-- Status Legend: 1 = Available, 2 = Lent Out, 3 = Under Maintenance
INSERT INTO Equipment (Type_ID, Current_Status, AccessRule_Doc, Owner_ID, Cover_Image)
VALUES
    (1, 1, '<Dummy Object ID>', 5, 1),
    (1, 2, '<Dummy Object ID>', 5, 1),
    (2, 1, '<Dummy Object ID>', 5, 2),
    (3, 1, '<Dummy Object ID>', 5, 3);

INSERT INTO "Transaction" (Status, Request_Time, Approve_Time, Pickup_Time, Return_Time, Due_Time, Requester_ID, Lending, Pickup_Image, Return_Image)
VALUES
    ('Returned', '2026-04-10 09:00:00', '2026-04-10 10:30:00', '2026-04-11 14:00:00', '2026-04-16 11:00:00', '2026-04-15 17:00:00', 1, 1, 4, 5),
    ('Approved', '2026-04-19 15:30:00', '2026-04-20 09:15:00', NULL, NULL, '2026-04-25 17:00:00', 2, 2, NULL, NULL);

INSERT INTO Penalty (T_ID, Fine, Score_deduction, Reason)
VALUES
    (1, 50.00, 10, 'Item returned 1 day past the approved due date.');

INSERT INTO Review (T_ID, Stars)
VALUES
    (1, 4);
