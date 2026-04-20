-- 14.1
SELECT
    CONCAT(u.FName, ' ', u.LName) AS Full_Name,
    COALESCE(f.Faculty_Name, 'No Faculty') AS Faculty_Name,
    COALESCE(d.Dept_Name, 'No Department') AS Dept_Name,
    u.Score AS User_Score,
    COALESCE(SUM(p.Fine), 0) AS Total_Fines,
    COUNT(p.Penalty_ID) AS Penalty_Count
FROM
    Users u
LEFT JOIN
    Department d ON u.Dept_ID = d.Dept_ID
LEFT JOIN
    Faculty f ON d.Faculty_ID = f.Faculty_ID
INNER JOIN
    Transactions t ON u.User_ID = t.Requester_ID
INNER JOIN
    Penalty p ON t.T_ID = p.T_ID
GROUP BY
    u.User_ID,
    u.FName,
    u.LName,
    f.Faculty_Name,
    d.Dept_Name,
    u.Score
HAVING
    COUNT(p.Penalty_ID) > 1
ORDER BY
    Total_Fines DESC,
    Penalty_Count DESC,
    Full_Name ASC;

-- 14.2
WITH transaction_durations AS (
    SELECT
        t.T_ID,
        d.Faculty_ID,
        (t.Return_Time - t.Pickup_Time) AS duration
    FROM Transactions t
    JOIN Users u ON t.Requester_ID = u.User_ID
    JOIN Department d ON u.Dept_ID = d.Dept_ID
    WHERE t.Return_Time IS NOT NULL 
      AND t.Pickup_Time IS NOT NULL
)
SELECT
    f.Faculty_ID,
    f.Faculty_Name,
    COALESCE(SUM(td.duration), INTERVAL '0 days') AS total_borrow_time
FROM Faculty f
LEFT JOIN transaction_durations td ON f.Faculty_ID = td.Faculty_ID
GROUP BY f.Faculty_ID, f.Faculty_Name
ORDER BY total_borrow_time DESC, f.Faculty_Name ASC;

-- 14.3
SELECT
    e.Equipment_ID,
    et.Label AS Equipment_Label,
    
    COALESCE((
        SELECT STRING_AGG(c.Category_Label, ', ')
        FROM Part_Of po
        JOIN Category c ON po.Category_ID = c.Category_ID
        WHERE po.Type_ID = e.Type_ID
    ), 'Uncategorized') AS Category_Label,

    COALESCE((
        SELECT COUNT(*)
        FROM Transactions t
        WHERE t.Lending = e.Equipment_ID
    ), 0) AS Total_Borrows,

    (
        SELECT AVG(r.Stars)::NUMERIC(3,2)
        FROM Transactions t
        JOIN Review r ON t.T_ID = r.T_ID
        WHERE t.Lending = e.Equipment_ID
    ) AS Avg_Stars,

    COALESCE((
        SELECT SUM(p.Fine)
        FROM Transactions t
        JOIN Penalty p ON t.T_ID = p.T_ID
        WHERE t.Lending = e.Equipment_ID
    ), 0) AS Total_Fines,

    COALESCE((
        SELECT COUNT(DISTINCT img.Image_ID)
        FROM (
            SELECT e.Cover_Image AS Image_ID
            UNION ALL
            SELECT Pickup_Image 
            FROM Transactions 
            WHERE Lending = e.Equipment_ID AND Pickup_Image IS NOT NULL
            UNION ALL
            SELECT Return_Image 
            FROM Transactions 
            WHERE Lending = e.Equipment_ID AND Return_Image IS NOT NULL
        ) AS img
        WHERE img.Image_ID IS NOT NULL
    ), 0) AS Image_Count

FROM Equipment e
JOIN Equipment_Type et ON e.Type_ID = et.Type_ID
ORDER BY
    Total_Borrows DESC,
    Avg_Stars DESC NULLS LAST,
    Equipment_Label ASC;
