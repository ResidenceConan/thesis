#!/bin/python

import requests
import re
import os
import sys

base_url = "https://jira.robinsuter.ch"
api_url = "/rest/api/2/issue/{}/attachments"
headers = {"X-Atlassian-Token": "nocheck"}
jira_user = os.environ.get("JIRA_USER")
jira_pw = os.environ.get("JIRA_PW")
jira_prefix = "PZ"
branch = os.environ.get("TRAVIS_BRANCH")


def get_issue_key():
    prefix_re = str.format(r'.*({}-\d+).*', jira_prefix)
    m = re.match(prefix_re, branch, re.I)
    if m is None:
        print(str.format("Issue key of branch {} not found", branch))
        exit(1)
    return m.group(1)


def get_file(filename):
    return open(filename, 'rb')


if (len(sys.argv) < 2):
    print("Must provide filename as argument!")
    exit(1)

issue_key = get_issue_key()
request_url = base_url + str.format(api_url, issue_key)
filename = sys.argv[1]
files = {'file': get_file(filename)}

req = requests.post(request_url, auth=(jira_user, jira_pw), files=files, headers=headers)

if (req.status_code == 200):
    print(str.format('upload of {} to issue {} successful', filename, issue_key))
else:
    print(str.format('Upload to JIRA failed: {}', req.text))
