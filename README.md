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

[Provide a brief description of your app, its purpose, and functionality.]

### App Evaluation

[Evaluation of your app across the following attributes]
- **Category:** [e.g., Social, Entertainment, Education]
- **Mobile:** [Is it a mobile application only?]
- **Story:**  [What story does your app tell?]
- **Market:** [Target audience for the app]
- **Habit:** [Is it a daily use app or occasional use?]
- **Scope:** [Is it a broad or narrow app in terms of features?]

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

[Add picture of your hand sketched wireframes in this section]

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

