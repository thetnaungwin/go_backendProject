package Database

import (
	"context"
	"log"
	"os"
	"testing"

	"github.com/jackc/pgx/v5/pgxpool"
)

var testQueries *Queries
var testDB *pgxpool.Pool

const (
	dbSource = "postgresql://postgres:peter@localhost:4444/simple_bank?sslmode=disable"
)

func TestMain(m *testing.M) {
	var err error

	// Connect using pgxpool
	testDB, err = pgxpool.New(context.Background(), dbSource)
	if err != nil {
		log.Fatal("cannot connect to db:", err)
	}
	defer testDB.Close()

	// Wrap the pool in Queries
	testQueries = New(testDB)

	os.Exit(m.Run())
}
