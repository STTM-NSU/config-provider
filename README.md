# config-provider
Service that provides all secrets and starts all services.

For our services it provides:
1. Proxies list
2. Redis config
3. PostgreSQL config
4. T-Invest API key

Put `/lda_model` folder in the directory root for STTM-API

Put .env in the directory root with such structure:
```env
PROXIES=proxy1,proxy2,proxy3
REDIS_HOST=localhost
REDIS_PORT=6783
REDIS_INSIGHT_PORT=8001
REDIS_PASSWORD=password
POSTGRES_HOST=localhost
POSTGRES_PORT=5432
POSTGRES_USERNAME=someuser
POSTGRES_PASSWORD=password
POSTGRES_DB_NAME=name
T_INVEST_API_TOKEN=token
```
