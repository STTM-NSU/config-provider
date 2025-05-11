-- +migrate Up
CREATE TABLE IF NOT EXISTS portfolios
(
    account_id     varchar primary key,
    profit_percent numeric not null default 0
);

CREATE TABLE IF NOT EXISTS balances
(
    value      numeric not null,
    currency   varchar not null,
    account_id varchar not null,
    foreign key (account_id) references portfolios (account_id) on delete cascade,
    constraint currency_account_id unique (currency, account_id)
);

ALTER TABLE instruments
    ADD COLUMN IF NOT EXISTS ticker            varchar,
    ADD COLUMN IF NOT EXISTS class_code        varchar,
    ADD COLUMN IF NOT EXISTS uid               varchar not null default '',
    ADD COLUMN IF NOT EXISTS isin              varchar,
    ADD COLUMN IF NOT EXISTS query             varchar,
    ADD COLUMN IF NOT EXISTS lot               integer not null default 0,
    ADD COLUMN IF NOT EXISTS currency          varchar not null default '',
    ADD COLUMN IF NOT EXISTS for_qual_investor bool    not null default false,
    ADD COLUMN IF NOT EXISTS exchange          varchar not null default '',
    ADD COLUMN IF NOT EXISTS exchange_section  varchar not null default '',
    ADD COLUMN IF NOT EXISTS instrument_type   varchar not null default '';

CREATE TABLE IF NOT EXISTS portfolio_instruments -- that we bought
(
    instrument_id       varchar unique,
    order_request_id    varchar not null,
    direction           varchar not null,
    entry_price         numeric not null,
    min_price_increment numeric not null,
    quantity            numeric not null,
    account_id          varchar not null,
    foreign key (instrument_id) references instruments (id) on delete cascade,
    foreign key (account_id) references portfolios (account_id) on delete cascade
);

CREATE TABLE IF NOT EXISTS trading_journal
(
    op            varchar   not null,
    description   varchar   not null,
    ts            timestamp not null default now(),
    instrument_id varchar   not null,
    foreign key (instrument_id) references instruments (id) on delete cascade
);

-- +migrate Down
DROP TABLE IF EXISTS trading_journal;
DROP TABLE IF EXISTS portfolio_instruments;
ALTER TABLE instruments
    DROP COLUMN IF EXISTS ticker,
    DROP COLUMN IF EXISTS class_code,
    DROP COLUMN IF EXISTS uid,
    DROP COLUMN IF EXISTS isin,
    DROP COLUMN IF EXISTS query,
    DROP COLUMN IF EXISTS lot,
    DROP COLUMN IF EXISTS currency,
    DROP COLUMN IF EXISTS for_qual_investor,
    DROP COLUMN IF EXISTS exchange,
    DROP COLUMN IF EXISTS exchange_section,
    DROP COLUMN IF EXISTS instrument_type;
DROP TABLE IF EXISTS balances;
DROP TABLE IF EXISTS portfolios;