# Hoichoi IPTV -- API Reference

Base URL: `http://localhost:5000/api`

All protected routes require: `Authorization: Bearer <access_token>`

---

## Authentication

| Method | Endpoint                          | Description                | Auth   |
|--------|-----------------------------------|----------------------------|--------|
| POST   | `/api/auth/register`              | Register new user          | Public |
| POST   | `/api/auth/login`                 | Login (returns tokens)     | Public |
| POST   | `/api/auth/refresh-token`         | Refresh access token       | Public |
| POST   | `/api/auth/logout`                | Logout (invalidate token)  | Public |
| POST   | `/api/auth/forgot-password`       | Request password reset     | Public |
| POST   | `/api/auth/reset-password`        | Reset password with token  | Public |
| GET    | `/api/auth/me`                    | Get current profile        | Auth   |
| PUT    | `/api/auth/me`                    | Update profile             | Auth   |
| PUT    | `/api/auth/change-password`       | Change password            | Auth   |

## Channels

| Method | Endpoint                          | Description                          | Auth   |
|--------|-----------------------------------|--------------------------------------|--------|
| GET    | `/api/channels`                   | List channels (paginated, filterable)| Public |
| GET    | `/api/channels/featured`          | Featured channels                    | Public |
| GET    | `/api/channels/live`              | Live channels                        | Public |
| GET    | `/api/channels/trending`          | Trending by view count               | Public |
| GET    | `/api/channels/recently-watched`  | User's recently watched              | Auth   |
| GET    | `/api/channels/:id`               | Channel detail                       | Public |
| GET    | `/api/channels/:id/streams`       | Stream sources for channel           | Public |
| POST   | `/api/channels/:id/view`          | Increment view count                 | Public |

**Channel list query params:** `page`, `limit`, `category`, `language`, `search`, `is_live`, `is_premium`, `is_featured`, `sort`, `order`

## Categories

| Method | Endpoint                          | Description                     | Auth   |
|--------|-----------------------------------|---------------------------------|--------|
| GET    | `/api/categories`                 | All categories (tree structure) | Public |
| GET    | `/api/categories/:slug`           | Category with channels          | Public |

## Subscriptions

| Method | Endpoint                                    | Description                   | Auth   |
|--------|---------------------------------------------|-------------------------------|--------|
| GET    | `/api/subscriptions/plans`                  | List all plans                | Public |
| GET    | `/api/subscriptions/plans/:id`              | Plan detail                   | Public |
| POST   | `/api/subscriptions/subscribe`              | Subscribe to a plan           | Auth   |
| GET    | `/api/subscriptions/my-subscription`        | Current subscription          | Auth   |
| POST   | `/api/subscriptions/cancel-subscription`    | Cancel subscription           | Auth   |
| POST   | `/api/subscriptions/renew`                  | Renew subscription            | Auth   |

## Transactions

| Method | Endpoint                                        | Description                    | Auth   |
|--------|------------------------------------------------|--------------------------------|--------|
| POST   | `/api/transactions/init-payment`               | Initialize payment             | Auth   |
| POST   | `/api/transactions/payment-callback/:gateway`  | Payment gateway webhook        | Public |
| GET    | `/api/transactions/my-transactions`            | Transaction history            | Auth   |
| GET    | `/api/transactions/:id`                        | Transaction detail             | Auth   |
| GET    | `/api/transactions/invoices`                   | Download invoice               | Auth   |

## Favorites

| Method | Endpoint                          | Description           | Auth   |
|--------|-----------------------------------|-----------------------|--------|
| GET    | `/api/favorites`                  | List favorites        | Auth   |
| POST   | `/api/favorites/:channelId`       | Add to favorites      | Auth   |
| DELETE | `/api/favorites/:channelId`       | Remove from favorites | Auth   |

## Watch History

