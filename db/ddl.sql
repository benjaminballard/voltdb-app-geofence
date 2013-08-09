-------------------- EXAMPLE SQL -----------------------------------------------
-- CREATE TABLE example_of_types (
--   id              INTEGER NOT NULL, -- java int, 4-byte signed integer, -2,147,483,647 to 2,147,483,647
--   name            VARCHAR(40),      -- java String
--   data            VARBINARY(256),   -- java byte array 
--   status          TINYINT,          -- java byte, 1-byte signed integer, -127 to 127
--   type            SMALLINT,         -- java short, 2-byte signed integer, -32,767 to 32,767
--   pan             BIGINT,           -- java long, 8-byte signed integer, -9,223,372,036,854,775,807 to 9,223,372,036,854,775,807
--   balance_open    FLOAT,            -- java double, 8-byte numeric
--   balance         DECIMAL,          -- java BigDecimal, 16-byte fixed scale of 12 and precision of 38
--   last_updated    TIMESTAMP,        -- java long, org.voltdb.types.TimestampType, 8-byte signed integer (milliseconds since epoch)
--   CONSTRAINT pk_example_of_types PRIMARY KEY (id)
-- );
-- PARTITION TABLE example_of_types ON COLUMN id;
-- CREATE INDEX idx_example_pan ON example_of_types (pan);
--
-- CREATE VIEW view_example AS 
--  SELECT type, COUNT(*) AS records, SUM(balance)
--  FROM example_of_types
--  GROUP BY type;
-- 
-- CREATE PROCEDURE foo AS SELECT * FROM foo;
-- CREATE PROCEDURE FROM CLASS procedures.UpsertSymbol;
-- PARTITION PROCEDURE UpsertSymbol ON TABLE symbols COLUMN symbol PARAMETER 0;
---------------------------------------------------------------------------------

CREATE TABLE devices (
  id                     INTEGER       NOT NULL,
  home_zip               VARCHAR(5),
  home_lat               FLOAT,
  home_long              FLOAT,
  has_geofence           TINYINT,
  fence_radius           FLOAT,
  inside_geofence        TINYINT,
  CONSTRAINT pk_devices PRIMARY KEY (id)
);
PARTITION TABLE devices ON COLUMN id;


CREATE TABLE device_location (
  id                     INTEGER       NOT NULL,
  ts                     TIMESTAMP     NOT NULL,
  pos_lat                FLOAT         NOT NULL,
  pos_long               FLOAT         NOT NULL
);
PARTITION TABLE device_location ON COLUMN id;
CREATE INDEX idx_device_location ON device_location (id,ts);

CREATE TABLE device_event (
  id                     INTEGER       NOT NULL,
  ts                     TIMESTAMP     NOT NULL,
  is_exit                TINYINT,
  is_entry               TINYINT
);
PARTITION TABLE device_event ON COLUMN id;


