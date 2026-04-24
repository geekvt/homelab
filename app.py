#!/usr/bin/env python3
import http.server
import socketserver
import os

PORT = int(os.getenv('PORT', 3000))

class HelloHandler(http.server.SimpleHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.send_header('Content-type', 'text/plain')
        self.end_headers()
        self.wfile.write(b'Hello from Python!\n')

    def log_message(self, format, *args):
        print(f'[{self.log_date_time_string()}] {format % args}')

with socketserver.TCPServer(('', PORT), HelloHandler) as httpd:
    print(f'Server running on port {PORT}')
    httpd.serve_forever()
