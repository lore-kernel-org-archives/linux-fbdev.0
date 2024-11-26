Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDA5440C;
	Tue, 26 Nov 2024 01:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732585203; cv=none; b=e/lI1ggthyrKGTc33ZMVcZV/bFCH1tCnp0ZnAE8Qqfi6V7NKDWFt4siSfzkTFHxtfbewx9bB/pGKFhTJ2JiK7W0wmnYEGO4AGESBFS3LeR0EslhaoqQH3hJGDJyjOU4SnxG0bPVXtbYv+dqQUID45oaY5aHCBreigMHky7tOr9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732585203; c=relaxed/simple;
	bh=cnrA5iZFmRC8kQduUCs0XN5cQnzWr+UiV47ifV/i8OY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=WYOFhWsgSNq6PQ3peY3HZgQ2IHqIwEs4bmDzB8vSueueM+HLxh0HMoP8HA99STp2W740eVtfaOjLTS63sOvozJOPjpD3dPkDcFKs/Ap8qcU1IvJrIA9Gz9h3PWBsufceY7AfGQCcT95cWEUgXW6RniM5MF4Y7TsdWof78F7xOA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CHJmywzJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CHJmywzJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F412DC4CECE;
	Tue, 26 Nov 2024 01:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732585203;
	bh=cnrA5iZFmRC8kQduUCs0XN5cQnzWr+UiV47ifV/i8OY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=CHJmywzJu9zUwBwB9HOFBmO6tMJHutW/stzR55SFydMm1HFGBmTZ+M1b8vPRpPGM/
	 1rWVIe4ptO7yJGJQ7etOdkU1R8niHLEM/NGLWU9uRf8vY1/MPwMR6Vuzh75o9c5VzD
	 Aq42hLkO+coW0yOCwKVBTMmTcELXTq9pXt41W+M8S7RqloCtUd718PDwLvTRPyR+RN
	 4bs5w0P08ZFOIH+GU+QwN47nXPd0/UqQcn/ROYaB2M2q529MzigktDSNO5n7nPoDNJ
	 8yhz/GDuJKXHaLmvC5tZQwG/Tg7re4GrC8flVEVFDLkd/9A+VruTkCqOQj/c/GrIia
	 Yc+ikRH9ZeVLg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB5263809A00;
	Tue, 26 Nov 2024 01:40:16 +0000 (UTC)
Subject: Re: [GIT PULL] fbdev fixes and cleanups for v6.13-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z0NkkihDqEwi3k9Y@carbonx1>
References: <Z0NkkihDqEwi3k9Y@carbonx1>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <Z0NkkihDqEwi3k9Y@carbonx1>
X-PR-Tracked-Remote: http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-6.13-rc1
X-PR-Tracked-Commit-Id: 8d7493133bfd89322349be3daaf39a256e4354ac
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4e07155dd58cab024813e97dc384d48f34e3d16e
Message-Id: <173258521564.4103683.3291676573483686961.pr-tracker-bot@kernel.org>
Date: Tue, 26 Nov 2024 01:40:15 +0000
To: Helge Deller <deller@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 24 Nov 2024 18:38:26 +0100:

> http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-6.13-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4e07155dd58cab024813e97dc384d48f34e3d16e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
