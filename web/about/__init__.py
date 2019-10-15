from django.conf import settings
from django.core.cache import cache
import requests
import logging

logger = logging.getLogger('rocdev')


def warm_member_cache():
    members_response = requests.get(
        f'{settings.SLACK_API_BASE}/users.list',
        params={
            'token': settings.SLACK_API_TOKEN,
            'presence': 1
        })
    try:
        members_response.raise_for_status()
        members = members_response.json()
        if members['ok']:
            cache.set('members', members['members'], 60 * 60)
            logger.info('warmed member cache')
        else:
            logger.error(f'error warming cache: {members["error"]}')
    except Exception:
        logger.error('error warming member cache')


def members():
    if cache.get('members') is None:
        warm_member_cache()
    return cache.get('members')


def active_members():
    return [
        m for m in members() if 'presence' in m and m['presence'] == 'active'
    ]
