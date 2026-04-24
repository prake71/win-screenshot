# win-screenshot

Insert the most recent Windows screenshot directly into an Org buffer.

`win-screenshot` is a small Emacs utility that integrates the Windows
screenshot workflow (`Win + Shift + S`) with Org mode.  It copies the
most recent screenshot into a local `./images/` directory and inserts
an Org file link at point.

---

## Features

- Insert the latest Windows screenshot into an Org buffer
- Copy screenshots into a project-local `images/` directory
- Insert proper Org `[[file:...]]` links
- Optional inline image display
- Configurable screenshot source directory
- Lightweight and dependency-free
- Designed for daily documentation workflows

---

## Requirements

- Emacs **27.1** or newer
- Org mode **9.4** or newer
- Windows (or WSL with access to the Windows screenshot directory)

---

## Recommended Installation (use-package)

This is the **recommended way** to use `win-screenshot` in your own Emacs configuration.

### 1. Place the file

Copy `win-screenshot.el` into a directory on your load path, for example:

```
~/.emacs.d/lisp/win-screenshot.el
```

## Configure Emacs

Add the following use-package configuration to your Emacs setup
(init.el, init.org, or a loaded module):

```
(use-package win-screenshot
  :load-path "~/.emacs.d/lisp"
  :commands (win-screenshot-here)
  :hook (org-mode . win-screenshot-mode)
  :custom
  (win-screenshot-source-dir
   "C:/Users/<YourUser>/OneDrive/Pictures/Screenshots"))
```

What this setup does

- Enables lazy loading (package loads only when needed)
- Activates win-screenshot-mode automatically in Org buffers
- Keeps configuration clean and centralized
- Integrates naturally into an Org-based workflow

The path needs to correspond with the settings of the path within your
screenshot tool. For Snipping Tool you can configure/find the path in the
settings menu in `Snipping section -> Screenshots are saved to`.

The win-screenshot-source-dir can be also adjusted with the Emacs
Customization (see below).

## Usage

Insert the most recent screenshot

Take a screenshot using Win + Shift + S
Switch to an Org buffer in Emacs
Run:

```
M-x win-screenshot-here
```

This will:

Copy the latest screenshot into ./images/
Insert an Org link at point

```
[[file:images/2026-04-16T17-03-12.png]]
```

Inline Images
win-screenshot inserts links, not images.
To toggle inline image display in Org mode:

```
M-x org-toggle-inline-images
```

This allows you to work with links while writing, and preview images only when needed.

Key Bindings (Minor Mode)
When win-screenshot-mode is enabled (recommended), you can define key bindings scoped to Org mode.
Typical binding provided by the mode:

```
C-c s  → Insert latest screenshot
```

The mode is active only in Org buffers.

## Customization

All options are available via:

```
M-x customize-group RET win-screenshot
```

Screenshot Source Directory

```
(setq win-screenshot-source-dir
      "C:/Users/YourUser/OneDrive/Pictures/Screenshots")
```

This directory must match where Windows saves screenshots on your system.


## Typical Workflow
1. Capture a screenshot using Win + Shift + S
2. Switch to Emacs
3. Press C-c s
4. Continue writing

Screenshots remain project-local, versionable, and reproducible.


