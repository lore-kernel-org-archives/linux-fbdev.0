Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BED1CFED4;
	Fri, 11 Oct 2024 23:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728689099; cv=none; b=O4C+0oYEbq1Se/x9Klw0vo9oElw7bJmxEpcx9/ndAvpgTpBmZ8rR++ZLa9oo2r/QgN7t0a6Tq5QQ9eguE0ERL8pJxdqW7Xc1A4f7UJsfo17q7Gwj+R3sUnzhlFlO4WAfilZEdMnm3aHsNDbwF1E6UYVyHz7pR8vsz4EwGdCtwp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728689099; c=relaxed/simple;
	bh=EDvlZqMBPpTZRu6/GWfrIW93H8umTl5FQq5+12AgqkA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=qexG/3oNNSxQZfkxNGojIZMgX4BkkzQmH563y/4ar9HnaqnDNjWtzSdfrlwa7vBo6WZfYTnJvb6Q5u/Keq0A41EKwuMVXXLHAz8zIUnQinWfcJEctmNw2R58+WrdzvghWU7OXxQf77cRhreC9unG2dFWTx39alGRxwXfrwjGf68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hu3EaJvN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hu3EaJvN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D168DC4CEC3;
	Fri, 11 Oct 2024 23:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728689098;
	bh=EDvlZqMBPpTZRu6/GWfrIW93H8umTl5FQq5+12AgqkA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=hu3EaJvNmdNhVAECGdlyy4bptgn3RY0AbH9+cSkAbtq6K1fdW26/r59utjIjApC+6
	 MjX1ec5UrSOpqHazjdHUcoJhPnzOxG/YOzVe9djmDSkTj0YbazkAmyuFKjMxKbqVTA
	 1VI5gWMNt0SwDr2pSiTVKNxviePomDijHonSSQc0+iFyhnwcv4FnnaiqOXkmNzV4mZ
	 VDawtiJ0UT0mWr5RRvGpq+JlDKwKvsgafw3fPmgaoPwAYCyVWS4eMLj2eIKBZ1N+5+
	 5kpi0lDf9kp2upguDXQhjLLZaAc4j6DEsb5dYEuSXabcODUlXha3nH05pDWiXGQjDT
	 m8nM5tKYp682A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE07A38363CB;
	Fri, 11 Oct 2024 23:25:04 +0000 (UTC)
Subject: Re: [GIT PULL] fbdev platform_driver::remove() migration for v6.12-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZwmPlIK9-O-396Sh@carbonx1>
References: <ZwmPlIK9-O-396Sh@carbonx1>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZwmPlIK9-O-396Sh@carbonx1>
X-PR-Tracked-Remote: http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-6.12-rc3
X-PR-Tracked-Commit-Id: 01ecc142ef7c8c5081a39be81c1d8ab7c10dd7b8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9066258d0a533530c2508f784e85c53b44f5d9e4
Message-Id: <172868910338.3026331.13025842781495565900.pr-tracker-bot@kernel.org>
Date: Fri, 11 Oct 2024 23:25:03 +0000
To: Helge Deller <deller@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Uwe =?iso-8859-15?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 11 Oct 2024 22:50:28 +0200:

> http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-6.12-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9066258d0a533530c2508f784e85c53b44f5d9e4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
