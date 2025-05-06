-- +migrate Up
CREATE TABLE IF NOT EXISTS news_bows
(
    date timestamp not null unique,
    bow  jsonb     not null
);

CREATE TABLE IF NOT EXISTS instruments
(
    id                varchar primary key,
    first_candle_date timestamp not null
);

CREATE TABLE IF NOT EXISTS stocks
(
    instrument_id varchar   not null,
    ts            timestamp not null,
    close_price   numeric   not null
);

CREATE TABLE IF NOT EXISTS sttm_indexes
(
    index         numeric   not null,
    instrument_id varchar   not null,
    from_time     timestamp not null,
    to_time       timestamp not null
);

-- +migrate Down
DROP TABLE IF EXISTS sttm_indexes;
DROP TABLE IF EXISTS stocks;
DROP TABLE IF EXISTS instruments;
DROP TABLE IF EXISTS news_bows;
