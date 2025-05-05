# Use official Elixir image
FROM elixir:1.14-alpine

# Set the working directory
WORKDIR /app

# Install dependencies
RUN mix local.hex --force && \
    mix local.rebar --force

# Install app dependencies
COPY mix.exs mix.lock ./
RUN mix deps.get

# Copy the rest of the application code
COPY . .

# Compile the application
RUN mix compile

# Set the environment variables for production
ENV MIX_ENV=prod
ENV PORT=4000

# Expose the port the app will run on
EXPOSE 4000

# Start the Phoenix server
CMD ["mix", "phx.server"]
