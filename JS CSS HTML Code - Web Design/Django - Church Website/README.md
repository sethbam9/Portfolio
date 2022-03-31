# PROJECT DESCRIPTION
journeychurch is a web application for Journey Christian Church LA in Lake
Charles, Louisiana. The aim is for the app to contain most of the standard
components of a church website such as 'home', 'about', 'contact', and 'support'
pages.

## PROJECT FILES

### Main Files (journeychurch/journeychurch/)

* settings.py
  * add 'journey' to INSTALLED_APPS
  * add 'AUTH_USER_MODEL = 'journey.User''
  * add 'DEFAULT_AUTO_FIELD = 'django.db.models.AutoField''
  * add 'MEDIA_URL = '/media/'
         MEDIA_ROOT = os.path.join(BASE_DIR, 'media')'


* urls.py
  * add 'path("", include("journey.urls"))' to access my app at the index.
  * add '+ static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)' to utilize
    media files in the form 'src="{{object.media_name.url}}"'.


### App Files (journeychurch/journey/)
* admin.py
* models.py
  * Install Pillow for ImageField: https://pypi.org/project/Pillow/ (or run 'python -m pip install Pillow')
  * I created models for just about all the content on the site. My intent in doing so was to eventually use
    JavaScript to develop an easy-to-use front end editing system for authorized users. For example, if a user
    is organized they could see an edit button to update a CoreValue YouTube link on the front end of the
    Core Values page.
  * BlogAuthor is created so that blogs can be sorted by author without having to create users with usernames
    and passwords.

* urls.py
* views.py

### Template Files (journeychurch/journey/templates/journey/)
  My design for the site was targeting simplicity and a clean layout.
  All of my html files have a an image at the top which is a placeholder. This allows
  the white navbar items to be seen and to provide an elegant look. I will highlight notable
  files below.
* layout.html - this has the navbar and other important elements. 
* index.html this is the landing page.


### Static Files (journeychurch/journey/static/journey/)
* styles.css
* favicon.ico
  * This is the icon for journeychurch. The idea is from
    https://learndjango.com/tutorials/django-favicon-tutorial.
