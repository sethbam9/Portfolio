from django.contrib.auth.models import AbstractUser
from django.db import models

class User(AbstractUser):
    subscriber = models.BooleanField(default=False)

    def __str__(self):
        return f"{self.first_name} {self.last_name}"

class BlogCategory(models.Model):
    category = models.CharField(blank=True, null=True, max_length=100)

    def __str__(self):
        return f"{self.category}"

class BlogAuthor(models.Model):
    author = models.CharField(max_length=100)

    def __str__(self):
        return f"{self.author}"

class BlogPost(models.Model):
    author = models.ForeignKey(BlogAuthor, on_delete=models.CASCADE)
    image = models.ImageField(upload_to='blog')
    title = models.CharField(max_length=200)
    content = models.TextField()
    written_on = models.DateField()
    category = models.ForeignKey(BlogCategory, on_delete=models.CASCADE)
    views = models.PositiveIntegerField()

    def __str__(self):
        return f"{self.title}"

class Comment(models.Model):
    commentor = models.ForeignKey(User, on_delete=models.CASCADE)
    content = models.TextField(max_length=1000)

class CoreValue(models.Model):
    name = models.CharField(max_length=50)
    content = models.TextField()
    image = models.ImageField(blank=True, null=True, upload_to='values')
    video = models.URLField()

    def __str__(self):
        return f"{self.name}"

class Service(models.Model):
    name = models.CharField(max_length=50)
    location = models.CharField(max_length=200)
    content = models.TextField()

    def __str__(self):
        return f"{self.name}"

class TeamMember(models.Model):
    name = models.CharField(max_length=100)
    role = models.CharField(max_length=100, default="a")
    bio = models.TextField()
    image = models.ImageField(blank=True, null=True, upload_to='team')
    email = models.EmailField(blank=True, null=True)

    def __str__(self):
        return f"{self.name}"
