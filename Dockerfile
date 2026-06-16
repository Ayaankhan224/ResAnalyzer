# 1. Use an official Node.js runtime environment
FROM node:20-slim

# 2. Set up the working directory inside the container
WORKDIR /app

# 3. Copy package files and install production dependencies
COPY package*.json ./
RUN npm install

# 4. Copy the rest of your Express application files
COPY . .

# 5. Fix permissions (Hugging Face runs containers under user ID 1000)
RUN chown -R 1000:1000 /app
USER 1000

# 6. Expose the required Hugging Face port
EXPOSE 7860

# 7. Command to run your app
CMD ["node", "server.js"]