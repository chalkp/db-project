CREATE TABLE Faculty (
    Faculty_ID SERIAL NOT NULL PRIMARY KEY,
    Faculty_Name VARCHAR(255) NOT NULL
);

CREATE TABLE Department (
    Dept_ID SERIAL NOT NULL PRIMARY KEY,
    Faculty_ID INT NOT NULL,
    Dept_Name VARCHAR(255) NOT NULL,
    FOREIGN KEY (Faculty_ID) REFERENCES Faculty(Faculty_ID) ON DELETE CASCADE
);

CREATE TABLE Users (
    User_ID SERIAL NOT NULL PRIMARY KEY,
    Score INT,
    FName VARCHAR(255) NOT NULL,
    LName VARCHAR(255) NOT NULL,
    Dept_ID INT,
    FOREIGN KEY (Dept_ID) REFERENCES Department(Dept_ID) ON DELETE SET NULL
);

CREATE TABLE Image (
    Image_ID SERIAL NOT NULL PRIMARY KEY,
    Image_Path VARCHAR(255) NOT NULL
);

CREATE TABLE Category (
    Category_ID SERIAL NOT NULL PRIMARY KEY,
    Category_Label VARCHAR(255) NOT NULL
);

CREATE TABLE Contain (
    Parent_ID INT NOT NULL,
    Child_ID INT NOT NULL,
    PRIMARY KEY (Parent_ID, Child_ID),
    FOREIGN KEY (Parent_ID) REFERENCES Category(Category_ID) ON DELETE CASCADE,
    FOREIGN KEY (Child_ID) REFERENCES Category(Category_ID) ON DELETE CASCADE
);

CREATE TABLE Equipment_Type (
    Type_ID SERIAL NOT NULL PRIMARY KEY,
    Label VARCHAR(255) NOT NULL,
    Cost DECIMAL(10, 2) NOT NULL,
    Spec_Doc TEXT NOT NULL
);

CREATE TABLE Part_Of (
    Category_ID INT NOT NULL,
    Type_ID INT NOT NULL,
    PRIMARY KEY (Category_ID, Type_ID),
    FOREIGN KEY (Category_ID) REFERENCES Category(Category_ID) ON DELETE CASCADE,
    FOREIGN KEY (Type_ID) REFERENCES Equipment_Type(Type_ID) ON DELETE CASCADE
);

CREATE TABLE Equipment (
    Equipment_ID SERIAL NOT NULL PRIMARY KEY,
    Type_ID INT NOT NULL,
    Current_Status INT NOT NULL, 
    AccessRule_Doc TEXT,
    Owner_ID INT NOT NULL,
    Cover_Image INT NOT NULL,
    FOREIGN KEY (Type_ID) REFERENCES Equipment_Type(Type_ID),
    FOREIGN KEY (Owner_ID) REFERENCES "User"(User_ID),
    FOREIGN KEY (Cover_Image) REFERENCES Image(Image_ID)
);

CREATE TABLE Transactions (
    T_ID SERIAL NOT NULL PRIMARY KEY,
    Status VARCHAR(50) NOT NULL,
    Request_Time TIMESTAMP NOT NULL,
    Approve_Time TIMESTAMP,
    Pickup_Time TIMESTAMP,
    Return_Time TIMESTAMP,
    Due_Time TIMESTAMP,
    Requester_ID INT NOT NULL,
    Lending INT NOT NULL,
    Pickup_Image INT,
    Return_Image INT,
    FOREIGN KEY (Requester_ID) REFERENCES "User"(User_ID),
    FOREIGN KEY (Lending) REFERENCES Equipment(Equipment_ID),
    FOREIGN KEY (Pickup_Image) REFERENCES Image(Image_ID) ON DELETE SET NULL,
    FOREIGN KEY (Return_Image) REFERENCES Image(Image_ID) ON DELETE SET NULL
);

CREATE TABLE Penalty (
    Penalty_ID SERIAL NOT NULL PRIMARY KEY,
    T_ID INT NOT NULL,
    Fine DECIMAL(10, 2),
    Score_deduction INT,
    Reason TEXT,
    FOREIGN KEY (T_ID) REFERENCES "Transaction"(T_ID) ON DELETE CASCADE
);

CREATE TABLE Review (
    Review_ID SERIAL NOT NULL PRIMARY KEY,
    T_ID INT NOT NULL,
    Stars SMALLINT NOT NULL,
    FOREIGN KEY (T_ID) REFERENCES "Transaction"(T_ID) ON DELETE CASCADE
);
