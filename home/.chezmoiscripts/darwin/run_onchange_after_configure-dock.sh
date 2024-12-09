#!/bin/bash

set -eufo pipefail

trap 'killall Dock' EXIT

declare -a remove_labels=(
	Launchpad
	Messages
	Mail
	Maps
	Photos
	FaceTime
	Calendar
	Contacts
	Reminders
	Freeform
	TV
	Music
	Keynote
	Numbers
	Pages
	"App Store"
)

# Keep Safari, Notes

for label in "${remove_labels[@]}"; do
	dockutil --no-restart --remove "${label}" || true
done
