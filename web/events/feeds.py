from datetime import datetime, timedelta
from django.contrib.syndication.views import Feed
from django.utils.feedgenerator import Atom1Feed
from django_ical.views import ICalFeed
from . import all


class RssEventsFeed(Feed):
    title = 'RocDev Events'
    link = '/events/'
    description = 'Upcoming RocDev event feed.'
    description_template = 'events/item_description.html'

    def items(self):
        return all()

    def item_title(self, item):
        return item['name']

    def item_link(self, item):
        return item['link']


class AtomEventsFeed(RssEventsFeed):
    feed_type = Atom1Feed
    subtitle = RssEventsFeed.description


class ICalEventsFeed(ICalFeed):
    product_id = '-//rocdev.org//RocDev//EN'
    timezone = 'US/Eastern'
    file_name = 'rocdev.ics'
    description_template = 'events/item_description.html'

    def items(self):
        return all()

    def item_title(self, item):
        return item['name']

    def item_link(self, item):
        return item['link']

    def item_start_datetime(self, item):
        return datetime.strptime(
            '{} {}'.format(item['local_date'], item['local_time']),
            '%Y-%m-%d %H:%M')

    def item_end_datetime(self, item):
        return self.item_start_datetime(item) + timedelta(hours=2)

    def item_location(self, item):
        return item['venue']['name'] if 'venue' in item else None

    def item_geolocation(self, item):
        return (item['venue']['lat'],
                item['venue']['lon']) if 'venue' in item else None
