-- +migrate Up
CREATE UNIQUE INDEX IF NOT EXISTS unique_index_news_bows ON news_bows (date, hour);
CREATE UNIQUE INDEX IF NOT EXISTS unique_index_stocks ON stocks (instrument_id, ts);

-- +migrate Down
DROP INDEX IF EXISTS unique_news_bows;
DROP INDEX IF EXISTS unique_stocks;
