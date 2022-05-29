git remote rm heroku

heroku create

heroku rename stock-trading-backend

git subtree push --prefix stock-trading-backend heroku main
