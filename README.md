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
|install ~malwer-worpet-bildet %blog
```

## Export
If you want to move your blog to another Urbit, run `:blog|export %.y`. If you want to serve your blog from a normal server, run `:blog|export %.n`. The file format for each of these cases is slightly different.

To see it, ensure you have mounted the blog desk with `|mount %blog`, and it will appear in unix.

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
