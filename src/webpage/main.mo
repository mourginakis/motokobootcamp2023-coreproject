import Principal "mo:base/Principal";
import Text "mo:base/Text";
import Array "mo:base/Array";
import Http "http";


actor {
    public type HttpRequest = Http.HttpRequest;
    public type HttpResponse = Http.HttpResponse;

    stable var messages : [Text] = [];

    public shared func receive_message(message : Text) : async Nat {
        messages:= Array.append<Text>(messages, [message]);
        return messages.size();
    };

    public query func http_request(req : HttpRequest) : async HttpResponse {
        let displayText = Text.join("<br>", messages.vals());

        return({
            body = Text.encodeUtf8("<html>" # displayText # "</html>");
            headers = [];
            status_code = 200;
            streaming_strategy = null;
        })
    };

};