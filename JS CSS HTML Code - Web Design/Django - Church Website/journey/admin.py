from django.contrib import admin

# Register your models here.
from .models import *

for item in [User, BlogPost, BlogCategory, BlogAuthor, Comment, CoreValue, Service, TeamMember]:
    admin.site.register(item)
