import logging
from django.core.cache import cache
import requests

logger = logging.getLogger('rocdev')


def warm_cache():
    next_events_response = requests.get(
        'https://api.meetup.com/RocDev/events',
        params={
            'status': 'upcoming',
            'page': 10
        })
    try:
        next_events_response.raise_for_status()
        next_events = next_events_response.json()
        cache.set('next_events', next_events, 60 * 60)
        logger.info('warmed next_events cache')
    except Exception:
        logger.error('error warming event cache')


def all():
    if cache.get('next_events') is None:
        warm_cache()
    return cache.get('next_events')


def get_next():
    return all()[0]
