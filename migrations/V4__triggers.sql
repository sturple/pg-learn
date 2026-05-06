
-- triggers
CREATE OR REPLACE FUNCTION register_user_on_login()
RETURNS event_trigger
SECURITY DEFINER -- Runs with the privileges of the function creator
LANGUAGE plpgsql AS $$
BEGIN
    -- Only perform writes if the database is NOT in recovery (read-only mode)
    IF NOT pg_is_in_recovery() THEN
        INSERT INTO users (username)
        VALUES (session_user)
        ON CONFLICT (username) 
        DO UPDATE SET last_login_at = NOW(); -- Updates the timestamp if they already exist
    END IF;
END;
$$;
CREATE EVENT TRIGGER trg_user_login 
ON login
EXECUTE FUNCTION register_user_on_login();
ALTER EVENT TRIGGER trg_user_login ENABLE ALWAYS;