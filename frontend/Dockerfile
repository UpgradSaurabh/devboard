# Step 1: Bring the Base Image
FROM node:24

# Step 2: Create a folder where code can stay

WORKDIR /app

# Step 3: Copy the code from host machine to the container

COPY . .

# Step 4: Install the required dependencies

RUN npm install

# Step 5: Expose the port for documentation purpose

EXPOSE 5173

# Step 6: Run the application

CMD ["npm", "run", "dev", "--", "--host", "0.0.0.0"]
