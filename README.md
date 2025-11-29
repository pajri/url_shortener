# URL Shortener

A small, self-hosted URL shortening service. This repository provides a backend and minimal frontend to create short, shareable links that redirect to long target URLs. It includes basic analytics, configurable expiration, and an API for integrations.

## Features
- Create short aliases for long URLs
- HTTP redirect for short aliases
- Optional expiration time for links
- Basic click analytics (count, timestamps)
- REST API for programmatic use
- Simple web UI for creating and managing links
- Docker support for easy deployment

## Repository layout
- README.md — this file
- app/ — application source (API, frontend)
- migrations/ — database migrations
- tests/ — automated tests
- Dockerfile, docker-compose.yml — containerization
- .env.example — example environment variables

(Adjust paths above if your project structure differs.)

## Quickstart (local)
Prerequisites:
- Git
- Docker & docker-compose (recommended) or language runtime (e.g. Python 3.9+, Node.js 16+)
- A database (Postgres, SQLite for development)

Using Docker (recommended):
1. Copy env example:
    cp .env.example .env
2. Start services:
    docker-compose up --build
3. Open http://localhost:8000 (or the port defined in .env)

Using local runtime:
1. Copy env example and install deps:
    cp .env.example .env
    # Example for Python
    python -m venv venv
    source venv/bin/activate
    pip install -r requirements.txt
    # Example for Node
    npm install
2. Run database migrations:
    # Python example
    alembic upgrade head
    # Node example
    npm run migrate
3. Start the app:
    # Python
    flask run
    # Node
    npm start

## Environment variables
Populate .env with at least:
- APP_HOST=0.0.0.0
- APP_PORT=8000
- DATABASE_URL=postgres://user:pass@db:5432/shortener
- SECRET_KEY=replace-with-a-secret
- BASE_URL=http://localhost:8000

## API (examples)
Create a short URL:
POST /api/shorten
Request JSON:
{
  "url": "https://example.com/very/long/path",
  "custom_alias": "optional-alias",
  "expires_at": "2025-12-31T23:59:59Z"
}
Response:
{
  "short_url": "http://localhost:8000/abc123",
  "alias": "abc123",
  "expires_at": null
}

Redirect:
GET /:alias
- Redirects (302 or 301) to the target URL and increments click count.

Get link info / analytics:
GET /api/links/:alias
Response includes original URL, creation time, click count, and recent clicks.

Adjust endpoints to match your implementation.

## Data model (example)
- Link
  - id (uuid)
  - alias (string, unique)
  - target_url (string)
  - created_at (datetime)
  - expires_at (nullable datetime)
  - click_count (int)
- Click (optional)
  - id
  - link_id
  - timestamp
  - ip
  - user_agent

## Tests
Run tests with:
# Python
pytest
# Node
npm test

## Deployment
- Use the provided Dockerfile and docker-compose.yml for production containers.
- Ensure SECRET_KEY and DATABASE_URL are set securely.
- Set up a reverse proxy (Nginx) and TLS (Let's Encrypt).

## Security & privacy
- Validate and sanitize input URLs.
- Use rate limiting to prevent abuse.
- Consider optional authentication for management endpoints.
- Respect privacy when storing analytics (avoid storing unnecessary PII).

## Contributing
- Open issues for bugs or feature requests.
- Follow the code style used in the repo and include tests with changes.
- Submit PRs against the main branch.

## License
Specify a license (e.g., MIT). Add LICENSE file to the repo.

If you want, I can tailor this README to the specific tech stack used in your project — tell me which language/framework you used and any custom features.