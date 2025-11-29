# URL Shortener (Ruby on Rails)

A small, self-hosted Rails app that provides a backend and minimal frontend to create short, shareable links that redirect to long target URLs. Includes basic analytics, configurable expiration, and a JSON API for integrations.

## Features
- Create short aliases for long URLs
- HTTP redirect for short aliases (302/301)
- Optional expiration time for links
- Basic click analytics (count, timestamps)
- REST JSON API + simple web UI
- Docker support for easy deployment