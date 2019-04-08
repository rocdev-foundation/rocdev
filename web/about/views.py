import logging
from django.shortcuts import render
import events

logger = logging.getLogger('rocdev')


def index(request):
    return render(
        request, 'about/home.html', context={'next_event': events.get_next()})


def code_of_conduct(request):
    return render(request, 'about/code-of-conduct.html')
