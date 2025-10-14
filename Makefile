postgres:
	docker run --name postgres13 \
		-e POSTGRES_USER=postgres \
		-e POSTGRES_PASSWORD=peter \
		-p 4444:5432 \
		-d postgres:13.22-alpine3.21

createdb:
	docker exec -it postgres13 createdb --username=postgres --owner=postgres simple_bank

dropdb:
	docker exec -it postgres13 dropdb --username=postgres simple_bank

migrateup:
	migrate -path Database/migration -database "postgresql://postgres:peter@localhost:4444/simple_bank?sslmode=disable" -verbose up

migratedown:
	migrate -path Database/migration -database "postgresql://postgres:peter@localhost:4444/simple_bank?sslmode=disable" -verbose down

sqlc:
    sqlc generate

.PHONY: postgres createdb dropdb migrateup migratedown sqlc
