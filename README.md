# LivingWords
LivingWords app

## Dev setup

I recommend installing RVM to manage ruby versions if you haven't already

    gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
    \curl -sSL https://get.rvm.io | bash -s stable --ruby

Install required gems

    bundle install

Install required pods

    pod install

Always open the workspace, `LivingWords.xcworkspace`, and not the xcodeproj. Requires Xcode 6.3+
