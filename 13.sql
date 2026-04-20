-- A
SELECT 
    e.Equipment_ID,
    et.Label,
    et.Cost,
    et.Spec_Doc,
    e.Current_Status,
    e.Owner_ID
FROM Equipment e
JOIN Equipment_Type et ON et.Type_ID = e.Type_ID
WHERE et.Cost > 2000
ORDER BY et.Cost DESC;

-- B
WITH gadget_detail AS (
    SELECT 
        e.Equipment_ID,
        et.Label,
        et.Cost,
        et.Spec_Doc,
        e.Current_Status,
        e.Owner_ID,
        f.Faculty_Name,
        d.Dept_Name
    FROM Equipment e
    JOIN Equipment_Type et ON et.Type_ID = e.Type_ID
    LEFT JOIN Users u ON e.Owner_ID = u.User_ID
    LEFT JOIN Department d ON u.Dept_ID = d.Dept_ID
    LEFT JOIN Faculty f ON d.Faculty_ID = f.Faculty_ID
)
SELECT *
FROM gadget_detail
WHERE Cost > 2000
ORDER BY Cost DESC;
