# ZyptoPulse

ZyptoPulse is a Flutter-based cryptocurrency tracking application that leverages various APIs to fetch market data, perform user authentication, and manage a list of favorite cryptocurrencies.

---

## Table of Contents

- [Setup Instructions](#setup-instructions)
- [API Details](#api-details)
- [JWT/Token Flow](#jwttoken-flow)
- [Favorites Storage](#favorites-storage)

---

## Setup Instructions

1. **Prerequisites:**

   - Ensure you have Flutter installed. Follow the official [Flutter installation guide](https://flutter.dev/docs/get-started/install) if needed.
   - Make sure you have a working Dart environment.

2. **Clone the Repository:**

   ```bash
   git clone <repository-url>
   cd zypto_pulse
   ```

3. **Install Dependencies:**

   - Run the following command to install the required packages:
     ```bash
     flutter pub get
     ```

4. **Run the Application:**

   - To run on an emulator or physical device, execute:
     ```bash
     flutter run
     ```

5. **Project Structure Overview:**
   - The project follows a clean structure with the following main directories:
     - `lib/` – Contains the application’s Dart code.
       - `models/` – Data models (e.g., CryptoModel, FavoriteModel, UserModel).
       - `providers/` – Riverpod providers for state management (authentication, crypto data, theme).
       - `screens/` – UI screens including authentication, home, and settings.
       - `services/` – API and authentication services (including secure storage).
       - `theme/` – App theme definitions.
       - `widgets/` – Reusable UI components (crypto cards, navigation bar, etc.).

---

## API Details

The application interacts with two main external APIs:

1. **Crypto Market Data:**

   - **Endpoint:** `https://api.coingecko.com/api/v3/coins/markets`
   - **Usage:** Fetches market data for cryptocurrencies.
   - **Parameters:**
     - `vs_currency`: Currency code (default "usd").
     - `order`: Sorting order (e.g., "market_cap_desc").
     - `per_page`: Number of records per page.
     - `page`: Page number.
     - `sparkline`: Boolean flag for sparkline data.

2. **Authentication and User Management:**

   - **Base URL:** `https://api.fluttercrypto.agpro.co.in`
   - **Endpoints:**
     - **Login:** `POST /auth/login`
       - Expects JSON with email and password.
       - Returns an `access_token` on success.
     - **Sign Up:** `POST /users`
       - Expects JSON with name, email, password, and role.
       - Returns a success status or error message.
     - **Logout:** `POST /auth/logout`
       - Requires the JWT token in the `Authorization` header.

3. **Favorites Management:**
   - **Base URL:** `https://api.fluttercrypto.agpro.co.in`
   - **Endpoints:**
     - **Add Favorite:** `POST /items/crypto_favorites`
       - Saves a crypto object as a favorite.
       - Requires JWT token in the `Authorization` header.
     - **Get Favorites:** `GET /items/crypto_favorites`
       - Retrieves a list of user favorites.
       - Requires JWT token.
     - **Delete Favorite:** `DELETE /items/crypto_favorites/{itemId}`
       - Deletes a favorite crypto using its ID.
       - Requires JWT token.

---

## JWT/Token Flow

- **Login Process:**

  - When a user logs in, the application calls the `/auth/login` endpoint with the provided email and password.
  - If successful, the server returns an `access_token`.
  - This token is stored locally using Flutter Secure Storage (via the `SecureStorage` service) under the key `auth_token`.

- **Token Usage:**

  - The stored token is used to authenticate subsequent API requests by including it in the `Authorization` header as a Bearer token.
  - Endpoints for logging out, saving favorites, and retrieving favorites all require this token for authentication.

- **Logout Process:**
  - On logout, the token is read from secure storage and passed to the `/auth/logout` endpoint.
  - After a successful logout (or regardless of the API response), the token is removed from secure storage.

---

## Favorites Storage

- **How Favorites are Managed:**
  - Favorites are managed via the `FavoriteService` class which interacts with the `/items/crypto_favorites` endpoint.
- **Storing a Favorite:**

  - When a user adds a cryptocurrency to favorites (e.g., by swiping on a crypto card), the app converts the `CryptoModel` to JSON and sends a POST request to the API.
  - The request includes the JWT token for authentication.
  - On success, the favorite is added to the local state managed by the Riverpod `cryptoProvider`.

- **Retrieving Favorites:**

  - The application fetches the list of favorites by sending a GET request to the `/items/crypto_favorites` endpoint.
  - The response is then mapped to a list of `CryptoModel` objects and stored in the provider’s state.

- **Removing a Favorite:**
  - To remove a favorite, a DELETE request is made to `/items/crypto_favorites/{itemId}` with the corresponding crypto’s ID.
  - Upon successful deletion, the favorite is removed from the local state.

---

This README provides an overview of the key aspects of the ZyptoPulse application. For further details, consult the source code in the corresponding directories.

---
