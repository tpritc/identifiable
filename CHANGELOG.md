# Changelog

All notable changes to this project will be documented in this file.

## Unreleased

*Nothing yet*

## 1.0.0 - Released June 22, 2025

### Added
- **Configuration system**: Use `Identifiable.configure` to set the `overwrite_to_key` and `overwrite_to_param` options that control whether Identifiable overrides Rails' `to_key` and `to_param` model methods. Both options default to `true` to maintain backward compatibility.
- Support for Ruby version 3.2, 3.3, and 3.4.

### Changed
- This is now considered a stable 1.0 release.

### Removed
- Support for Ruby 2.7, 3.0, and 3.1. The new minimum supported Ruby version is 3.2.
- Support for Rails versions below 7.0. The new minimum supported Rails version is 7.0.

### Fixed
- Configuration options resolve compatibility issues with other gems like Devise (#7).

## 0.2.0 - Released October 16, 2022

### Added
- Support for Ruby versions 3.0 and 3.1.
- Models that include identifiable will now use Identifiable's public ID for the `#to_key` and `#to_param` methods, meaning that you can now use Rails helpers like `dom_id(@order)` and `order_path(@order)`, and they'll use public IDs instead of the database primary key.

### Removed
- Support for Ruby 2.5 and 2.6. The new minimum supported Ruby version is 2.7.

### Fixed
- A migration will no longer fail if the model has identifiable but the table doesn't exist yet.

## 0.1.0 - Released November 15, 2020

This is the early, initial release of Identifiable.