 # URL Shortener

 A small Rails application to create short URLs with an interstitial advertisement/preview page before redirecting users to the target URL.

 ## Features
 - Create short URLs that expire after 30 days.
 - Interstitial preview page that shows an advertisement and a "Continue to your link" CTA.
 - Short code generation using secure random alphanumeric codes.
 - Basic advertisement models and analytics hooked into preview flow.

 ## Prerequisites
 - Ruby (recommended 3.1+ — use the version in `.ruby-version` if present)
 - Bundler
 - PostgreSQL (or edit `config/database.yml` for your DB)
 - Node/npm only if you add additional JS tooling (this app uses importmap by default)

 ## Quick start (development)

 1. Install dependencies

 ```bash
 # from the project root
 bundle install
 ```

 2. Configure database

 ```bash
 # create, migrate, and seed (if seeds exist)
 bin/rails db:create db:migrate db:seed
 ```

 3. Start the server

 ```bash
 # Runs on http://localhost:3000 by default
 bin/rails server
 ```

 4. Open the app

 - Visit `http://localhost:3000` to create new short URLs.
 - When visiting a generated short URL the app shows the preview/ad page; clicking "Continue to your link" posts to `/go` and redirects to the target.

 ## Linting & tests

 - Run RuboCop:

 ```bash
 bin/rubocop --parallel
 ```

 - Run the test suite:

 ```bash
 bin/rails test
 ```

 ## Contributing

 - Feel free to open issues or PRs. Follow existing code style and run `bin/rubocop --parallel` before submitting.

 ## License

 This project is open-source and available under the **MIT License**.  
 See the [LICENSE](LICENSE) file for full details.

