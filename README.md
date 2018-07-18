# ETH Transaction Check

This project is separated into two apps, Core and WebApi.

The Core app marks the transaction as valid when it has at least 2 confirmations. The Core app could be used as command-line application or in other umbrella apps as well.

WebApi is Pheonix application including REST API (scope `api/v1/`) and very simple React application (scope `/`). REST API and WEB application are in one module and when the app will crease they could be separated.

Both applications include tests. The Core app includes mocked test to check functionality without Eherscan impact and WebAPI includes tests without mocks to check the whole integration. More tests are needed and It could be done as next step of development.

## ENV
  * API_KEY="YourEtherscanApiKeyToken"

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
  The Core app includes two modules. The first one is `PaymentValidation` that check a number of confirmations. The second one is `EtherscanApi` that wraps `HTTPoison.Base` functionality and provide Etherscan API.
  * Open Core folder `cd apps/core/`
  * Install dependencies with `mix deps.get`
  * Run cmd app `API_KEY="YourApiKeyToken" iex -S mix`

## WebApi
  REST API and web client. The client fills the input at web application with txhash and submit. REST API returns the confirmation status of transaction or error when something went wrong. WebApi uses Core application as umbrella dependency.
  * Open WebApi folder `cd apps/web_api/`
  * Install dependencies with `mix deps.get`
  * Install Node.js dependencies with `npm install`
  * Start Phoenix endpoint with `API_KEY="YourApiKeyToken" mix phoenix.server`

### JS
  Simple React Application using Brunch (Looking forward Webpack in next version of Phoenix)
  * eslint - `npm run lint` (airbnb rules)

## Tests
  * all tests: `mix test`
  * Core `cd ./apps/core ; mix test`
  * WebApi `cd ./apps/web_api ; mix test`

## Credo
 * `mix credo apps/core/`
 * `mix credo apps/web_api/`

## Requirements
 * Elixir 1.6
 * Node.js 8.9.3

 ## Possible next steps
  * More tests
  * Better handling api error from Etherscan
  * Cors (cors_plug, corsia, etc...)
  * Different environment (stage, production, test)
  * CI - running test and coverage at CI
  * Add Dializer
  * Use Webpack in WebApi
  * Use Yarn in WebApi
  * Cypress tests for frontend
  * Automatic deployment process

