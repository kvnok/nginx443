# Docker-related variables
IMAGE = testimage
CONTAINER = testcontainer

go: build run start

# Build the Docker image only if it doesn't exist
build:
	if [ -z $$(docker images -q $(IMAGE)) ]; then \
		docker build -t $(IMAGE) .; \
	fi

# Create and run the Docker container
run:
	docker run -d -p 443:443 --name $(CONTAINER) $(IMAGE)

# Start the Docker container
start:
	docker start $(CONTAINER)

# Restart the Docker container
restart:
	docker restart $(CONTAINER)

# Stop the Docker container
stop:
	docker stop $(CONTAINER)

# Remove the Docker container
rm:
	docker rm $(CONTAINER)

# Remove the Docker image
rmi:
	docker rmi $(IMAGE)

# Clean up everything (stop, remove container and image)
clean: stop rm rmi

# Display usage information
help:
	@echo "Available make targets:"
	@echo "  build       - Build the Docker image (if not already built)"
	@echo "  run         - Create and run the Docker container"
	@echo "  stop        - Stop the Docker container"
	@echo "  rm          - Remove the Docker container"
	@echo "  rmi         - Remove the Docker image"
	@echo "  clean       - Stop, remove container, and remove image"
	@echo "  help        - Display this help message"

.PHONY: build run stop rm rmi clean help
