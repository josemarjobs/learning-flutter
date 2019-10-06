package main

import (
	"context"
	"log"
	"net"
	"os"
	"sync"

	"google.golang.org/grpc"
	"google.golang.org/grpc/grpclog"
	"josemarjobs.dev/chatserver/proto"
)

func main() {
	logger := grpclog.NewLoggerV2(os.Stdout, os.Stdout, os.Stdout)
	var connections []*Connection
	s := Server{Connections: connections, Logger: logger}

	grpcServer := grpc.NewServer()
	listener, err := net.Listen("tcp", ":8080")
	if err != nil {
		log.Fatalf("error creating server: %v\n", err)
	}

	s.Logger.Info("Starting server at port :8080")
	proto.RegisterBroadcastServer(grpcServer, &s)
	grpcServer.Serve(listener)
}

type Connection struct {
	stream proto.Broadcast_CreateStreamServer
	id     string
	active bool
	err    chan error
}

type Server struct {
	Connections []*Connection
	Logger      grpclog.LoggerV2
}

func (s *Server) CreateStream(req *proto.Connect, stream proto.Broadcast_CreateStreamServer) error {
	conn := Connection{
		stream: stream,
		id:     req.User.Id,
		active: true,
		err:    make(chan error),
	}
	s.Connections = append(s.Connections, &conn)

	s.Logger.Infof("user id: %v connected\n", conn.id)

	return <-conn.err
}

func (s *Server) BroadcastMessage(ctx context.Context, msg *proto.Message) (*proto.Close, error) {
	var wg sync.WaitGroup

	for _, conn := range s.Connections {
		wg.Add(1)
		go func(m *proto.Message, c *Connection) {
			defer wg.Done()
			if conn.active {
				err := c.stream.Send(m)
				s.Logger.Info("Sending message to: ", c.id)

				if err != nil {
					s.Logger.Errorf("Error sending message to %v: %v\n", c.id, err)
					c.active = false
					c.err <- err
				}
			}
		}(msg, conn)
	}

	wg.Wait()

	return &proto.Close{}, nil
}
