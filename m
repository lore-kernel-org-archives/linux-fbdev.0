Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622F230DEBD;
	Fri, 31 Oct 2025 02:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761879138; cv=none; b=Kb36mWaodJwMf1EO3ZlVx/g1tpJchAorLDOqifIzjCkt/2cBcUqHmR5RjX4t5WzuxIH8khl4AOI+9t4RbuYKc1OsyRF7uvuhcQ7EirV1DjuIkggU1yGgH4eBsSbCm0Ay0fCfAuTtwM3SufL72451gjUgGucncvX/jW48s2oylU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761879138; c=relaxed/simple;
	bh=Im42M7xRtyqFPfkNVVAoSWnaaqGHk49ypPzrZStjFNg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=We8jiEg5kbAhqE067wL3AyJ9kKH5oBwDr8eD9FaLXkilp0m0MdFb3qs7/oldr9yqSUEfKEOsNxk60VwaY8jn58kdEotvwyz3nhhmnQ05IXoZKUtp0afC5yLd6W/wPhc5hjxlpjSnrieOP/6xK/dT8x00XVp/Ao8k5/0ykrmBups=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KNCh1po7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KNCh1po7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 477FAC4CEF1;
	Fri, 31 Oct 2025 02:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761879138;
	bh=Im42M7xRtyqFPfkNVVAoSWnaaqGHk49ypPzrZStjFNg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=KNCh1po7Yo7CtDxuVcpeW2kaFDTX14DlKRQd3vW4hAehBd4srDwPAx9011GxFBrlK
	 f4tZ9uCDC3iG+nepjolCrGGQ/cuVhoDt+XCrWmDrjoRbUNzQseUeuZx5L84H5DWUcM
	 RMOxHJENL8KOUuNs36a3BusOQdP9xh9HBaIwhnJ6Oi7vG0ZkFjEwVidTcTsxc+4WaK
	 Aymzq2TvVRpd//db029Bl2MTyi60hnWHlH49IdUE9b4fUhbSnZC/vcK3vz7ZAmPE6g
	 KGXy0ocPouiyqLJviTY1UE0f7CclIBkanGqPTSxGLzC+IcIXWt823K7deE7Lfyu1hT
	 Fu5FPr9IJMfyg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ECB633A78A76;
	Fri, 31 Oct 2025 02:51:55 +0000 (UTC)
Subject: Re: [GIT PULL] fbdev fixes for v6.18-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <aQOOz7Q27BbUo-_4@carbonx1>
References: <aQOOz7Q27BbUo-_4@carbonx1>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aQOOz7Q27BbUo-_4@carbonx1>
X-PR-Tracked-Remote: http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-6.18-rc4
X-PR-Tracked-Commit-Id: 7073c7fc8d8ba47194e5fc58fcafc0efe7586e9b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a4819ac1913e78e41c8406df481a661d9469c350
Message-Id: <176187911454.4119220.5294540368410183025.pr-tracker-bot@kernel.org>
Date: Fri, 31 Oct 2025 02:51:54 +0000
To: Helge Deller <deller@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 30 Oct 2025 17:14:07 +0100:

> http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-6.18-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a4819ac1913e78e41c8406df481a661d9469c350

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
