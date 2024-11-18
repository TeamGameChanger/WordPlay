WordPlay Design Project - README Template
===

# WordPlay

## Table of Contents

1. [Overview](#Overview)
2. [Product Spec](#Product-Spec)
3. [Wireframes](#Wireframes)
4. [Schema](#Schema)
5. [Sprints](#Sprints)
6. [Demo](#Demo)

## Overview

### Description

WordPlay is a recreational mobile app that challenges users to expand their creativity, vocabulary, and problem-solving skills through an engaging and logic-based word game. Designed to offer greater personalization and unique features beyond already existing word apps like Wordle, WordPlay motivates users to improve their memory, vocabulary, and cognitive abilities. Users can track personal statistics such as streaks and high scores aimed to improve their skills over time.

### App Evaluation

* **Category:** Entertainment, Education
* **Mobile:** Yes, it is a mobile application only.
* **Story:** WordPlay tells a story of continuous improvement, where users are challenged daily to surpass their previous word-solving abilities. It encourages a journey of mental growth and mastery of words, promoting a sense of personal accomplishment.
* **Market:** The target audience includes individuals of all ages interested in enhancing problem-solving, memorization, and vocabulary skills. This includes casual gamers, word enthusiasts, and people looking to improve language proficiency and cognitive functions.
* **Habit:** This app is designed for daily use, encouraging consistent engagement through daily challenges and streak-based rewards.
* **Scope:** The app has a broad scope with varied features, including statistics tracking, and goal setting, to cater to a wide range of user preferences and skills.

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

- [X] User can press a button to start the game
- [X] User can see a grid that is initially empty and fills up as they submit words
- [X] User can type and submit a word up to 6 times
- [X] User can see which letters are correct and whether or not they are in the correct position
- [X] User can see their score for the game
- [X] User can sign up with a username and password
- [X] User can login
- [X] User can logout

**Optional Nice-to-have Stories**

- [ ] User can only play the game once a day
- [X] User can select their desired gamemode (5 or 6 letter words)
- [X] User can see their current streak of consecutive days played
- [X] User can see their total number of games played
- [X] User can see their total number of wins
- [ ] User recieves a daily notification reminding them to play
- [ ] User can copy their score to share with friends
- [X] User can see a custom keyboard that keeps track of remaining letters

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
* User can see a grid that is initially empty and fills up as they submit words
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

## Sprints

### Sprint 1 Progress
<div>
    <a href="https://www.loom.com/share/eb2095ab669b458b9f49eb23acc303a4">
    </a>
    <a href="https://www.loom.com/share/eb2095ab669b458b9f49eb23acc303a4">
      <img style="max-width:300px;" src="https://cdn.loom.com/sessions/thumbnails/eb2095ab669b458b9f49eb23acc303a4-1d614c03bb6e27e8-full-play.gif">
    </a>
  </div>

### Sprint 2 Progress
<div>
    <a href="https://www.loom.com/share/f2b4a1d131fa42f5b58faf1d2a15e96f">
    </a>
    <a href="https://www.loom.com/share/f2b4a1d131fa42f5b58faf1d2a15e96f">
      <img style="max-width:300px;" src="https://cdn.loom.com/sessions/thumbnails/f2b4a1d131fa42f5b58faf1d2a15e96f-2f760d1fdb97bd6f-full-play.gif">
    </a>
  </div>

### Sprint 3 Progress
<div>
    <a href="https://www.loom.com/share/f8bd3dca595842debc8d10539bac014f">
    </a>
    <a href="https://www.loom.com/share/f8bd3dca595842debc8d10539bac014f">
      <img style="max-width:300px;" src="https://cdn.loom.com/sessions/thumbnails/f8bd3dca595842debc8d10539bac014f-297c1c2bd0377b0a-full-play.gif">
    </a>
  </div>

## Demo
<div>
    <a href="https://www.loom.com/share/f08d2305025e4754b8b4d00fa5f37c6f">
    </a>
    <a href="https://www.loom.com/share/f08d2305025e4754b8b4d00fa5f37c6f">
      <img style="max-width:300px;" src="https://cdn.loom.com/sessions/thumbnails/f08d2305025e4754b8b4d00fa5f37c6f-92ae7d4583123dd0-full-play.gif">
    </a>
  </div>

