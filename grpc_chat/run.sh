# get the dart plugin
pub global activate protoc_plugin

# Generate the dart code
protoc -I proto/ proto/service.proto --dart_out=grpc:grpc_flutter_client/lib/protos
