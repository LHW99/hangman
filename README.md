# Hangman

A hangman game built using Ruby 2.7.0 that can be played from the terminal.

## Getting started

Main .rb files are in /lib directory. 

In **/lib/mainmenu.rb**, change the first line of code to properly direct to your local **hangman.rb** file.

## Playing the game

Launch the game from the terminal

> ruby mainmenu.rb

You can start a new game or load a saved one.

![ss1](https://github.com/LHW99/hangman/blob/master/screenshots/1.png)

If you start a new game, you will be presented with the game interface. It will show you how many letters the secret work is, what letters have been, guessed, and how many tries your have left. 

![ss2](/screenshots/2.png?raw=true)

The game ends when you guess the word or fail to do so. You will be prompted to play again if you'd like.

![ss3](/screenshots/3.png?raw=true)