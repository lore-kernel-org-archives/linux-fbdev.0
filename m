Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDF418E24;
	Fri, 12 Jan 2024 23:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ebIg9RVY"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D9C90C433C7;
	Fri, 12 Jan 2024 23:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705101926;
	bh=K1MidH5sVBEyKNuPJH4olazqJE8kNJXKjQSNh6ZQ3dk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ebIg9RVYTpaZRq16zZ3v40lHfqgy4W9+ONkNeRhH0ZAv/opFgqF72oDxQDyk8fPMq
	 TnGAOtC6xqFzlI7omvgUyEb8BgUYlJ5LKaqlXSy/g84SQyUNl7VRKeB4g4AMvR2b2c
	 caERKRd6Fi786F0Fd6Gnq2dLYNK2Zt1Z18frQ3A/0tDP+zu5c50/SCn8AfEMBfoyTr
	 R8NGIo7qrcJdZy7QI2udRER3BeGiVMMHXIG/b0tEHRajtjGm5H75QLIOlyssFlCWu5
	 Ii+QOWh9fmKrSPBmMmHpiIxU+xVGHubdOQ+W34pw7jgTuAyXZNxbQ6xWFJc3wA49e2
	 JlV8at917Q5vQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C15E0D8C96D;
	Fri, 12 Jan 2024 23:25:26 +0000 (UTC)
Subject: Re: [GIT PULL] fbdev fixes and updates for v6.8-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZaFfWY-bB_b9dGrO@carbonx1>
References: <ZaFfWY-bB_b9dGrO@carbonx1>
X-PR-Tracked-List-Id: <linux-fbdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZaFfWY-bB_b9dGrO@carbonx1>
X-PR-Tracked-Remote: http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-6.8-rc1
X-PR-Tracked-Commit-Id: 689237ab37c59b9909bc9371d7fece3081683fba
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d97a78423c33f68ca6543de510a409167baed6f5
Message-Id: <170510192678.16457.5931859299348612306.pr-tracker-bot@kernel.org>
Date: Fri, 12 Jan 2024 23:25:26 +0000
To: Helge Deller <deller@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Dave Airlie <airlied@redhat.com>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 12 Jan 2024 16:48:41 +0100:

> http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-6.8-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d97a78423c33f68ca6543de510a409167baed6f5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
