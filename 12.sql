-- T1
DROP TRIGGER IF EXISTS trg_ensure_request_time ON Transactions;

CREATE OR REPLACE FUNCTION fn_ensure_request_time()
RETURNS TRIGGER
LANGUAGE plpgsql AS $$
BEGIN
    -- ถ้า Request_Time ไม่ได้ส่งมาจะตั้งค่าเป็นเวลาปัจจุบันอัตโนมัติ
    IF NEW.Request_Time IS NULL THEN
        NEW.Request_Time := CURRENT_TIMESTAMP;
    END IF;
    
    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_ensure_request_time
BEFORE INSERT ON Transactions
FOR EACH ROW 
EXECUTE FUNCTION fn_ensure_request_time();

-- Test1
INSERT INTO Transactions (Status, Requester_ID, Lending)
VALUES ('pending', 11, 4)
RETURNING T_ID, Status, Requester_ID, Lending, Request_Time;

-- T2

DROP TRIGGER IF EXISTS trg_sanitize_review_score ON Review;

CREATE OR REPLACE FUNCTION fn_sanitize_review_score()
RETURNS TRIGGER
LANGUAGE plpgsql AS $$
BEGIN
    -- จำกัดคะแนนรีวิวให้อยู่ระหว่าง 1 - 5
    IF NEW.Stars IS NULL THEN
        NEW.Stars := 1;                    -- ถ้าไม่ใส่ ให้ default เป็น 1
    ELSIF NEW.Stars < 1 THEN
        NEW.Stars := 1;
    ELSIF NEW.Stars > 5 THEN
        NEW.Stars := 5;
    END IF;

    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_sanitize_review_score
BEFORE INSERT ON Review
FOR EACH ROW 
EXECUTE FUNCTION fn_sanitize_review_score();

-- Test2
INSERT INTO Review (T_ID, Stars) 
VALUES (12, 67);     -- ควรถูกปรับเป็น 5

INSERT INTO Review (T_ID, Stars) 
VALUES (12, -10);    -- ควรถูกปรับเป็น 1

INSERT INTO Review (T_ID, Stars) 
VALUES (12, NULL);   -- ควรถูกปรับเป็น 1

SELECT Review_ID, T_ID, Stars 
FROM Review 
WHERE T_ID = 12 AND Review_ID > 2000
ORDER BY Review_ID;
