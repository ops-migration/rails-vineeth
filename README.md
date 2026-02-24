# TaskManager — Rails + Thruster + Docker

A full-stack Ruby on Rails 7 application with a **UI** and **REST API**, containerized with **Docker** and served by the **Thruster** HTTP accelerator.

## Stack

| Component | Technology |
|---|---|
| Framework | Ruby on Rails 7.1 |
| Web server | **Thruster** (HTTP/2 accelerator) + Puma |
| Database | PostgreSQL 16 |
| Frontend | TailwindCSS + Hotwire (Turbo + Stimulus) |
| Asset pipeline | Importmap + Propshaft |
| Containerization | Docker + Docker Compose |

---

## How Thruster Works

**Thruster** is a lightweight HTTP/2 proxy built by 37signals that sits in front of Puma. It provides:

- **HTTP/2** support out of the box
- **Asset compression** (gzip/brotli)
- **X-Sendfile** acceleration for file downloads
- **Automatic SSL** via Let's Encrypt (in production)
- Zero configuration — replace `rails server` with `thrust rails server`

```
Client → Thruster (:80) → Puma (:3000) → Rails app
```

---

## Quick Start with Docker

### 1. Clone and configure

```bash
git clone <repo-url>
cd rails-app
cp .env.example .env
# Edit .env and set RAILS_MASTER_KEY
```

Generate a master key if you don't have one:
```bash
docker run --rm ruby:3.3.0-slim bin/sh -c "gem install rails && rails secret"
```

### 2. Build and start

```bash
docker compose up --build
```

The app will:
1. Build the Rails image with all assets precompiled
2. Start PostgreSQL
3. Run `db:prepare` (creates + migrates + seeds the database)
4. Start Thruster (port 80) → Puma (port 3000)

### 3. Open the app

- **UI**: http://localhost
- **API**: http://localhost/api/v1/tasks

---

## REST API

### Base URL
```
http://localhost/api/v1
```

### Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/tasks` | List all tasks |
| GET | `/tasks?status=pending` | Filter by status |
| GET | `/tasks/:id` | Get a task |
| POST | `/tasks` | Create a task |
| PATCH | `/tasks/:id` | Update a task |
| DELETE | `/tasks/:id` | Delete a task |

### Example requests

```bash
# List all tasks
curl http://localhost/api/v1/tasks

# Filter by status
curl "http://localhost/api/v1/tasks?status=in_progress"

# Create a task
curl -X POST http://localhost/api/v1/tasks \
  -H "Content-Type: application/json" \
  -d '{"task": {"title": "New task", "status": "pending", "description": "Details here"}}'

# Update a task
curl -X PATCH http://localhost/api/v1/tasks/1 \
  -H "Content-Type: application/json" \
  -d '{"task": {"status": "completed"}}'

# Delete a task
curl -X DELETE http://localhost/api/v1/tasks/1
```

### Response format

```json
{
  "data": {
    "id": 1,
    "title": "Set up Rails application",
    "description": "Initialize the project",
    "status": "completed",
    "due_date": "2024-01-08",
    "created_at": "2024-01-01T00:00:00.000Z",
    "updated_at": "2024-01-01T00:00:00.000Z"
  }
}
```

---

## Development (without Docker)

```bash
bundle install
rails db:setup
bin/dev  # starts Thruster + TailwindCSS watcher
```

---

## Project Structure

```
rails-app/
├── Dockerfile               # Multi-stage build
├── docker-compose.yml       # Services: web (Thruster+Rails) + db (Postgres)
├── .env.example             # Environment variable template
├── config/
│   ├── puma.rb              # Puma config (Thruster uses THRUSTER_TARGET_PORT)
│   ├── routes.rb            # UI + API routes
│   └── database.yml
├── app/
│   ├── controllers/
│   │   ├── tasks_controller.rb          # UI controller
│   │   └── api/v1/tasks_controller.rb   # API controller
│   ├── models/task.rb
│   └── views/tasks/                     # HTML views (TailwindCSS)
└── db/
    ├── migrate/
    └── seeds.rb
```
