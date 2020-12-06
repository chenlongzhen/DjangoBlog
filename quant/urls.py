#!/usr/bin/env python
# encoding: utf-8



from django.urls import path
from django.views.decorators.cache import cache_page
from . import views
from django.conf.urls import url
from haystack.forms import ModelSearchForm
from haystack.query import SearchQuerySet
from haystack.views import SearchView

app_name = "quant"
urlpatterns = [
    path(
        r'quant/', # html路径
        views.quant, # view
        name='archives'), # quant:archives
    ]
