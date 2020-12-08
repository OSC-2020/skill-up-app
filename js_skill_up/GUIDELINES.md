# Dev Guidelines

## Direcotry convention

1. `screens`: All UI related files that occupy full screen.

   a. Widgets: Building blocks of screens.

2. `services`: anything not native to app (`iOS`/`andrdoid`) or `Flutter`.
3. `utils`: Code that is not specific to this repo
4. `constants`: Internally used strings.
5. `locale`: Any string visible to user.
6. `config`: env related files.

## Development

1.  Do not leave any string in code.

    a. Strings visible to user: Make them available via `locale`

    b. Usable in code: Make them available via `constants`

        Only exception to this are strings used for logging.
