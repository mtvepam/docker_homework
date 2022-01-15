#!/bin/bash
# wait for database
sleep 11
# create user
if [ -z $DJANGO_SUPERUSER_PASSWORD ]; then
    DJANGO_SUPERUSER_PASSWORD="Qwe123!@#"
fi
/usr/local/bin/python manage.py migrate
/usr/local/bin/python manage.py createsuperuser --noinput --username $DJANGO_SUPERUSER_USERNAME --email $DJANGO_SUPERUSER_EMAIL
/usr/local/bin/python parse_docx.py
/usr/local/bin/python manage.py runserver 0.0.0.0:8000
echo has started




