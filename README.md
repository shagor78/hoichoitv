# Hoichoi IPTV - Premium Live TV Streaming Platform

A production-ready, enterprise-level IPTV streaming platform supporting 1000+ channels with automatic stream failover, Netflix-like UI, complete admin panel, and payment integration.

---

## Features

- **1000+ TV Channel Support** -- Bulk import via M3U/TXT files
- **Adaptive HLS/M3U8 Streaming** -- Powered by HLS.js with quality switching
- **Automatic Stream Health Monitoring & Failover** -- Real-time health scores, automatic fallback to backup streams
- **Netflix/YouTube-inspired Dark UI** -- Hero slider, responsive channel grids, skeleton loading
- **Custom IPTV Player** -- Fullscreen, volume, quality selection, stream switching
- **Real-time Stream Status** -- Online/offline/buffering indicators with health scores
- **Multi-device Support** -- Device session tracking per subscription plan limits
- **User Authentication** -- JWT (Access + Refresh tokens), forgot/reset password, 2FA support
- **Subscription Plans** -- Basic / Premium / Pro with configurable features
- **Payment Gateway Integration** -- SSLCommerz, bKash, Nagad, Rocket, Stripe, PayPal
- **Complete Admin Panel** -- Dashboard, CRUD for all entities, analytics, monitoring, settings
- **Channel Bulk Import** -- Upload M3U/TXT files to import thousands of channels at once
- **EPG (Electronic Program Guide)** -- Now playing, upcoming programs per channel
- **Favorites & Watch History** -- Personalized user experience
- **Dark/Light Mode** -- Theme toggle persisted per user
- **Fully Responsive** -- Mobile, tablet, desktop
- **PWA Ready** -- Installable on any device
- **Docker Deployment** -- One-command setup with Docker Compose

## Tech Stack

| Layer     | Technology                                                  |
|-----------|-------------------------------------------------------------|
| Frontend  | React 18 + Vite 5 + Tailwind CSS + HLS.js + Video.js      |
| Backend   | Node.js + Express.js                                        |
| Database  | MySQL 8.0 (via Sequelize ORM)                               |
| Cache     | Redis 7                                                     |
| Auth      | JWT (Access + Refresh tokens) + bcrypt                      |
| Container | Docker + Docker Compose                                     |
| Proxy     | Nginx                                                       |

## Project Structure

