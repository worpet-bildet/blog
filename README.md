# %blog

%blog lets you create and serve a simple html website from your ship.

## Features

- Markdown support
- Custom CSS themes
- Drafts
- Serve your %blog from the same domain as your ship with zero config

## Installation

Install %blog with

```
|install ~hanrut-sillet-dachus-tiprel %blog
```

## Export

You can export your %blog with `:blog|export %.y` in the dojo. This will create a folder inside your blog desk called `/export`. You can pass `%.n` instead if you don't want the css to appended to the exporte HTML.

To see it, ensure you have mounted the blog desk with `|mount %blog`.

## Import

After an export (or if you have files from elsewhere), you can import files into %blog. First make sure they have the same structure as an export, it should look something like this in your desk:

```
/blog
  /import
    /published
      /md
      /html
    /drafts
    /themes
```

Then run `-blog!import` in the dojo.