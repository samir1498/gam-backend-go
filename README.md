# Green Algeria Map — Go API

Standalone Go 1.26 implementation of the GAM API (Chi, pgx, BetterAuth). One of
four implementations that all obey `gam-contract`.

Real repo, not a benchmark fixture: own CI, own migrations, own Dockerfile, own
image.

## Run the full app

```bash
git submodule update --init --recursive
docker compose up --build
# UI   http://localhost:3000
# API  http://localhost:8082
```

The API image runs `goose up` on start, then serves. The `frontend/` submodule is
the single copy of the GAM UI from `gam-frontend`; change it there, bump the
pointer here.

## API only

```bash
make run
make test-unit
make test-it
make migrate-up DATABASE_URL=postgres://greenalgeria:greenalgeria@localhost:5432/greenalgeria
```

## Scope

Contract surface only: auth, zones, damage reports, uploads. Pinned to a contract
version — no feature race with NestJS.
