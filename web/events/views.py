from django.shortcuts import render
from . import all


def index(request):
    return render(request, 'events/all.html', context={'events': all()})
