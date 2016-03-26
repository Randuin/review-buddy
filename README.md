[![Build Status](https://travis-ci.org/reviewbuddy/review-buddy.svg?branch=master)](https://travis-ci.org/reviewbuddy/review-buddy)
[![Code Climate](https://codeclimate.com/github/reviewbuddy/review-buddy/badges/gpa.svg)](https://codeclimate.com/github/reviewbuddy/review-buddy)
[![Test Coverage](https://codeclimate.com/github/reviewbuddy/review-buddy/badges/coverage.svg)](https://codeclimate.com/github/reviewbuddy/review-buddy/coverage)

# Review Buddy API

A GraphQL API for Review Buddy, an application helping to keep track of Pull Request reviews, to automate the reviewing process and pick potential reviewers for a Pull Request.

## How it works

Everytime somebody comments on a PR in a repo, Review Buddy receives a webhook. By analysing the comment body, Review Buddy tries to guess if the comment is an ask for review. For example: "Please review @xuorig" would be an ask for review, and "This looks good! :ship:!" would be a normal comment.

If Review Buddy finds that it's an ask for review, it will add it to the user's list of Pull Requests.

## Understanding the comment

Review Buddy API tries to understand the body of a comment by using a small machine learning service written in python which you can find here: https://github.com/reviewbuddy/intent-service

