_svneligible () {
  A=( branches releases tags path upstream branch switch diff show merge reintegrate help )
  compadd -a A
}

compdef _svneligible svneligible