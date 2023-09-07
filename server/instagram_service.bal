import ballerina/grpc;

listener grpc:Listener ep = new (9090);

@grpc:Descriptor {value: INSTA_DESC}
service "Instagram" on ep {

    remote function postMessage(PostMessage value) returns Tweet|error {
    }
    remote function likeMessage(ReactionMessage value) returns string|error {
    }
    remote function commentMessage(CommentMessage value) returns Tweet|error {
    }
    remote function viewMessages(string value) returns stream<Tweet, error?>|error {
    }
}

