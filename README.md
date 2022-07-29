# colorbot

A simple discord bot written in COBOL.

## What does it do?

Use `col!mycolor` to see what the bot thinks your color is.
It's like a BuzzFeed quiz but without the quiz.

## How do I use it?

First, make sure you clone the repository with the `--recursive` flag,
since the [Concord](https://github.com/Cogmasters/concord) library is included as a submodule.
The Makefile for this project should build Concord as well;
make sure you install [the dependencies listed in Concord's README](https://github.com/Cogmasters/concord#build-instructions) first though.
Then, as long as you have GNU COBOL installed, you should be able to build the bot with `make`.
I've only tested this on Ubuntu 20.04 with GNU COBOL 2;
building the bot elsewhere is left as an exercise to the reader.

To run the bot, first copy `config-ex.json` to `config.json` and put your bot token in the empty `token` field.
You can also change the command prefix here; by default it's set to `col!`.
Then, run `./main` to run the bot.
