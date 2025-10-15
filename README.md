# Storage Rental DB

This repo defines schema and relationships for the PostgreSQL and test data
To run locally, please follow these steps:
1. Install Docker (and Docker Desktop) and docker-compose
2. Run docker-compose up -d
3. Run docker exec -it main-db psql -U admin -d main_db
4. Do whatever you want!
5. Run docker-compose down -v