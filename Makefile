proto_files := $(shell find . -name *.proto -print)

proto_src_files := $(patsubst %.proto,%.pb.cc,$(proto_files))
proto_header_files := $(patsubst %.proto,%.pb.h,$(proto_files))
grpc_src_files := $(patsubst %.proto,%.grpc.pb.cc,$(proto_files))
grpc_header_files := $(patsubst %.proto,%.grpc.pb.h,$(proto_files))

.PHONY: all clean

all: $(proto_src_files) $(proto_header_files) $(grpc_src_files) $(grpc_header_files)

%.pb.cc %.pb.h %.grpc.pb.h %.grpc.pb.cc: %.proto
	protoc --cpp_out=. --grpc_out=. --plugin=protoc-gen-grpc=/usr/bin/grpc_cpp_plugin $<

clean:
	rm -f $(proto_src_files) $(proto_header_files) $(grpc_src_files) $(grpc_header_files)