```
HoichoiTV/
├── backend/
│   ├── src/
│   │   ├── config/              # Database, Redis, env config
│   │   ├── controllers/         # Route handlers
│   │   │   ├── admin.controller.js
│   │   │   ├── auth.controller.js
│   │   │   ├── category.controller.js
│   │   │   ├── channel.controller.js
│   │   │   ├── epg.controller.js
│   │   │   ├── favorite.controller.js
│   │   │   ├── health.controller.js
│   │   │   ├── history.controller.js
│   │   │   ├── subscription.controller.js
│   │   │   ├── transaction.controller.js
│   │   │   └── upload.controller.js
│   │   ├── middleware/           # Auth, validation, error handling
│   │   ├── models/              # Sequelize models
│   │   ├── routes/              # API route definitions
│   │   │   ├── index.js         # Route aggregator
│   │   │   ├── admin.routes.js
│   │   │   ├── auth.routes.js
│   │   │   ├── category.routes.js
│   │   │   ├── channel.routes.js
│   │   │   ├── epg.routes.js
│   │   │   ├── favorite.routes.js
│   │   │   ├── health.routes.js
│   │   │   ├── history.routes.js
│   │   │   ├── subscription.routes.js
│   │   │   ├── transaction.routes.js
│   │   │   └── upload.routes.js
│   │   ├── services/            # Business logic
│   │   │   ├── channelParser.js     # M3U/TXT parsing
│   │   │   ├── emailService.js      # SMTP email
│   │   │   ├── notificationService.js
│   │   │   ├── paymentGateway.js    # Multi-gateway integration
│   │   │   └── streamMonitor.js     # Health check & failover
│   │   └── utils/               # Helpers, validators
│   └── uploads/                 # User uploads (avatars, logos)
├── database/
│   └── schema.sql               # Full MySQL schema + seed data
├── frontend/
│   ├── public/                  # Static assets, PWA manifest
│   ├── src/
│   │   ├── components/
│   │   │   ├── admin/
│   │   │   │   └── AdminLayout.jsx
│   │   │   ├── ChannelCard.jsx
│   │   │   ├── ChannelGrid.jsx
│   │   │   ├── Footer.jsx
│   │   │   ├── HeroSlider.jsx
│   │   │   ├── IPTVPlayer.jsx
│   │   │   ├── Layout.jsx
│   │   │   ├── LoadingSkeleton.jsx
│   │   │   ├── Modal.jsx
│   │   │   ├── Navbar.jsx
│   │   │   ├── Pagination.jsx
│   │   │   ├── PrivateRoute.jsx
│   │   │   ├── SearchOverlay.jsx
│   │   │   └── VideoPlayer.jsx
│   │   ├── context/
│   │   │   ├── AuthContext.jsx
│   │   │   └── ThemeContext.jsx
│   │   ├── hooks/
│   │   ├── pages/
│   │   │   ├── admin/
│   │   │   │   ├── Analytics.jsx
│   │   │   │   ├── Categories.jsx
│   │   │   │   ├── Channels.jsx
│   │   │   │   ├── Dashboard.jsx
│   │   │   │   ├── EPG.jsx
│   │   │   │   ├── Monitoring.jsx
│   │   │   │   ├── Settings.jsx
│   │   │   │   ├── Subscriptions.jsx
│   │   │   │   ├── Transactions.jsx
│   │   │   │   └── Users.jsx
│   │   │   ├── CategoryPage.jsx
│   │   │   ├── Channels.jsx
│   │   │   ├── Dashboard.jsx
│   │   │   ├── Favorites.jsx
│   │   │   ├── ForgotPassword.jsx
│   │   │   ├── History.jsx
│   │   │   ├── Home.jsx
│   │   │   ├── Login.jsx
│   │   │   ├── Payments.jsx
│   │   │   ├── Player.jsx
│   │   │   ├── Profile.jsx
│   │   │   ├── Register.jsx
│   │   │   ├── Search.jsx
│   │   │   └── Subscription.jsx
│   │   ├── services/
│   │   │   └── api.js           # Axios instance with interceptors
│   │   ├── utils/
│   │   ├── App.jsx              # Route definitions (React Router v6)
│   │   ├── index.css            # Tailwind directives + custom styles
│   │   └── main.jsx             # Entry point
│   ├── package.json
│   ├── postcss.config.js
│   ├── tailwind.config.js
│   └── vite.config.js
├── nginx/                       # Reverse proxy config
├── sample_data/
│   └── tv_channels.txt          # Sample M3U playlist (1000+ channels)
└── scripts/                     # Deployment & utility scripts
```

## Quick Start

### Prerequisites

- **Node.js 18+** and npm/yarn
- **MySQL 8.0**
- **Redis 7** (optional, for caching)
- **Docker & Docker Compose** (optional, for containerized setup)

### Option 1: Docker (Recommended)

```bash
# Clone the repository
git clone <repository-url>
cd HoichoiTV

# Start all services
docker-compose up -d
```

| Service    | URL                          |
|------------|------------------------------|
| Frontend   | http://localhost:3000         |
| Backend API| http://localhost:5000/api     |
| MySQL      | localhost:3306                |
| Redis      | localhost:6379                |

### Option 2: Manual Setup

```bash
# 1. Clone the repository
git clone <repository-url>
cd HoichoiTV

# 2. Configure environment
cp .env.example .env
# Edit .env with your database credentials, JWT secret, etc.

# 3. Install backend dependencies
cd backend
npm install

# 4. Install frontend dependencies
cd ../frontend
npm install

# 5. Create MySQL database and import schema
mysql -u root -p < ../database/schema.sql

# 6. Start backend (from backend/)
npm run dev

# 7. Start frontend (from frontend/)
npm run dev
```

### Default Credentials

| Role  | Email                | Password    |
|-------|----------------------|-------------|
| Admin | admin@hoichoi.com    | Admin@123   |

> Change the admin password immediately after first login.

## API Documentation

Base URL: `http://localhost:5000/api`

