function ciam-versions-old -d "Print all versions deployed of a ciam microservice"

  # update deployment-config
  pushd ~/code/deployment-config
  git pull --quiet
  popd

  # find apps and fuzzy find
  set app (jq -r 'keys[]' ~/code/deployment-config/configuration/*.json | sort | uniq | grep -v CommonConfig | fzf)

  # find running versions
  for file in (find ~/code/deployment-config/configuration -name '*.json')
    set env (basename $file | cut -d. -f1)
    set commit (jq -r ".[\"$app\"].ImageVersion" $file)

    # printf "$env\n"
    printf "$app: $env: $commit"

    # find which branch version comes from
    # todo: this check doesn't work
    # if test -n "$commit"
    #   pushd ~/code/$app
    #   git fetch --all
    #   set branch (git branch -a --contains $commit | grep -v HEAD | grep 'origin' | sed 's/.*remotes.origin.//')
    #   popd
    #
    #   printf " ($branch)\n"
    # end

    pushd ~/code/$app
    set migrationStatus "not migrated"
    set migrated (git show $commit:Jenkinsfile | grep -q 'gitlab-migration' && set migrationStatus "migrated")
    popd

    printf ":$migrationStatus\n"
  end | grep -v null | sort -k 3,2 | column -t -s\:
end
