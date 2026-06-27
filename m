Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC3C37F015;
	Sat, 27 Jun 2026 21:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782594803; cv=none; b=TI3PSjkZauUQOIiRSQFEU9LXWVPpKb7cFOr1Ez1/y+c6sLervzX6C/5ul9sGxzvUAL7EVBZwXV0rHPu6sjvVZL9jcg0oAhiWYQY7SzWMrm0388ogal/prah7YIHci/X2ScaCoN7Ns+Hz97OCHleWTm6meUCYX0uOds6d4wzH1dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782594803; c=relaxed/simple;
	bh=U7C5GwWwe/Is1uzUc2Yy5jx+U+MtE9zGO0uyhuXhnHY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=jt3mXC/XKgV0to1VzjPMF/X2W19Jr3tv+E6IloUDfjBrWf+PyXPKHmfLEV+O0l0HMRQvSMSKCTHGLaNnUt8nBPsYyzG/oEP9qkj2IE+zHPnWSau0rfnt8jTq8wAfwkshXOGwsw9TPXjK1SictPfBIY0DYqQYke7pbJWqugWgQp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m8TT+rG3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m8TT+rG3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 828431F000E9;
	Sat, 27 Jun 2026 21:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782594802;
	bh=7IIarUe+baKuHHQbpyHLNcw1qaxN6lQqvLcXWyFWHNg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=m8TT+rG3IZWdMjJVbbCAX1lNwl/HNbxDubbGoG2cwBROFV+X9uHbT3ktfM6AdBNeC
	 qWbY6iAOkhxGkMkqEOKtzFuO+hNAWMT+CfaPS/JtEm+vdZ9nbfF3Px8kqPEZreGEqC
	 j3rUuE03cthvUJhUN3mbyI5BVTEBknk8Zo/9m1nxxn6fvvkr+QrTCjdkn0pCjUxj2A
	 582sVT8UwtLquwteFc0AKr8YfEb5Mit/KuNp/6MQFrc3LXujOnn9VPlu86y6j4M3v4
	 BQ4lbB4/1UzGCgekTJ1OF5sbErACEQdkbwwlRiq1H86nmUBPRhVI2fwpr5M+u6Dbp/
	 BehIEOLbYn8MQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A9F3938452;
	Sat, 27 Jun 2026 21:13:09 +0000 (UTC)
Subject: Re: [GIT PULL] additional fbdev fixes and updates for v7.2-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <akANXx5Fr4vBRhwg@carbonx1>
References: <akANXx5Fr4vBRhwg@carbonx1>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <akANXx5Fr4vBRhwg@carbonx1>
X-PR-Tracked-Remote: http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-7.2-rc1-2
X-PR-Tracked-Commit-Id: 7f08fc10fa3d3366dc3af723970bd03d7d6d10e3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f21df873208d41ef816b15024d6447813b97ab5e
Message-Id: <178259478823.1431938.3522644980455972478.pr-tracker-bot@kernel.org>
Date: Sat, 27 Jun 2026 21:13:08 +0000
To: Helge Deller <deller@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 27 Jun 2026 19:50:23 +0200:

> http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-7.2-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f21df873208d41ef816b15024d6447813b97ab5e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
