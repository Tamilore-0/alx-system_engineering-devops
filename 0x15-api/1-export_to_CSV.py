#!/usr/bin/python3
"""
Fetch user's todo data from a REST API and write it to a CSV file.
"""
import csv
import json
import requests
import sys


if len(sys.argv) == 2:
    # file to store csv info
    file_path = 'USER_ID.csv'
    url = f'https://jsonplaceholder.typicode.com/users/{sys.argv[1]}'
    response_user = requests.get(url)
    url += '/todos'
    response_todo = requests.get(url)

    try:
        json_data = response_user.json()
        username = json_data['username']
        employee_name = json_data['name']
        # get user's todo in json format
        json_data = response_todo.json()
    except json.JSONDecodeError:
        print('Not a valid JSON!')

    rows = []
    for data in json_data:
        row = {
                "USER_ID": data['userId'],
                "USERNAME": username,
                "TASK_COMPLETED_STATUS": data["completed"],
                "TASK_TITLE": data["title"]
            }
        rows.append(row)

    tasks = 0
    titles = ''
    done_tasks = 0
    for data in json_data:
        if data.get('completed') is True:
            titles = titles + '\t ' + data['title'] + '\n'
            done_tasks += 1
        tasks += 1

    print(f"Employee {employee_name} is done with "
          f"tasks({done_tasks}/{tasks}):\n{titles}", end='')

    with open(file_path, mode='w') as file:
        fieldnames = ["USER_ID", "USERNAME",
                      "TASK_COMPLETED_STATUS", "TASK_TITLE"]
        # write from a dict
        file_writer = csv.DictWriter(file, fieldnames=fieldnames,
                                     quoting=csv.QUOTE_ALL)
        # write data to csv file
        file_writer.writerows(rows)
