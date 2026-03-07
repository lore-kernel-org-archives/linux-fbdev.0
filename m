Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17E02D9499;
	Sat,  7 Mar 2026 21:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772918643; cv=none; b=atTLYHKHfL2EhhZqEpLzfNLqXdj62aRf/Puuvy9KPuQRj2xprmhkRrLHrvI3XuHd04Hkg+mCaK6ae06ALshbSYvfI5FZFjJKkhOq8kAF+K9stLVVnPp971LL3j0fXL0rK5L6vwPZTkiHEQzkgTC/qrHv+tT4avCT7vD7Il9V9JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772918643; c=relaxed/simple;
	bh=fVWek9dUrL/Ln52UfkGDHG5nVzdDqNEpD8OAzGaTD9o=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=JSYNvD3uedhfZAt1KJbup++LtMcnqrEfjovM4Dsao0WYRQnKHCdXqioCSgZJfwQtuJuMB2UNy5hws2ImiALe0VnH7JTfxfaDwDig3cjfliy27n8YlEG6YYmB1tMybU+i+91UwEg4K0ElkTexQ0C5vX7RwNXlmZi9+rCDEJJo75c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ovh9Tano; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ovh9Tano"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CDC2C19422;
	Sat,  7 Mar 2026 21:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772918643;
	bh=fVWek9dUrL/Ln52UfkGDHG5nVzdDqNEpD8OAzGaTD9o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ovh9Tano4PoNs1fZCg7/59OqBdDv98QCQfzo/sZWvK5aEHlQJnGNWwD89KbdSYVVW
	 cgi7HxeB9PljR5ilEeawLtFajiRaGxP0Efz6RumEGMq1Y/X24UJbH2t8zZZ160mnLx
	 M4cKmWKHbVpu1UiOR17WYxsS9AoVaKgGtd+T6NxrUHLQTSbdDIAwFg2NHNLB2jJpgf
	 M2UyJRoHckAeQigB7mDyOZrrzAnqHzpvM+0DR59Y8uGDYV+mlRMyVKQDZOvnDRMf3J
	 6BRsPJix8sJUOEIZp6mjcZ3ohv/ZCbYQng51H9aEMvuIdKD4lUIhZ6bJqQg9ZJCHDu
	 7p47cLT+BLFyA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0309F3808200;
	Sat,  7 Mar 2026 21:24:03 +0000 (UTC)
Subject: Re: [GIT PULL] fbdev fix for v7.0-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <aayOLznDX70UUs6T@carbonx1>
References: <aayOLznDX70UUs6T@carbonx1>
X-PR-Tracked-List-Id: <linux-fbdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <aayOLznDX70UUs6T@carbonx1>
X-PR-Tracked-Remote: http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-7.0-rc3
X-PR-Tracked-Commit-Id: e31a374a99f5026df6ebff2a1c49492276e776fd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fb07430e6f98ccff61f6f1a06d01d7f12e29c6d3
Message-Id: <177291864170.323982.13715608528142906828.pr-tracker-bot@kernel.org>
Date: Sat, 07 Mar 2026 21:24:01 +0000
To: Helge Deller <deller@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Uwe =?iso-8859-15?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 7 Mar 2026 21:44:31 +0100:

> http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-7.0-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fb07430e6f98ccff61f6f1a06d01d7f12e29c6d3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
