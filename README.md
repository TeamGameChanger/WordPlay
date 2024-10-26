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

* [User can [specific action, e.g., register an account]]
* ...

**Optional Nice-to-have Stories**

* [User can [specific action, e.g., persist user information across working sessions]]
* ...

### 2. Screen Archetypes

- [ ] [**Screen Name, e.g., Login Screen**]
* [Required User Feature: User can log in.]
- [ ] [**Another Screen Name**]
* [Associated required user story]
...
...
...

### 3. Navigation

**Tab Navigation** (Tab to Screen)


- [ ] [First Tab, e.g., Home Feed]
- [ ] [Second Tab, e.g., Profile]
...
...
...

**Flow Navigation** (Screen to Screen)

- [ ] [**Screen Name**]
  * Leads to [**Next Screen**]
- [ ] [**Another Screen Name**]
  * Leads to [**Another Screen**] 


## Wireframes

[Add picture of your hand sketched wireframes in this section]

### [BONUS] Digital Wireframes & Mockups

### [BONUS] Interactive Prototype

## Schema 


### Models

[Model Name, e.g., User]
| Property | Type   | Description                                  |
|----------|--------|----------------------------------------------|
| username | String | unique id for the user post (default field)   |
| password | String | user's password for login authentication      |
| streak | Int | stores the greatest number of days the user has consecutively played |
| totalGames | Int | total number of games played by the user   |
| defaultSize | Int | default size of word user prefer to play (i.e. default 5 letter vs 6 letter word |


### Networking
- User Registration Screen
[POST] /users/register - to register new user in database
- User Login Screen
[POST] /users/login - to check if information successfully matches information from database 
- Main Gameplay Screen
[GET] /users/:username/userStats - to get information about user stats, which includes the streak, totalGames, and defaultSize 

