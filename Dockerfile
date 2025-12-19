# Use the official Flutter image
FROM ghcr.io/cirruslabs/flutter:stable

# Set the working directory
WORKDIR /app

# Copy pubspec files
COPY pubspec.yaml pubspec.lock ./

# Get dependencies
RUN flutter pub get

# Copy the rest of the application
COPY . .

# Build the web app
RUN flutter build web --release

# Use Python to serve the web app
FROM python:3.9-slim

WORKDIR /app

# Copy the built web app
COPY --from=0 /app/build/web ./web

# Expose port
EXPOSE 8080

# Start the server
CMD ["python3", "-m", "http.server", "8080", "--directory", "web"]