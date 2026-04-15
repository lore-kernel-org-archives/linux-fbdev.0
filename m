Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012AC3EAC83;
	Wed, 15 Apr 2026 16:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776271851; cv=none; b=n5ofQQ0NnwYa3L+x9hznVh8ksrqYEuLOCU4oQxmJMYEUE2eTwAbCCQ0ycVUf8rU5z7f8DWbpphnNeyZVYEJ0nHUwaZ6nPvo2ThIypitU+hmWpPxKqD3Wt+IE8Y4yhrqJKtc35MaQwSneLKFfE23+eVx+cMD8EJyAA8RlrrfKOfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776271851; c=relaxed/simple;
	bh=ufj3pjCxkiTm9y+Q+t1SNZaKvYGfCat5TvKexYGBrc4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=MW924GWYRVG1DEPJM9gxbLM1YPscQQWKLeqBKy4Gx9bJtmGYDaU1jG6M+fDIRepwUovqe1fEneVb6LEsViR27Htnt7/56kJPsOB9rVbtex3ClWHtBFCknh9OErzVrfIoi+lk10KL4ZWhhctDrQQwo8D3SK7H+YOZd+YmS7kLrLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rJTW+xL/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rJTW+xL/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB486C2BCB5;
	Wed, 15 Apr 2026 16:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776271850;
	bh=ufj3pjCxkiTm9y+Q+t1SNZaKvYGfCat5TvKexYGBrc4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=rJTW+xL/eAliDDAhR63bOQkshj8BUfcMogDt0F2BQNyVjtMcKM73E6xOupcBERONq
	 pM63/eyq+L0bZRQBuWiVPNdRpMHxYW9WAh+SVYgw9u4ljhDl0qAGp6Ui/4cx3ePgA0
	 XfY3wNfrK/gCy9kuHUw18UwwJ2+dfchRCYbDzWDzEroByrDfjs01UHO1fMn6M7tzNS
	 lml1U2bEazxS36/+sFAiYNRTVXx0DFVEGq0LZhQZnqPECEsrid56Z2EF/okegUjcWX
	 faShbn+Gea2mdgW9yKcC0LKJRmhYoLWA8Uku06raTpVR52XnBewlECcrkjY5mM0gWk
	 SFeQHjWq8sb3A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9CFBC380A964;
	Wed, 15 Apr 2026 16:50:21 +0000 (UTC)
Subject: Re: [GIT PULL] fbdev fixes and updates for v7.1-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <ad5m1zGyRSJFwoC8@carbonx1>
References: <ad5m1zGyRSJFwoC8@carbonx1>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ad5m1zGyRSJFwoC8@carbonx1>
X-PR-Tracked-Remote: http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-7.1-rc1
X-PR-Tracked-Commit-Id: a31e4518bec70333a0a98f2946a12b53b45fe5b9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: afac4c66d1aa6396ce44d94fe895d7b61e085fd4
Message-Id: <177627182034.2328436.49830147803001383.pr-tracker-bot@kernel.org>
Date: Wed, 15 Apr 2026 16:50:20 +0000
To: Helge Deller <deller@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 14 Apr 2026 18:09:59 +0200:

> http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-7.1-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/afac4c66d1aa6396ce44d94fe895d7b61e085fd4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
