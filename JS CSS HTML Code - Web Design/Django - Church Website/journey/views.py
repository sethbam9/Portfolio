from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.decorators import login_required
from django.db import IntegrityError
from django.http import HttpResponse, HttpResponseRedirect
from django.shortcuts import render
from django.urls import reverse
from django.core.paginator import Paginator

from .models import *

# The main page.
def home_page(request):

    values = CoreValue.objects.all()

    return render(request, "journey/index.html", {
        'values': values
    })

def about_page(request):

    return render(request, "journey/about.html", {

    })

def values_page(request):

    values = CoreValue.objects.all()

    return render(request, "journey/values.html", {
        'values': values
    })

def our_team_page(request):

    team = TeamMember.objects.all()

    return render(request, "journey/our_team.html", {
        'team': team
    })

def beliefs_page(request):

    return render(request, "journey/beliefs.html", {

    })

def outreach_page(request):

    return render(request, "journey/outreach.html", {

    })

# Renders 10 posts per page.
def get_page(request, posts):

    page_num = request.GET.get('page', 1) # if not found, assign 1.
    paginator = Paginator(posts, 5) # display 10 posts per page.
    page = paginator.page(page_num)

    return page


def blog_page(request):

    blog_posts = BlogPost.objects.order_by("-written_on").all()
    most_viewed = BlogPost.objects.order_by("-views").all()
    categories = BlogCategory.objects.order_by("category").all()
    authors = BlogAuthor.objects.order_by("author").all()

    return render(request, "journey/blog.html", {
        'page': get_page(request, blog_posts),
        'most_viewed': most_viewed,
        'categories': categories,
        'authors': authors
    })

def blog_post_page(request, title):

    blog_post = BlogPost.objects.get(title=title)

    return render(request, "journey/blog_post.html", {
        'blog_post': blog_post,
        # 'most_viewed': most_viewed,
        # 'categories': categories,
        # 'authors': authors
    })

def contact_page(request):

    return render(request, "journey/contact.html", {

    })


def login_view(request):
    if request.method == "POST":

        # Attempt to sign user in
        username = request.POST["username"]
        password = request.POST["password"]
        user = authenticate(request, username=username, password=password)

        # Check if authentication successful
        if user is not None:
            login(request, user)
            return HttpResponseRedirect(reverse("index"))
        else:
            return render(request, "journey/login.html", {
                "message": "Invalid username and/or password."
            })
    else:
        return render(request, "journey/login.html")


def logout_view(request):
    logout(request)
    return HttpResponseRedirect(reverse("index"))


def register(request):
    if request.method == "POST":
        username = request.POST["username"]
        email = request.POST["email"]

        # Ensure password matches confirmation
        password = request.POST["password"]
        confirmation = request.POST["confirmation"]
        if password != confirmation:
            return render(request, "journey/register.html", {
                "message": "Passwords must match."
            })

        # Attempt to create new user
        try:
            user = User.objects.create_user(username, email, password)
            user.save()
        except IntegrityError:
            return render(request, "journey/register.html", {
                "message": "Username already taken."
            })
        login(request, user)
        return HttpResponseRedirect(reverse("index"))
    else:
        return render(request, "journey/register.html")
