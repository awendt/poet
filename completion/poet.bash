_poet()
{
    local cur prev opts base
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"

    #
    #  The basic commands we'll complete.
    #
    commands="bootstrap edit help ls completeme"

    #
    #  Complete the arguments to some of the basic commands.
    #
    case "${prev}" in
	edit)
	    local files=$(poet ls)
	    COMPREPLY=( $(compgen -W "${files}" -- ${cur}) )
            return 0
            ;;
	ls)
	    local flags="-t --tree"
	    COMPREPLY=( $(compgen -W "${flags}" -- ${cur}) )
            return 0
            ;;
        *)
        ;;
    esac

   COMPREPLY=($(compgen -W "${commands}" -- ${cur}))
   return 0
}
complete -F _poet poet
