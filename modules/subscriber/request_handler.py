#!/usr/bin/env python

from BaseHTTPServer import HTTPServer, BaseHTTPRequestHandler


count = 0


class RequestHandler(BaseHTTPRequestHandler):

    def do_GET(self):

        request_path = self.path

        print("\n----- Request Start ----->\n")
        print(request_path)
        print(self.headers)
        print("<----- Request End -----\n")

        self.send_response(200)
        self.end_headers()


    def do_POST(self):
        global count
        count += 1

        print('\n----- Request %s Start ----->\n' % str(count))
        print(self.path)

        content_length = self.headers.getheaders('content-length')
        length = int(content_length[0]) if content_length else 0

        print(self.headers)
        print(self.rfile.read(length))
        print("<----- Request " + str(count) + "  End -----\n")
        
        if self.path == '/5xx':
            self.send_response(500)
        elif self.path == '/3xx':
            self.send_response(301)
            self.send_header('Location', 'http://subscriber:8099/new-location')
        else:
            self.send_response(200)
        
        self.end_headers()


def main():
    port = 8099
    print('Listening on localhost:%s' % port)
    server = HTTPServer(('', port), RequestHandler)
    server.serve_forever()


if __name__ == "__main__":
    main()
