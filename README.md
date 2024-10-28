WordPlay Design Project - README Template
===

# WordPlay

## Table of Contents

1. [Overview](#Overview)
2. [Product Spec](#Product-Spec)
3. [Wireframes](#Wireframes)
4. [Schema](#Schema)

## Overview

### Description

WordPlay is a recreational mobile app that challenges users to expand their creativity, vocabulary, and problem-solving skills through an engaging and logic-based word game. Designed to offer greater personalization and unique features beyond already existing word apps like Wordle, WordPlay motivates users to improve their memory, vocabulary, and cognitive abilities. Users can track personal statistics such as streaks and high scores aimed to improve their skills over time.

### App Evaluation

* Category: Entertainment, Education
* Mobile: Yes, it is a mobile application only.
* Story: WordPlay tells a story of continuous improvement, where users are challenged daily to surpass their previous word-solving abilities. It encourages a journey of mental growth and mastery of words, promoting a sense of personal accomplishment.
* Market: The target audience includes individuals of all ages interested in enhancing problem-solving, memorization, and vocabulary skills. This includes casual gamers, word enthusiasts, and people looking to improve language proficiency and cognitive functions.
* Habit: This app is designed for daily use, encouraging consistent engagement through daily challenges and streak-based rewards.
* Scope: The app has a broad scope with varied features, including statistics tracking, and goal setting, to cater to a wide range of user preferences and skills.

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* User can press a button to start the game
* User can type and submit a word up to 6 times
* User can see which letters are correct and whether or not they are in the correct position
* User can see their score for the game
* User can sign up with a username and password
* User can login
* User can logout

**Optional Nice-to-have Stories**

* User can only play the game once a day
* User can select their desired gamemode (5 or 6 letter words)
* User can see their highest streak of consecutive days played
* User can see their total number of games played
* User can see their total number of wins
* User recieves a daily notification reminding them to play
* User can copy their score to share with friends
* User can see a custom keyboard that keeps track of remaining letters

### 2. Screen Archetypes

**Login Screen**
* User can login
  
**Sign Up Screen**
* User can sign up with a username and password
  
**Start Screen**
* User can select their desired gamemode (5 or 6 letter word)
* User can press a button to start the game
* User can see their highest streak of consecutive days played
* User can see their total number of games played
* User can see their total number of wins
* User can logout
  
**Gameplay Screen**
* User can type and submit a word up to 6 times
* User can see which letters are correct and whether or not they are in the correct position
* User can see their score for the game

### 3. Navigation

**Tab Navigation** (Tab to Screen)

- None for now

**Flow Navigation** (Screen to Screen)

- **Login Screen**
  * Leads to **Start Screen** if user logs in successfully
  * Leads to **Sign Up Screen** if user chooses to sign up instead of logging in
- **Sign Up Screen**
  * Leads to **Start Screen** if user signs up successfully
  * Leads to **Login Screen** if user chooses to login instead of signing up
- **Start Screen**
  * Leads to **Gameplay Screen** if user presses button to start game
  * Leads to **Login Screen** if user logs out
- **Gameplay Screen**
  * Leads to **Start Screen** once game has finished

## Wireframes

<img src="https://i.imgur.com/f1MkShs.jpeg" width=600>`

### [BONUS] Digital Wireframes & Mockups

### [BONUS] Interactive Prototype

## Schema 


### Models

[User Model]
| Property | Type   | Description                                  |
|----------|--------|----------------------------------------------|
| username | String | unique id for the user post (default field)   |
| password | String | user's password for login authentication      |

[Stat Model]
| Property | Type   | Description                                  |
|----------|--------|----------------------------------------------|
| username | String | unique id for the user post (default field)   |
| streak | Int | stores the greatest number of days the user has consecutively played |
| totalWon | Int | total number of games won by the user   |
| totalGames | Int | total number of games played by the user   |
| lastGameDate | Date | date of the last time the user played the game  |
| defaultSize | Int | default size of word user prefer to play (i.e. default 5 letter vs 6 letter word |


### Networking
 - User Registration Screen
- [ ] [POST] /users/register - to register new user containing username and password in database
 - User Login Screen
- [ ] [POST] /users/login - to check if information successfully matches information from database 
 - Main Gameplay Screen
- [ ] [GET] /users/:username/userStats - to get information about user stats, which includes the streak, lastGameDate, totalWon, totalGames, and defaultSize 

