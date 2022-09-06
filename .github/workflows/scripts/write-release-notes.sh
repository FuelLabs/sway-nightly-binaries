touch body.md
touch body.tmp
git log --after="${2} 00:00" --before="${3} 00:00" --oneline >> body.tmp
echo "Generating release notes from repo: ${1}"

while read -r line; do
	  commit=$(echo "$line" | cut -d ' ' -f1)
	  pr=$(echo "$line" | cut -d '#' -f2 | rev | cut -c2- | rev)
	  description=$(echo "$line" | cut -d ' ' -f2- | rev | cut -d ' ' -f2- | rev)

	  commit_url="https://github.com/FuelLabs/${1}/commit/${commit}"
	  pr_url="https://github.com/FuelLabs/${1}/pull/${pr}"

	  echo "- [${commit}](${commit_url}) ${description} [#${pr}](${pr_url})" >> body.md
done <body.tmp

echo "" >> body.md
rm body.tmp
