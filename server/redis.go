package main

import (
	"context"
	"encoding/json"
	"fmt"
	"os"
	"strconv"
	"time"

	"github.com/go-redis/redis"
)

type Row struct {
	Timestamp string
	Content   string
}

func GetRedisClient(ctx context.Context) (*redis.Client, error) {
	var redisAddr, redisPassword string
	if redisAddr = os.Getenv("REDIS_ADDR"); redisAddr == "" {
		redisAddr = "0.0.0.0"
	}
	if redisPassword = os.Getenv("REDIS_PASSWORD"); redisPassword == "" {
		redisPassword = ""
	}
	rdb := redis.NewClient(&redis.Options{
		Addr:     fmt.Sprintf("%s:6379", redisAddr),
		Password: redisPassword,
		DB:       0,
	})

	_, err := rdb.Ping().Result()
	if err != nil {
		return nil, err
	}

	return rdb, nil
}

func AddRow(rdb *redis.Client, content string) error {
	ts := time.Now()
	row := Row{
		Timestamp: ts.Format("01/02 15:04"),
		Content:   content,
	}

	value, err := json.Marshal(row)
	if err != nil {
		return err
	}

	err = rdb.Set(strconv.FormatInt(ts.Unix(), 10), value, 0).Err()
	if err != nil {
		return err
	}
	return nil
}

func listRows(rdb *redis.Client) ([]Row, error) {
	var rows = []Row{}
	keys, err := rdb.Keys("*").Result()
	if err != nil {
		return nil, err
	}

	for _, key := range keys {
		var row Row
		result, err := rdb.Get(key).Result()
		if err != nil {
			return nil, err
		}

		err = json.Unmarshal([]byte(result), &row)
		if err != nil {
			return nil, err
		}

		rows = append(rows, row)
	}

	return rows, err
}
