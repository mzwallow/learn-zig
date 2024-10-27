# Imports
---

The built-in function `@import` takes in a file, and gives you a struct type based on that file. All declarations labelled as pub (for public) will end up in this struct type, ready for use.

`@import("std")` is a special case in the compiler, and gives you access to the standard library. Other `@imports` will take in a file path, or a package name (more on packages in a later chapter).

We will explore more of the standard library in later chapters.

