import smtplib
import getpass

# configure, login, sending, quit

#configure

smtpserver = smtplib.SMTP_SSL("smtp.gmail.com", 465)

#login
smtpserver.login("shresthahewan12@gmail.com", getpass())

#sending the mail
smtpserver.sendmail("shresthahewan12@gmail.com","18691a05i1@mits.ac.in","Welcome To The Computer Networks Laboratory tutorial on sending email using Python.")

#quit
smtpserver.quit()
