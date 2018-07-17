# Utrust Payment Confirmation

This project is separated into two apps, Core and WebApi.

The Core app confirms transaction when it has at least 2 confirmations. The Core app could be used as command-line application or called in other umbrella apps as well.

WebApi is Pheonix application including REST API (scope `api/v1/`) and very simple React application (scope `/`). REST API and WEB application are in one module and when the app will crease they could be separated.

## ENV
  * API_KEY="YourApiKeyToken"

## Umbrella Structure
```bash
├── apps
│   ├── core
│   └── web_api
├── config
├── .formatter
├── .gitignore
├── mix.exs
├── mix.lock
└── README.md
```

## Core
  * Install dependencies with `mix deps.get`
  * Run cmd app `API_KEY="YourApiKeyToken" iex -S mix`

## WebApi
  REST API and web client. The client fills the input at web application with txhash and submit. REST API returns the confirmation status of transaction or error when transaction doesn't exist. WebApi uses Core application.
  * Install dependencies with `mix deps.get`
  * Install Node.js dependencies with `npm install`
  * Start Phoenix endpoint with `API_KEY="YourApiKeyToken" mix phoenix.server`

### JS
  Simple React Application using Brunch (Next time I would like to use Webpack)
  * eslint - `npm lint` (airbnb rules)

## Tests
  * all tests: `mix test`
  * Core `cd ./apps/core ; mix test`
  * WebApi `cd ./apps/web_api ; mix test`

## Credo
 * `mix credo apps/core/`
 * `mix credo apps/web_api/`

 ## Possible next steps
  * More tests - ``
  * Cypress tests for frontend
  * Cors - handle specific clients
  * Add Dializer
  * Different environment (stage, production, test)
  * CI - running test and coverage at CI
  * Automatic deployment process

