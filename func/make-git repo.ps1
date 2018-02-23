 git config --global user.email "al@amarlanda.com"
  git config --global user.name "amarlanda"

echo "# AzureBH" >> README.md
git init
git add .
git commit -m "first commit"
git remote add origin https://github.com/Amarlanda/AzureBH.git
git push -u origin master