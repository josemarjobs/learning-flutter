package main

import (
	"bufio"
	"context"
	"crypto/sha256"
	"encoding/hex"
	"flag"
	"fmt"
	"log"
	"os"
	"sync"
	"time"

	"google.golang.org/grpc"
	"josemarjobs.dev/chatserver/proto"
)

var client proto.BroadcastClient
var wg *sync.WaitGroup

func init() {
	wg = &sync.WaitGroup{}
}

func connect(user *proto.User) error {
	var streamError error

	stream, err := client.CreateStream(context.Background(), &proto.Connect{
		User:   user,
		Active: true,
	})
	if err != nil {
		return fmt.Errorf("connection failed %v\n", err)
	}

	wg.Add(1)
	go func(str proto.Broadcast_CreateStreamClient) {
		defer wg.Done()

		for {
			msg, err := str.Recv()
			if err != nil {
				streamError = fmt.Errorf("error reading message: %v", err)
				break
			}
			fmt.Printf("%v: %v\n", msg.Id, msg.Content)
		}
	}(stream)

	return streamError
}

func main() {
	serverAddr := flag.String("server", "localhost:8080", "the server address")
	flag.Parse()

	timestamp := time.Now()
	// done := make(chan struct{})

	name := flag.String("N", "Anon", "your name")
	flag.Parse()
	id := sha256.Sum256([]byte(timestamp.String() + *name))

	conn, err := grpc.Dial(*serverAddr, grpc.WithInsecure())
	if err != nil {
		log.Fatalf("couldn't connect to server: %v\n", err)
	}
	log.Printf("Connected to %v\n", *serverAddr)

	client = proto.NewBroadcastClient(conn)
	user := proto.User{
		Id:   hex.EncodeToString(id[:]),
		Name: *name,
	}

	connect(&user)
	wg.Add(1)
	go func() {
		defer wg.Done()

		scanner := bufio.NewScanner(os.Stdin)

		for scanner.Scan() {
			msg := proto.Message{
				Id:        user.Id,
				Content:   scanner.Text(),
				Timestamp: timestamp.String(),
			}
			_, err := client.BroadcastMessage(context.Background(), &msg)
			if err != nil {
				fmt.Printf("error sending msg: %v\n", err)
				break
			}
		}
	}()

	wg.Wait()
}
