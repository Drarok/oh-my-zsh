function svn_prompt_info {
    if [ $(in_svn) ]; then
        echo "$ZSH_PROMPT_BASE_COLOR$ZSH_THEME_SVN_PROMPT_PREFIX\
$ZSH_THEME_REPO_NAME_COLOR$(svn_get_branch_name):$(svn_get_rev_nr)$ZSH_PROMPT_BASE_COLOR$ZSH_THEME_SVN_PROMPT_SUFFIX$ZSH_PROMPT_BASE_COLOR$(svn_dirty)$ZSH_PROMPT_BASE_COLOR"
    fi
}


function in_svn() {
    info=$(svn info 2> /dev/null) || return
    if [ $info ]; then
        echo 1
    fi
}

function svn_get_branch_name {
    if [ $(in_svn) ]; then
      svn info | grep '^URL:' | egrep -o '(tags|branches|releases)/.+|trunk' | read SVN_URL
      echo $SVN_URL
    fi
}

function svn_get_rev_nr {
    if [ $(in_svn) ]; then
        svn info 2> /dev/null | sed -n s/Revision:\ //p
    fi
}

function svn_dirty_choose {
    if [ $(in_svn) ]; then
        svn status 2> /dev/null | grep -Eq '^\s*[ACDIM!?L]'
        if [ $pipestatus[-1] -ne 0 ]; then
            echo $1
        else
            echo $2
        fi
    fi
}

function svn_dirty {
    svn_dirty_choose $ZSH_THEME_SVN_PROMPT_DIRTY $ZSH_THEME_SVN_PROMPT_CLEAN
}