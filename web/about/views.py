import events
import logging
import requests
from django.conf import settings
from django.shortcuts import render
from .forms import ChatSignupForm
from . import members, active_members

logger = logging.getLogger('rocdev')

SLACK_ERRORS = {
    'already_in_team': 'You are already a member of RocDev',
    'already_invited': 'We already sent you an email invitation',
    'already_in_team_invited_user': 'You are already a member of RocDev',
    'channel_not_found': 'Provided channel ID does not match a real channel',
    'invalid_email': 'Slack thinks you have an invalid email address',
    'invalid_auth':
    'Security configuration error, please contact the webmaster',
    'invite_limit_reached': 'The maximum number of invites is reached',
    'missing_scope':
    'Security configuration error, please contact the webmaster',
    'not_allowed':
    ' Security configuration error, please contact the webmaster',
    'not_allowed_token_type':
    'Security configuration error, please contact the webmaster',
    'not_authed': 'Security configuration error, please contact the webmaster',
    'requires_one_channel':
    'Security configuration error, please contact the webmaster',
    'sent_recently': 'We already sent you an email invitation',
    'ultra_restricted':
    'Security configuration error, please contact the webmaster',
    'user_disabled': 'This Slack user account has been deactivated'
}


def index(request):
    context = {
        'next_event': events.get_next(),
        'has_registered': False,
        'chat_form': None,
        'num_members': len(members()),
        'num_active': len(active_members()),
        'error': None
    }
    if request.method == 'POST':
        chat_form = ChatSignupForm(request.POST)
        if chat_form.is_valid():
            # Send invite using poorly documented Slack invite API. See
            # https://github.com/ErikKalkoken/slackApiDoc/blob/master/users.admin.invite.md
            # for unofficial docs.
            email = chat_form.cleaned_data['email']
            url = (
                f'{settings.SLACK_INVITE_API_BASE}'
                f'?token={settings.SLACK_API_TOKEN}&email={email}&resend=true')
            response = requests.get(url)
            payload = response.json()
            if payload['ok'] is False:
                msg = SLACK_ERRORS[payload['error']]
                logger.warning(msg)
                context.update({'error': msg})
            context.update({'has_registered': True})
    else:
        chat_form = ChatSignupForm()
        context.update({'chat_form': chat_form})
    return render(request, 'about/home.html', context=context)


def code_of_conduct(request):
    return render(request, 'about/code-of-conduct.html')