All protected routes require the header:
```
Authorization: Bearer <access_token>
```

### Authentication

| Method | Endpoint                          | Description              | Auth     |
|--------|-----------------------------------|--------------------------|----------|
| POST   | `/api/auth/register`              | Register new user        | Public   |
| POST   | `/api/auth/login`                 | Login, returns tokens    | Public   |
| POST   | `/api/auth/refresh-token`         | Get new access token     | Public   |
| POST   | `/api/auth/logout`                | Invalidate refresh token | Public   |
| POST   | `/api/auth/forgot-password`       | Request password reset   | Public   |
| POST   | `/api/auth/reset-password`        | Reset password with token| Public   |
| GET    | `/api/auth/me`                    | Get current user profile | Required |
| PUT    | `/api/auth/me`                    | Update profile           | Required |
| PUT    | `/api/auth/change-password`       | Change password          | Required |

### Channels

| Method | Endpoint                          | Description                        | Auth     |
|--------|-----------------------------------|------------------------------------|----------|
| GET    | `/api/channels`                   | List channels (paginated)          | Public   |
| GET    | `/api/channels/featured`          | Featured channels                  | Public   |
| GET    | `/api/channels/live`              | Live channels                      | Public   |
| GET    | `/api/channels/trending`          | Trending channels (by view count)  | Public   |
| GET    | `/api/channels/recently-watched`  | Recently watched by user           | Required |
| GET    | `/api/channels/:id`               | Channel detail                     | Public   |
| GET    | `/api/channels/:id/streams`       | Stream sources for a channel       | Public   |
| POST   | `/api/channels/:id/view`          | Increment view count               | Public   |

**Query parameters for `GET /api/channels`:**

| Parameter     | Type    | Description                          |
|---------------|---------|--------------------------------------|
| `page`        | Number  | Page number (default: 1)             |
| `limit`       | Number  | Items per page (default: 20)         |
| `category`    | String  | Filter by category slug              |
| `language`    | String  | Filter by language                   |
| `search`      | String  | Full-text search on channel name     |
| `is_live`     | Boolean | Filter live channels                 |
| `is_premium`  | Boolean | Filter premium channels              |
| `is_featured` | Boolean | Filter featured channels             |
| `sort`        | String  | Sort field (e.g., `view_count`, `created_at`) |
| `order`       | String  | `asc` or `desc`                      |

### Categories

| Method | Endpoint                          | Description                    | Auth   |
|--------|-----------------------------------|--------------------------------|--------|
| GET    | `/api/categories`                 | All categories (tree structure)| Public |
| GET    | `/api/categories/:slug`           | Category with its channels     | Public |

### Subscriptions

| Method | Endpoint                              | Description                 | Auth     |
|--------|---------------------------------------|-----------------------------|----------|
| GET    | `/api/subscriptions/plans`            | List all subscription plans | Public   |
| GET    | `/api/subscriptions/plans/:id`        | Plan detail                 | Public   |
| POST   | `/api/subscriptions/subscribe`        | Subscribe to a plan         | Required |
| GET    | `/api/subscriptions/my-subscription`  | Current user's subscription | Required |
| POST   | `/api/subscriptions/cancel-subscription`| Cancel subscription       | Required |
| POST   | `/api/subscriptions/renew`            | Renew subscription          | Required |

### Transactions

| Method | Endpoint                                  | Description                       | Auth     |
|--------|-------------------------------------------|-----------------------------------|----------|
| POST   | `/api/transactions/init-payment`          | Initialize payment via gateway    | Required |
| POST   | `/api/transactions/payment-callback/:gateway` | Payment gateway callback     | Public   |
| GET    | `/api/transactions/my-transactions`       | User's transaction history        | Required |
| GET    | `/api/transactions/:id`                   | Transaction detail                | Required |
| GET    | `/api/transactions/invoices`              | Download invoice                  | Required |

### Favorites (Auth Required)

| Method | Endpoint                          | Description          | Auth     |
|--------|-----------------------------------|----------------------|----------|
| GET    | `/api/favorites`                  | List user's favorites| Required |
| POST   | `/api/favorites/:channelId`       | Add channel to favorites | Required |
| DELETE | `/api/favorites/:channelId`       | Remove from favorites| Required |

