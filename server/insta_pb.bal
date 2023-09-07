import ballerina/grpc;
import ballerina/protobuf;
import ballerina/protobuf.types.wrappers;

public const string INSTA_DESC = "0A0B696E7374612E70726F746F120E53686F7274496E7374616772616D1A1E676F6F676C652F70726F746F6275662F77726170706572732E70726F746F223B0A0B506F73744D65737361676512180A076D65737361676518012001280952076D65737361676512120A0474696D65180220012809520474696D6522770A055477656574120E0A0269641805200128095202696412180A076D65737361676518012001280952076D65737361676512120A0474696D65180220012809520474696D6512140A056C696B657318032001280352056C696B6573121A0A08636F6D6D656E74731804200328095208636F6D6D656E747322480A0E436F6D6D656E744D65737361676512180A07636F6D6D656E741801200128095207636F6D6D656E74121C0A096D657373616765496418022001280952096D657373616765496422650A0F5265616374696F6E4D65737361676512340A087265616374696F6E18012001280E32182E53686F7274496E7374616772616D2E5265616374696F6E52087265616374696F6E121C0A096D657373616765494418022001280952096D65737361676549442A210A085265616374696F6E12080A044C696B651000120B0A074469736C696B65100132AC020A09496E7374616772616D12410A0B706F73744D657373616765121B2E53686F7274496E7374616772616D2E506F73744D6573736167651A152E53686F7274496E7374616772616D2E5477656574124C0A0B6C696B654D657373616765121F2E53686F7274496E7374616772616D2E5265616374696F6E4D6573736167651A1C2E676F6F676C652E70726F746F6275662E537472696E6756616C756512470A0E636F6D6D656E744D657373616765121E2E53686F7274496E7374616772616D2E436F6D6D656E744D6573736167651A152E53686F7274496E7374616772616D2E547765657412450A0C766965774D65737361676573121C2E676F6F676C652E70726F746F6275662E537472696E6756616C75651A152E53686F7274496E7374616772616D2E54776565743001620670726F746F33";

public isolated client class InstagramClient {
    *grpc:AbstractClientEndpoint;

    private final grpc:Client grpcClient;

    public isolated function init(string url, *grpc:ClientConfiguration config) returns grpc:Error? {
        self.grpcClient = check new (url, config);
        check self.grpcClient.initStub(self, INSTA_DESC);
    }

    isolated remote function postMessage(PostMessage|ContextPostMessage req) returns Tweet|grpc:Error {
        map<string|string[]> headers = {};
        PostMessage message;
        if req is ContextPostMessage {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("ShortInstagram.Instagram/postMessage", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <Tweet>result;
    }

    isolated remote function postMessageContext(PostMessage|ContextPostMessage req) returns ContextTweet|grpc:Error {
        map<string|string[]> headers = {};
        PostMessage message;
        if req is ContextPostMessage {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("ShortInstagram.Instagram/postMessage", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <Tweet>result, headers: respHeaders};
    }

    isolated remote function likeMessage(ReactionMessage|ContextReactionMessage req) returns string|grpc:Error {
        map<string|string[]> headers = {};
        ReactionMessage message;
        if req is ContextReactionMessage {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("ShortInstagram.Instagram/likeMessage", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return result.toString();
    }

    isolated remote function likeMessageContext(ReactionMessage|ContextReactionMessage req) returns wrappers:ContextString|grpc:Error {
        map<string|string[]> headers = {};
        ReactionMessage message;
        if req is ContextReactionMessage {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("ShortInstagram.Instagram/likeMessage", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: result.toString(), headers: respHeaders};
    }

    isolated remote function commentMessage(CommentMessage|ContextCommentMessage req) returns Tweet|grpc:Error {
        map<string|string[]> headers = {};
        CommentMessage message;
        if req is ContextCommentMessage {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("ShortInstagram.Instagram/commentMessage", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <Tweet>result;
    }

    isolated remote function commentMessageContext(CommentMessage|ContextCommentMessage req) returns ContextTweet|grpc:Error {
        map<string|string[]> headers = {};
        CommentMessage message;
        if req is ContextCommentMessage {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("ShortInstagram.Instagram/commentMessage", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <Tweet>result, headers: respHeaders};
    }

    isolated remote function viewMessages(string|wrappers:ContextString req) returns stream<Tweet, grpc:Error?>|grpc:Error {
        map<string|string[]> headers = {};
        string message;
        if req is wrappers:ContextString {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeServerStreaming("ShortInstagram.Instagram/viewMessages", message, headers);
        [stream<anydata, grpc:Error?>, map<string|string[]>] [result, _] = payload;
        TweetStream outputStream = new TweetStream(result);
        return new stream<Tweet, grpc:Error?>(outputStream);
    }

    isolated remote function viewMessagesContext(string|wrappers:ContextString req) returns ContextTweetStream|grpc:Error {
        map<string|string[]> headers = {};
        string message;
        if req is wrappers:ContextString {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeServerStreaming("ShortInstagram.Instagram/viewMessages", message, headers);
        [stream<anydata, grpc:Error?>, map<string|string[]>] [result, respHeaders] = payload;
        TweetStream outputStream = new TweetStream(result);
        return {content: new stream<Tweet, grpc:Error?>(outputStream), headers: respHeaders};
    }
}

public class TweetStream {
    private stream<anydata, grpc:Error?> anydataStream;

    public isolated function init(stream<anydata, grpc:Error?> anydataStream) {
        self.anydataStream = anydataStream;
    }

    public isolated function next() returns record {|Tweet value;|}|grpc:Error? {
        var streamValue = self.anydataStream.next();
        if (streamValue is ()) {
            return streamValue;
        } else if (streamValue is grpc:Error) {
            return streamValue;
        } else {
            record {|Tweet value;|} nextRecord = {value: <Tweet>streamValue.value};
            return nextRecord;
        }
    }

    public isolated function close() returns grpc:Error? {
        return self.anydataStream.close();
    }
}

public client class InstagramTweetCaller {
    private grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendTweet(Tweet response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextTweet(ContextTweet response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public client class InstagramStringCaller {
    private grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendString(string response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextString(wrappers:ContextString response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public type ContextTweetStream record {|
    stream<Tweet, error?> content;
    map<string|string[]> headers;
|};

public type ContextCommentMessage record {|
    CommentMessage content;
    map<string|string[]> headers;
|};

public type ContextTweet record {|
    Tweet content;
    map<string|string[]> headers;
|};

public type ContextReactionMessage record {|
    ReactionMessage content;
    map<string|string[]> headers;
|};

public type ContextPostMessage record {|
    PostMessage content;
    map<string|string[]> headers;
|};

@protobuf:Descriptor {value: INSTA_DESC}
public type CommentMessage record {|
    string comment = "";
    string messageId = "";
|};

@protobuf:Descriptor {value: INSTA_DESC}
public type Tweet record {|
    string id = "";
    string message = "";
    string time = "";
    int likes = 0;
    string[] comments = [];
|};

@protobuf:Descriptor {value: INSTA_DESC}
public type ReactionMessage record {|
    Reaction reaction = Like;
    string messageID = "";
|};

@protobuf:Descriptor {value: INSTA_DESC}
public type PostMessage record {|
    string message = "";
    string time = "";
|};

public enum Reaction {
    Like, Dislike
}

