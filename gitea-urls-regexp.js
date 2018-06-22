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
|	admin(?
	:
	|	/users
	|	/users/new
	|	/orgs
	|	/org/create
	|	/repos
	|	/auths
	|	/auths/new
	|	/config
	|	/notices
	)
|	api/swagger
|	issues
|	pulls
|	explore/.*
|	[^/]+
|	[^/]+?:\?.*
|	user/settings
|	user/settings/.*
|	repo/.*
|	org(?
	:
	|	/.*/.*
	)
|	notifications
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
	(?
	:
	|	\?.*
	)(?
	:
	|	#.*)

)
