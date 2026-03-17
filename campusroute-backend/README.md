# CampusRoute Backend API Documentation

A Node.js + Express backend for campus bus tracking.

## Getting Started

1. Install dependencies: `npm install`
2. Configure `.env` (use `.env.example` as a template)
3. Start development server: `npm run dev`

## API Endpoints

### Health Check
| Method | Path | Description | Auth Required | Role |
| :--- | :--- | :--- | :--- | :--- |
| GET | `/api/health` | API Status | No | - |

### Authentication
| Method | Path | Description | Auth Required | Role |
| :--- | :--- | :--- | :--- | :--- |
| POST | `/api/auth/send-otp` | Send OTP to mobile | No | - |
| POST | `/api/auth/verify-otp` | Verify OTP & get JWT | No | - |

### College Management
| Method | Path | Description | Auth Required | Role |
| :--- | :--- | :--- | :--- | :--- |
| POST | `/api/college/register` | Register College & Admin | No | - |
| GET | `/api/college/:id` | Get College Details | Yes | Any |

### Bus Management
| Method | Path | Description | Auth Required | Role |
| :--- | :--- | :--- | :--- | :--- |
| POST | `/api/bus/add` | Add a new bus | Yes | COLLEGE_ADMIN |
| GET | `/api/bus/list` | List all college buses | Yes | COLLEGE_ADMIN |
| POST | `/api/bus/assign-driver` | Assign driver to bus | Yes | COLLEGE_ADMIN |

### Driver Management
| Method | Path | Description | Auth Required | Role |
| :--- | :--- | :--- | :--- | :--- |
| POST | `/api/driver/add` | Add a new driver | Yes | COLLEGE_ADMIN |
| GET | `/api/driver/list` | List all college drivers | Yes | COLLEGE_ADMIN |

### Student Management
| Method | Path | Description | Auth Required | Role |
| :--- | :--- | :--- | :--- | :--- |
| POST | `/api/student/add` | Add student & assign bus | Yes | COLLEGE_ADMIN |
| GET | `/api/student/list` | List college students with bus | Yes | COLLEGE_ADMIN |

## Real-Time Tracking (Socket.events)

### Driver Events
- `driver:start`: Start a bus trip
- `driver:location`: Send GPS coordinates
- `driver:stop`: End a bus trip

### Student Events
- `student:join`: Join a bus room for tracking
- `student:leave`: Leave a bus room