### Watch History (Auth Required)

| Method | Endpoint                          | Description                | Auth     |
|--------|-----------------------------------|----------------------------|----------|
| GET    | `/api/history`                    | List watch history         | Required |
| POST   | `/api/history`                    | Update watch progress      | Required |
| DELETE | `/api/history/:id`                | Delete a history entry     | Required |
| DELETE | `/api/history`                    | Clear all history          | Required |

### EPG (Electronic Program Guide)

| Method | Endpoint                          | Description                | Auth   |
|--------|-----------------------------------|----------------------------|--------|
| GET    | `/api/epg/:channelId`             | Full EPG for channel       | Public |
| GET    | `/api/epg/now/:channelId`         | Currently playing          | Public |
| GET    | `/api/epg/next/:channelId`        | Upcoming programs          | Public |

### Upload

| Method | Endpoint                          | Description                | Auth     |
|--------|-----------------------------------|----------------------------|----------|
| POST   | `/api/upload/channel-logo`        | Upload channel logo        | Admin    |
| POST   | `/api/upload/avatar`              | Upload user avatar         | Required |
| POST   | `/api/upload/bulk-channels`       | Bulk import channels (M3U) | Admin    |

### Health Check

| Method | Endpoint                          | Description           | Auth   |
|--------|-----------------------------------|-----------------------|--------|
| GET    | `/api/health`                     | API health status     | Public |

### Admin (Admin Role Required)

All admin routes require `role: 'admin'` or `role: 'super_admin'`.

| Method | Endpoint                                      | Description                |
|--------|-----------------------------------------------|----------------------------|
| GET    | `/api/admin/dashboard`                        | Dashboard statistics       |
| GET    | `/api/admin/analytics`                        | Platform analytics         |
| GET    | `/api/admin/activity-logs`                    | Activity logs              |
| GET    | `/api/admin/settings`                         | Get all settings           |
| PUT    | `/api/admin/settings`                         | Update settings            |
| GET    | `/api/admin/notifications/send`               | Send notification          |

**User Management:**

| Method | Endpoint                                      | Description                |
|--------|-----------------------------------------------|----------------------------|
| GET    | `/api/admin/users`                            | List all users             |
| POST   | `/api/admin/users`                            | Create user                |
| PUT    | `/api/admin/users/:id`                        | Update user                |
| DELETE | `/api/admin/users/:id`                        | Delete user                |
| PUT    | `/api/admin/users/:id/status`                 | Toggle active/inactive     |
| PUT    | `/api/admin/users/:id/role`                   | Change user role           |
| POST   | `/api/admin/users/:id/balance`                | Add balance                |
| POST   | `/api/admin/users/:id/assign-subscription`    | Assign subscription        |

**Channel Management:**

| Method | Endpoint                                      | Description                |
|--------|-----------------------------------------------|----------------------------|
| GET    | `/api/admin/channels`                         | List all channels          |
| POST   | `/api/admin/channels`                         | Create channel             |
| PUT    | `/api/admin/channels/:id`                     | Update channel             |
| DELETE | `/api/admin/channels/:id`                     | Delete channel             |
| PUT    | `/api/admin/channels/:id/publish`             | Toggle publish status      |
| GET    | `/api/admin/channels/duplicates`              | Find duplicate channels    |

**Stream Source Management:**

| Method | Endpoint                                      | Description                |
|--------|-----------------------------------------------|----------------------------|
| POST   | `/api/admin/stream-sources`                   | Create stream source       |
| PUT    | `/api/admin/stream-sources/:id`               | Update stream source       |
| DELETE | `/api/admin/stream-sources/:id`               | Delete stream source       |
| POST   | `/api/admin/stream-sources/check-health`      | Check stream health        |

**Category Management:**

| Method | Endpoint                                      | Description                |
|--------|-----------------------------------------------|----------------------------|
| GET    | `/api/admin/categories`                       | List all categories        |
| POST   | `/api/admin/categories`                       | Create category            |
| PUT    | `/api/admin/categories/:id`                   | Update category            |
| DELETE | `/api/admin/categories/:id`                   | Delete category            |

