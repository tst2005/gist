https://
(?
:	git
|	gitea
)
\.[^/.]+\.[^./]+/
(?
:	gitea
|	[a-z]+
)
/
(?
:	
|	/
|	issues
|	pulls
|	explore/.*
|	[^/]+
|	[^/]+?:\?.*
|	user/settings
|	user/settings/.*
|	repo/.*
|	notifications
|	notifications\?.*
|	[^/]+/[^/]+
	(?
	:	
	|	/
		(?
		:	src/(?:	branch
			|	commit
			)
		|	_edit
		|	wiki
		|	issues
		|	milestones
		|	labels
		|	settings
		|	commit
		)
		(?
		:
		|	/.*
		)
	)
)
