Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31D919F11E;
	Sun,  7 Dec 2025 00:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765067403; cv=none; b=YHvki8Nec+K7nH85NRW3IbTZ3YoOEDN6Xhm2mRcgjuRrrXEr4vAhpLkCzwxNAUcd1E7n1z9/4CgvlCUzse32Ii7dc1cdflmhkA/Tx6G3FAUCURfOK0hRiXM6lmahbhAQL3zXGAi3MWIclmSortG8DrZOL+w/a+Y3rOz+heupnt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765067403; c=relaxed/simple;
	bh=/wIqNsbddTbTJvTxffaNLl/GC641Zm08IRIfWEIrL7c=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Tl/8STkOuk5WQyArL75I5h+WBoNJikf9nryAjnxvRkCIfmAHpphnc2F/yfuyLArRZiFSehrLtfCxXTQi2DkEz8VEDpDkzVqu6avAQAjRlOvbvxS1kxxj6aMQ7BbALQk8L5yOBeodLGsAZ1l7Y5W35L6Qerg+wIiaRYbjk0mDH3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jXOhY9PC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jXOhY9PC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73518C4CEF5;
	Sun,  7 Dec 2025 00:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765067403;
	bh=/wIqNsbddTbTJvTxffaNLl/GC641Zm08IRIfWEIrL7c=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=jXOhY9PC7YbnwaWXKpQovKfPovfYjj2cCLZ31sdvLaKxpRN44D8K+PA1T+czRIlq6
	 2dWnc9M8BNYM+HUKkF/zs0rsDPTWKBmbJxabOITzJrBY64tvM9A/eusEQvcZC3wOa4
	 XfiR8KT5I4x8pXTao5ysH3mGLI9VN9BxUbCaBhmuVEdXfDjWMWIq06tadLoJtZwvbZ
	 T/Xro2ak/wozAPw5lu9QL+SWA0lsfCnPbzG4ehZ+WULVm2PQmJHNcUZctzIDFjmEeU
	 4eBUCWotsxBb+6rMkzGvq7Ob9D0TTAofsOXJZkpwM1POLn55F3xvyFNLHTwGPs7QuD
	 GSl8MTKXszEjg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 78B9C3808200;
	Sun,  7 Dec 2025 00:27:01 +0000 (UTC)
Subject: Re: [GIT PULL] fbdev fixes for v6.19-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <aTSVGN47DAA1AvGH@carbonx1>
References: <aTSVGN47DAA1AvGH@carbonx1>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aTSVGN47DAA1AvGH@carbonx1>
X-PR-Tracked-Remote: http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-6.19-rc1
X-PR-Tracked-Commit-Id: 164312662ae9764b83b84d97afb25c42eb2be473
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0d1d44032f7b8b9edb14e82315fdf504740940c1
Message-Id: <176506721993.2244723.5295017210633049557.pr-tracker-bot@kernel.org>
Date: Sun, 07 Dec 2025 00:26:59 +0000
To: Helge Deller <deller@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 6 Dec 2025 21:42:00 +0100:

> http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-6.19-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0d1d44032f7b8b9edb14e82315fdf504740940c1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
