-- +migrate Up
CREATE TABLE IF NOT EXISTS news_bows
(
    url  varchar primary key,
    bow  jsonb     not null,
    date timestamp not null -- format: yyyy:mm:dd:hh

);

CREATE TABLE IF NOT EXISTS news_done
(
    date date not null unique -- format: yyyy-mm-dd
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
    id            serial primary key,
    index         numeric   not null,
    instrument_id varchar   not null,
    from_time     timestamp not null,
    to_time       timestamp not null,
    alpha         numeric,
    p_value       numeric,
    threshold     numeric
);

CREATE TABLE IF NOT EXISTS sttm_interpretability
(
    topics         jsonb   not null, -- {"topic_0": 0, "topic_1": 1}
    tts            jsonb   not null, -- [[1,2,3], [4,5,6], ...] each internal element represents N topic probability over time
    frequent_words jsonb   not null, -- {"word1": 1232, "word2": 12312}
    sttm_index_id  integer not null,
    foreign key (sttm_index_id) references sttm_indexes (id) on delete cascade
);

CREATE TABLE IF NOT EXISTS trading_journal
(
    ts   timestamp not null,
    op   varchar   not null,
    data jsonb
);

-- +migrate Down
DROP TABLE IF EXISTS trading_journal;
DROP TABLE IF EXISTS sttm_interpretability;
DROP TABLE IF EXISTS sttm_indexes;
DROP TABLE IF EXISTS stocks;
DROP TABLE IF EXISTS instruments;
DROP TABLE IF EXISTS news_done;
DROP TABLE IF EXISTS news_bows;
