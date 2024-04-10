#!/usr/bin/python3
"""
Script that queries the Reddit API
Returns: The number of subscribers (not active users, total subscribers)
         for a given subreddit.
         If an invalid subreddit is given, the function should return 0.
"""
import requests


def number_of_subscribers(subreddit):
    """returns the number of subscribers for a given subreddit"""
    if subreddit is None or type(subreddit) is not str:
        return 0
    r = requests.get('http://www.reddit.com/r/{}/about.json'.format(subreddit),
                     headers={'User-Agent': '0x16-api_advanced:project:\
                     v1.0.0 (by /u/firdaus_cartoon_jr)'}).json()
    subs = r.get("data", {}).get("subscribers", 0)
    return subs
