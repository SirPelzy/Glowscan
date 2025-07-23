# GlowScan Backend

This repository contains the complete backend codebase for GlowScan, an AI-powered skin analyzer and personalized skincare routine builder.

## Tech Stack

* **API:** Node.js with Express.js (TypeScript)
* **AI Microservice:** Python with FastAPI, OpenCV, and MediaPipe
* **Database:** PostgreSQL (managed via Supabase) with Prisma ORM
* **Authentication:** Passport.js (Local, JWT, Social OAuth)
* **Image Storage:** S3-Compatible (AWS S3, Cloudflare R2, Backblaze B2)
* **Billing:** Paddle API for subscriptions
* **Infrastructure:** Docker

---

## Project Setup

### 1. Clone the Repository
```bash
git clone <your-repository-url>
cd glowscan-backend
```

### 2. Configure Environment Variables
There is an `.env.example` file in the `node-api/` directory. Create a copy of it named `.env` and fill in the required values.

```bash
cp node-api/.env.example node-api/.env
```

**Key variables to set:**
* `DATABASE_URL`: Your Supabase PostgreSQL connection string.
* `JWT_SECRET`: A long, random string for signing tokens.
* `AWS_...`: Your credentials for your chosen S3-compatible storage provider.
* `AI_SERVICE_URL`: Set this to `http://python-ai-service:8000` for Docker. For local development, it will be `http://localhost:8000`.
* Social login and Paddle API keys.

### 3. Database Migration
With your `DATABASE_URL` set, run the initial Prisma migration to create your database tables.

```bash
cd node-api
npm install
npx prisma migrate dev --name init
cd ..
```

---

## Running the Application

### Using Docker (Recommended)

This is the easiest way to run both the API and the AI service together.

1.  **Build and Start the Containers:**
    From the root `glowscan-backend/` directory, run:
    ```bash
    docker-compose up --build
    ```
    To run in the background, use `docker-compose up -d --build`.

2.  **Accessing the Services:**
    * **Node.js API:** `http://localhost:3000`
    * **Python AI Service:** `http://localhost:8000`

### Local Development (Without Docker)

You can also run each service separately.

* **Run Node.js API:**
    ```bash
    cd node-api
    npm install
    npm run dev
    ```

* **Run Python AI Service:**
    ```bash
    cd python-ai-service
    pip install -r requirements.txt
    uvicorn main:app --reload
    ```

---

## Deploying to Production

1.  **Containerize:** Use the provided `Dockerfile`s to build images for your services. You can push these images to a container registry like Docker Hub or AWS ECR.
2.  **Choose a Host:** Deploy on a cloud provider like **DigitalOcean** or **AWS EC2/Lightsail**.
3.  **Run Containers:** On your server, you can use Docker Compose to pull the images and run the containers, just like in development.
4.  **Database:** Ensure your production server's firewall allows connections to your Supabase database.
5.  **CDN:** For best performance, use a CDN like **AWS CloudFront** in front of your S3-compatible storage bucket.

---

## Pushing to GitHub

1.  **Initialize Git:**
    If you cloned the repo, it's already a git repository. If you're starting from scratch:
    ```bash
    git init
    ```

2.  **Create `.gitignore`:**
    Make sure you have a `.gitignore` file in the root directory to exclude `node_modules`, `.env` files, and other artifacts. You can combine standard Node and Python gitignore templates.

3.  **Add, Commit, and Push:**
    ```bash
    git add .
    git commit -m "Initial commit of the GlowScan backend"
    git branch -M main
    git remote add origin <your-github-repository-url>
    git push -u origin main
    ```
