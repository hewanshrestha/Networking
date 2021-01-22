import sys
import telnetlib

HOST = "www.python.org"
PORT = "80"

telnetObj=telnetlib.Telnet(HOST,PORT)
message = ("GET /index.html HTTP/1.1\nHost:"+HOST+"\n\n").encode('ascii')
telnetObj.write(message)
output=telnetObj.read_all()
print(output)
telnetObj.close()