**Subscription Plan Management:**

| Method | Endpoint                                      | Description                |
|--------|-----------------------------------------------|----------------------------|
| GET    | `/api/admin/subscriptions`                    | List all plans             |
| POST   | `/api/admin/subscriptions`                    | Create plan                |
| PUT    | `/api/admin/subscriptions/:id`                | Update plan                |
| DELETE | `/api/admin/subscriptions/:id`                | Delete plan                |

**Transaction Management:**

| Method | Endpoint                                      | Description                |
|--------|-----------------------------------------------|----------------------------|
| GET    | `/api/admin/transactions`                     | List all transactions      |
| PUT    | `/api/admin/transactions/:id/status`          | Update transaction status  |

### Response Format

All API responses follow this structure:

```json
{
  "success": true,
  "data": { ... },
  "meta": {
    "total": 100,
    "page": 1,
    "limit": 20,
    "totalPages": 5
  }
}
```

Error response:

```json
{
  "success": false,
  "message": "Error description",
  "errors": []
}
```

## Channel Import Format

The system accepts standard M3U/TXT format for bulk channel import:

```
#EXTM3U
#EXTINF:-1 tvg-logo="http://example.com/logo.png" group-title="Sports",ESPN HD
http://stream.example.com/live/stream.m3u8
#EXTINF:-1 tvg-logo="http://example.com/logo2.png" group-title="News",BBC News
http://stream.example.com/live/bbc.m3u8
```

Supported fields in `#EXTINF`:
- Channel name (after last comma)
- `tvg-logo` -- Channel logo URL
- `group-title` -- Category name (auto-creates if not exists)

Upload via `POST /api/upload/bulk-channels` with a `.m3u` or `.txt` file.

## Frontend Routes

| Path                     | Page               | Auth     |
|--------------------------|--------------------|----------|
| `/`                      | Home               | Public   |
| `/channels`              | All Channels       | Public   |
| `/category/:slug`        | Category Channels  | Public   |
| `/watch/:id`             | Player             | Public*  |
| `/search`                | Search             | Public   |
| `/login`                 | Login              | Public   |
| `/register`              | Register           | Public   |
| `/forgot-password`       | Forgot Password    | Public   |
| `/dashboard`             | User Dashboard     | Required |
| `/dashboard/favorites`   | Favorites          | Required |
| `/dashboard/history`     | Watch History      | Required |
| `/dashboard/subscription`| Subscription       | Required |
| `/dashboard/payments`    | Payments           | Required |
| `/dashboard/profile`     | Profile            | Required |
| `/admin`                 | Admin Dashboard    | Admin    |
| `/admin/users`           | User Management    | Admin    |
| `/admin/channels`        | Channel Management | Admin    |
| `/admin/categories`      | Category Management| Admin    |
| `/admin/subscriptions`   | Plan Management    | Admin    |
| `/admin/transactions`    | Transactions       | Admin    |
| `/admin/epg`             | EPG Management     | Admin    |
| `/admin/analytics`       | Analytics          | Admin    |
| `/admin/monitoring`      | Stream Monitoring  | Admin    |
| `/admin/settings`        | Site Settings      | Admin    |

*\* Premium channels require active subscription.*

## Configuration

Create a `.env` file in the `backend/` directory:

