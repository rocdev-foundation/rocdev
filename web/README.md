# RocDev Web

This is a standard Django project using SQLite.


## Contributing

Requirements:

* Python 3.6+
* Django 2+
* pipenv
* django-bootstrap4
* django_ical

To contribute to this project:

1. Fork the repo to your own account
2. Clone your fork locally
3. In the repo's main directory, run `pipenv install` to create a virtual environment and install the dependencies
4. Run `pipenv install --dev` to install the development dependencies
5. Run `pipenv shell` to activate the virtual environment
6. Install these dependencies separately: `pip install django-bootstrap4` and `pip install django_ical`
7. Change to the web directory and run `python manage.py migrate`
8. Start the server: `python manage.py runserver`

