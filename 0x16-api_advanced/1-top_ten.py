#!/usr/bin/python3
"""
Script that queries the Reddit API
Returns: The titles of the first 10 hot posts listed for a given subreddit.
"""
import requests


def top_ten(subreddit):
    """returns the first 10 hot posts for the subreddit"""
    if subreddit is None or type(subreddit) is not str:
        return 0
    headers = {
        'User-Agent': '0x16-api_advanced:project:v1.0.0 (by /u/tami-cp0)'
    }
    url = f"https://www.reddit.com/r/{subreddit}/hot.json?limit=10"

    try:
        response = requests.get(url, headers=headers,
                                allow_redirects=False).json()
        [print(result['data']['title'])
            for result in response['data']['children']]
    except Exception as e:
        print(f"Error: {e}")
