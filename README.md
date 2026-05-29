# Hugo Project Hub

Hugo Project Hub is a reusable Hugo Module theme for publishing simple project
hubs: stable project timelines with updates, notes, and links in one browser
location.

The theme is meant to be imported by a real Hugo site. Each project owns its
own content and configuration while this module provides the shared project hub
defaults and presentation layer.

## Installation

In the consuming site's `hugo.toml`, import the module by its public path:

```toml
[module]
  [[module.imports]]
    path = "github.com/adambrett/hugo-project-hub"
```

This keeps the hub site independent from the theme repository. The consuming
site uses Hugo Modules instead of cloning a starter site or adding a nested
`themes/` directory.

## Configuration

Project Hub options live under the `[params.projectHub]` namespace:

```toml
[params.projectHub]
  dateFormat = "2 January 2006"
  footer = ""
```

`dateFormat` is the Hugo date layout used by project hub templates when showing
project dates. `footer` is optional footer text for the generated hub.

## Requirements

- Hugo Extended `0.162.0` or newer.
- Go for Hugo Module resolution.
- Git for fetching module dependencies.
