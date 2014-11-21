Homebrew Facebook
=================

This is a homebrew tap for Facebook specific formulae.

Setup
-----

This is unfortunately complicated.

1. [Join the GitHub team][team] associated with this repository. If you're
reading this docuyment, you've probably already done so.

2. If you haven't yet set up GitHub to work with your laptop, you'll need to
[add your laptop's SSH key][ssh] to your GitHub account.

3. Since Homebrew currently only supports cloning new taps via `https`, you'll
need to make a Personal Access Token for yourself. Visit the ["Applications"
section of your GitHub settings][token], click "Generate a new token", enter
some name such as `homebrew-clowny-2014-10-14`, ensure the `repo` scope is
checked (others don't matter), and click "Generate". Do not close the page.

4. Run `brew tap facebook/homebrew-tap`. When asked for a username, enter your
GitHub username; when asked for a password, copy-paste the token from before.
It should clone the tap and print a message like "Tapped 3 formulae". It should
also print a message about how to use `git remote set-url` to avoid entering
your access token each time. Do what it says. After that, you can delete the
access token from your GitHub account, if you want.

This could be simpler if an option like `brew tap --ssh` existed. Hint, hint.

Installing something
--------------------

    brew install fbthrift-compiler
    thrift1 --version

References
----------
`brew help`, `man brew`, or the Homebrew [wiki][].

[team]: https://our.intern.facebook.com/intern/opensource/team/?tid=1079344
[ssh]: https://github.com/settings/ssh
[token]: https://github.com/settings/applications#personal-access-tokens
[wiki]:http://wiki.github.com/mxcl/homebrew

Contact
-------

As of 2014-10-14, these formulae are approximately maintained by
`jsailor`.

