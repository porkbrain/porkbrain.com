# Elixir + Phoenix
FROM elixir:1.9.4

# Exposes HTTP and HTTPS ports.
EXPOSE 80
EXPOSE 443

# Copies the compiled app.
RUN mkdir -p porkbrain
WORKDIR /porkbrain
COPY porkbrain .

# Runs the app.
CMD ./bin/porkbrain start
