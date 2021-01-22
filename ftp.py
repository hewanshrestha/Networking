# You can list the root directory using this code snippet.

import ftplib

ftp = ftplib.FTP("ftp.nluug.nl")
ftp.login("anonymous", "ftplib-example-1")

data = []

ftp.dir(data.append)

ftp.quit()

for line in data:
    print "-", line
