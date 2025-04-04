--this TRIGGER just for generate the Primary id with manual .
create function generate_account_id() returns trigger
    language plpgsql
as
$$
DECLARE
    last_id TEXT;
    next_id INT;
BEGIN
    SELECT user_id INTO last_id FROM "Account" ORDER BY user_id DESC LIMIT 1;
    IF last_id IS NULL THEN
        next_id := 1;
    ELSE
        next_id := CAST(SUBSTRING(last_id FROM 3) AS INT) + 1;
    END IF;

    NEW.user_id := 'AC' || LPAD(next_id::TEXT, 4, '0');
    RETURN NEW;
END;
$$;

alter function generate_account_id() owner to "user";

--this TRIGGER just for generate the Primary id with manual .
create function generate_address_id() returns trigger
    language plpgsql
as
$$
DECLARE
    last_id TEXT;
    next_id INT;
BEGIN
    SELECT address_id INTO last_id FROM "Address" ORDER BY address_id DESC LIMIT 1;
    IF last_id IS NULL THEN
        next_id := 1;
    ELSE
        next_id := CAST(SUBSTRING(last_id FROM 3) AS INT) + 1;
    END IF;

    NEW.address_id := 'AD' || LPAD(next_id::TEXT, 4, '0');
    RETURN NEW;
END;
$$;

alter function generate_account_id() owner to "user";



