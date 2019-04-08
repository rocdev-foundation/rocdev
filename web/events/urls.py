from django.urls import path
from . import views, feeds

urlpatterns = [
    path('', views.index, name='events_index'),
    path('rss/', feeds.RssEventsFeed(), name='events_rss'),
    path('atom/', feeds.AtomEventsFeed(), name='events_atom'),
    path('ics/', feeds.ICalEventsFeed(), name='events_ics'),
]
