# Notion Export Conversion Tool

This tool takes a notion markdown export and converts the markdown into docx files for import into confluence.

## Requirements
1. A recent version of Ruby(tested with 2.6.3p62, but will likely work on most ruby versions)
Pandoc installed locally(https://pandoc.org/installing.html)

1. Bundler installed locally

## Running the tool

1.  Export the notion space as Markdown & CSV including subpages

1.  Run `bundle i`

1.  execute the script.  `./notion_converter.rb {notion_export_dir} {output_dir}`

1.  (optional) Import outputted docx files into confluence.  This is manual, and confluence sucks at structuring imported docs.  But it's the whole reason for the effort.

## Known deficiencies

1. File names are wonky.  `.md.docx`, and no trimming of the export hash.  Acceptable because easy to clip during import into confluence

1. Doesn't automatically import into confluence.