| Method | Endpoint                          | Description            | Auth   |
|--------|-----------------------------------|------------------------|--------|
| GET    | `/api/history`                    | List watch history     | Auth   |
| POST   | `/api/history`                    | Update watch progress  | Auth   |
| DELETE | `/api/history/:id`                | Delete entry           | Auth   |
| DELETE | `/api/history`                    | Clear all history      | Auth   |

## EPG (Electronic Program Guide)

| Method | Endpoint                          | Description            | Auth   |
|--------|-----------------------------------|------------------------|--------|
| GET    | `/api/epg/:channelId`             | Full EPG for channel   | Public |
| GET    | `/api/epg/now/:channelId`         | Currently playing      | Public |
| GET    | `/api/epg/next/:channelId`        | Upcoming programs      | Public |

## Upload

| Method | Endpoint                          | Description                | Auth   |
|--------|-----------------------------------|----------------------------|--------|
| POST   | `/api/upload/channel-logo`        | Upload channel logo        | Admin  |
| POST   | `/api/upload/avatar`              | Upload user avatar         | Auth   |
| POST   | `/api/upload/bulk-channels`       | Bulk import M3U/TXT        | Admin  |

## Health

| Method | Endpoint                          | Description         | Auth   |
|--------|-----------------------------------|---------------------|--------|
| GET    | `/api/health`                     | API health status   | Public |

## Admin

All endpoints require `role: admin` or `role: super_admin`.

| Method | Endpoint                                      | Description                |
|--------|-----------------------------------------------|----------------------------|
| GET    | `/api/admin/dashboard`                        | Dashboard stats            |
| GET    | `/api/admin/analytics`                        | Platform analytics         |
| GET    | `/api/admin/activity-logs`                    | Activity logs              |
| GET    | `/api/admin/settings`                         | Get settings               |
| PUT    | `/api/admin/settings`                         | Update settings            |
| GET    | `/api/admin/notifications/send`               | Send notification          |
| GET    | `/api/admin/users`                            | List users                 |
| POST   | `/api/admin/users`                            | Create user                |
| PUT    | `/api/admin/users/:id`                        | Update user                |
| DELETE | `/api/admin/users/:id`                        | Delete user                |
| PUT    | `/api/admin/users/:id/status`                 | Toggle user status         |
| PUT    | `/api/admin/users/:id/role`                   | Change user role           |
| POST   | `/api/admin/users/:id/balance`                | Add balance                |
| POST   | `/api/admin/users/:id/assign-subscription`    | Assign subscription        |
| GET    | `/api/admin/channels`                         | List channels              |
| POST   | `/api/admin/channels`                         | Create channel             |
| PUT    | `/api/admin/channels/:id`                     | Update channel             |
| DELETE | `/api/admin/channels/:id`                     | Delete channel             |
| PUT    | `/api/admin/channels/:id/publish`             | Toggle publish             |
| GET    | `/api/admin/channels/duplicates`              | Find duplicates            |
| POST   | `/api/admin/stream-sources`                   | Create stream source       |
| PUT    | `/api/admin/stream-sources/:id`               | Update stream source       |
| DELETE | `/api/admin/stream-sources/:id`               | Delete stream source       |
| POST   | `/api/admin/stream-sources/check-health`      | Check stream health        |
| GET    | `/api/admin/categories`                       | List categories            |
| POST   | `/api/admin/categories`                       | Create category            |
| PUT    | `/api/admin/categories/:id`                   | Update category            |
| DELETE | `/api/admin/categories/:id`                   | Delete category            |
| GET    | `/api/admin/subscriptions`                    | List plans                 |
| POST   | `/api/admin/subscriptions`                    | Create plan                |
| PUT    | `/api/admin/subscriptions/:id`                | Update plan                |
| DELETE | `/api/admin/subscriptions/:id`                | Delete plan                |
| GET    | `/api/admin/transactions`                     | List transactions          |
| PUT    | `/api/admin/transactions/:id/status`          | Update transaction status  |
