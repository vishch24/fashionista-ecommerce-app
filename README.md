# Fashionista E-Commerce App — Deployed to AWS EC2 using Docker and Docker Compose

Dockerized and deployed a 3-tier (**React.js** + **Express.js/Node.js** + **PostgreSQL**) e-commerce application to AWS EC2 as part of the **TrainWithShubham DevOps Phase 1 Practical Exam**.

---

## Tech Stack

| Layer | Technology |
|---|---|
| Frontend | React.js + Nginx |
| Backend | Node.js / Express.js |
| Database | PostgreSQL |
| Containerization | Docker + Docker Compose |
| Deployment | AWS EC2 (Ubuntu 22.04) |

---

## Architecture

A 3-tier architecture with two isolated Docker networks:

- **Public Network** — nginx (port 3000) ↔ Express API (port 5000, internal only)
- **Private Network** — Express API ↔ PostgreSQL (port 5432, internal only)

Single public entry point: **port 3000 only**. API and database are never exposed to the host or internet.

---

## What Was Done

- Forked raw developer codebase with zero Docker configuration
- Wrote multi-stage Dockerfiles for `client` (nginx-unprivileged) and `api` (node-alpine with native module compilation)
- Configured nginx as a reverse proxy — browser API calls proxied internally to Express via Docker DNS
- Automated PostgreSQL seeding from binary dump (`database-backup/ecommerce.dump`) using `docker-entrypoint-initdb.d`

---

## Quick Start

```bash
git clone https://github.com/vishch24/fashionista-ecommerce-app.git
cd fashionista-ecommerce-app
cp .env.example .env   # fill in your values
docker compose up -d --build
```

Open `http://localhost:3000`

---

## Environment Variables

| Variable | Description |
|---|---|
| `POSTGRES_USER` | PostgreSQL username |
| `POSTGRES_PASSWORD` | PostgreSQL password |
| `POSTGRES_DB` | PostgreSQL database name |
| `JWT_SECRET` | JWT signing secret |
| `ACCESS_TOKEN_LIFE` | Access token expiry (e.g. `30m`) |
| `REFRESH_TOKEN_LIFE` | Refresh token expiry (e.g. `30d`) |
| `COOKIE_SECRET` | Cookie signing secret |
| `COOKIE_SECURE` | Set `false` for HTTP, `true` for HTTPS |
| `REACT_APP_RAZORPAY_KEY_ID` | Razorpay publishable key |

---

## Documentation

📄 Full exam documentation (system design, problems faced, solutions, learnings):
**[Phase 1 Practical Exam Documentation](https://github.com/vishch24/fashionista-ecommerce-app/blob/main/documentation/Phase-1-Practical-Exam-Documentation.pdf)**

---

## Acknowledgements

Special thanks to **[Shubham Londhe](https://github.com/LondheShubham153)** and the **[TrainWithShubham](https://www.trainwithshubham.com)** community for designing a practical exam that teaches real DevOps skills — Linux, Git, Networking, System Design, and Docker — applied to a problem that actually fights back.

---

*Forked from [HARSHisawesome2/fullstack-ecommerce-app](https://github.com/HARSHisawesome2/fullstack-ecommerce-app)*

Made with 💖 by Vishakha Chavan
