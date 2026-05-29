+++
title = "{{ replace .File.ContentBaseName "-" " " | title }}"
date = "{{ .Date }}"
draft = true
summary = ""

# Add project artifacts with exactly one of url or resource.
# Local resources live beside this index.md file in the update leaf bundle.
#
# [[artifacts]]
# label = "Prototype"
# url = "https://project.test/prototype"
# description = "Optional short context for the link."
# rel = "noopener"
#
# [[artifacts]]
# label = "Brief"
# resource = "brief.pdf"
# description = "Optional short context for the file."
+++

<!-- Add normal Markdown body content here for longer update notes. -->