| Variable                    | Default                  | Description                          |
|-----------------------------|--------------------------|--------------------------------------|
| `NODE_ENV`                  | `development`            | Environment mode                     |
| `PORT`                      | `5000`                   | Backend server port                  |
| `DB_HOST`                   | `localhost`              | MySQL host                           |
| `DB_PORT`                   | `3306`                   | MySQL port                           |
| `DB_NAME`                   | `hoichoi_iptv`           | MySQL database name                  |
| `DB_USER`                   | `root`                   | MySQL username                       |
| `DB_PASSWORD`               | ``                       | MySQL password                       |
| `REDIS_HOST`                | `localhost`              | Redis host                           |
| `REDIS_PORT`                | `6379`                   | Redis port                           |
| `JWT_SECRET`                | (random)                 | JWT signing secret                   |
| `JWT_EXPIRES_IN`            | `15m`                    | Access token expiry                  |
| `JWT_REFRESH_EXPIRES_IN`    | `7d`                     | Refresh token expiry                 |
| `SMTP_HOST`                 | ``                       | SMTP server host                     |
| `SMTP_PORT`                 | `587`                    | SMTP server port                     |
| `SMTP_USER`                 | ``                       | SMTP username                        |
| `SMTP_PASS`                 | ``                       | SMTP password                        |
| `SMTP_FROM`                 | `noreply@hoichoi.com`    | Sender email address                 |
| `UPLOAD_DIR`                | `./uploads`              | File upload directory                |
| `MAX_FILE_SIZE`             | `5242880`                | Max upload size in bytes (5MB)       |
| `CORS_ORIGIN`               | `http://localhost:3000`  | Allowed CORS origin                  |
| `RATE_LIMIT_WINDOW`         | `15`                     | Rate limit window in minutes         |
| `RATE_LIMIT_MAX`            | `100`                    | Max requests per window              |
| `STRIPE_SECRET_KEY`         | ``                       | Stripe secret key                    |
| `STRIPE_PUBLISHABLE_KEY`    | ``                       | Stripe publishable key               |
| `SSLCOMMERZ_STORE_ID`       | ``                       | SSLCommerz store ID                  |
| `SSLCOMMERZ_STORE_PASS`     | ``                       | SSLCommerz store password            |
| `PAYPAL_CLIENT_ID`          | ``                       | PayPal client ID                     |
| `PAYPAL_CLIENT_SECRET`      | ``                       | PayPal client secret                 |
| `STREAM_CHECK_INTERVAL`     | `60000`                  | Stream health check interval (ms)    |

## Database Schema

The MySQL database contains 16 tables:

| Table                | Description                              |
|----------------------|------------------------------------------|
| `roles`              | User roles (user, admin, super_admin)    |
| `users`              | User accounts with auth details          |
| `refresh_tokens`     | JWT refresh token storage                |
| `categories`         | Channel categories (self-referencing)    |
| `channels`           | TV channel definitions                   |
| `stream_sources`     | Stream URLs per channel (with health)    |
| `subscriptions`      | Subscription plan definitions            |
| `user_subscriptions` | User-to-plan assignments                 |
| `transactions`       | Payment transaction records              |
| `favorites`          | User favorite channels                   |
| `watch_history`      | Viewing history with progress            |
| `device_sessions`    | Active device tracking                   |
| `epg`                | Electronic program guide entries         |
| `activity_logs`      | User/admin activity audit trail          |
| `settings`           | Application configuration key-value      |
| `notifications`      | User notifications                       |

## Deployment

### Nginx Reverse Proxy

```nginx
server {
    listen 80;
    server_name yourdomain.com;

    location / {
        root /var/www/hoichoi-iptv/frontend/dist;
        try_files $uri $uri/ /index.html;
    }

    location /api {
        proxy_pass http://localhost:5000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }
}
```

### SSL with Let's Encrypt

```bash
sudo certbot --nginx -d yourdomain.com
```

### PM2 (Production Process Manager)

```bash
cd backend
pm2 start src/server.js --name hoichoi-api
pm2 save
pm2 startup
```

### Database Backups

```bash
# Manual backup
mysqldump -u root -p hoichoi_iptv > backup_$(date +%Y%m%d).sql

# Automated daily backup (add to crontab)
0 2 * * * mysqldump -u root -p hoichoi_iptv | gzip > /backups/hoichoi_$(date +\%Y\%m\%d).sql.gz
```

## Security

- **JWT + Refresh Tokens** -- Short-lived access tokens with secure refresh flow
- **Rate Limiting** -- Configurable per-IP request throttling
- **CORS** -- Whitelist-based origin restriction
- **Helmet Headers** -- Security HTTP headers via Express middleware
- **Input Validation** -- Request sanitization on all endpoints
- **SQL Injection Protection** -- Sequelize ORM parameterized queries
- **XSS Protection** -- Output encoding and input sanitization
- **CSRF Protection** -- Token-based cross-site request forgery prevention
- **Password Hashing** -- bcrypt with configurable salt rounds
- **Role-based Access** -- Middleware enforces user/admin/super_admin permissions

## License

MIT
