from django.urls import path
from . import views

urlpatterns = [
    path('', views.index, name='about_index'),
    path('code-of-conduct/', views.code_of_conduct, name='about_coc'),
]
