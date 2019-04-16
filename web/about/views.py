import events
import logging
from django.shortcuts import render
from .forms import ChatSignupForm

logger = logging.getLogger('rocdev')


def index(request):
    context = {
        'next_event': events.get_next(),
        'has_registered': False,
        'chat_form': None,
        'num_members': 100,
        'num_active': 50,
    }
    if request.method == 'POST':
        chat_form = ChatSignupForm(request.POST)
        if chat_form.is_valid():
            # do the actual signup / invite sending here
            context.update({'has_registered': True})
    else:
        chat_form = ChatSignupForm()
        context.update({'chat_form': chat_form})
    return render(
        request, 'about/home.html', context=context)


def code_of_conduct(request):
    return render(request, 'about/code-of-conduct.html')
