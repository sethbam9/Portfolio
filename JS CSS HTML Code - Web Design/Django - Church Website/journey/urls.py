from django.urls import path

from . import views

urlpatterns = [
    path("", views.home_page, name="home"),
    path("about", views.about_page, name="about"),
    path("about/values", views.values_page, name="values"),
    path("about/our-team", views.our_team_page, name="our_team"),
    path("about/beliefs", views.beliefs_page, name="beliefs"),
    path("outreach", views.outreach_page, name="outreach"),
    path("blog", views.blog_page, name="blog"),
    path("blog/<str:title>/", views.blog_post_page, name="blog_post"),
    path("contact", views.contact_page, name="contact"),
    path("login", views.login_view, name="login"),
    path("logout", views.logout_view, name="logout"),
    path("register", views.register, name="register")
]
