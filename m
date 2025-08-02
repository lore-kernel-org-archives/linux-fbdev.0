Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F110192B90;
	Sat,  2 Aug 2025 17:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754154143; cv=none; b=trzpKjEUHnqg+PM+tOGnpbWtVlem7A2AsiPzO5Ab6dF7K7ETNxn5YW61a7ZxHcNYbGApfiS9MIGbb6a4waSPbfyzPcOttsiSqCDW2LRDTFwjMkopiF9sZ+sa8JhGk9BLV3FYs9J2jm4eKICwEGZGTXVsg73KVJRZY0RHqahRw+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754154143; c=relaxed/simple;
	bh=AzapRyBiWriYrOq122HstKBoVFLICyZpLuwOIPeKcbY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=bpaehG0Ggk0GH90U+A/Qydpp0ANwCuvBxHwHBF63CEsQFTP4Exft3Xt0vieBKyddwkIq9tf4hkwW+SzxDiSguLGVVaKG/R9RUDBx0Z0a4eEPtMPyCzDOhY6y52mOfkOwWLkuunQogeLN4Ysqo36nJJc38IHEsQ1paZOhs/vUadE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eAKRrtqZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eAKRrtqZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0044DC4CEEF;
	Sat,  2 Aug 2025 17:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754154143;
	bh=AzapRyBiWriYrOq122HstKBoVFLICyZpLuwOIPeKcbY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=eAKRrtqZ8kzbmYub1dcJZOU9FTaDBADv8/YP4wvqBIVfdGZkeB6Tkh8vk1ua1kcuD
	 +A/9nPS9PYuMiTHdYPAc5Hq0no8FzZbFj1lVAs/s8ZRzIRkKQMWz6R1BNBMWCmEMYI
	 rYDSozNSWHbr3MZkfJyRPpQJI8GlHe9VR/p4kmxX24nna9MSQzS82qWAzwuCfxlxdE
	 gWGHqsleleuca8MvcClvIwy6U/TDS356mRDWqIMXdWXE196lQJe9h9T0SO+71Zlycy
	 GJdruiRfkABxUK0sGculoIOAobKvAYeSftoorLyZqPQVliiCZdW4X+qYIYvPQ+saHI
	 FAaoHt3leIfYQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F4B383BF57;
	Sat,  2 Aug 2025 17:02:39 +0000 (UTC)
Subject: Re: [GIT PULL] fbdev fixes and updates for v6.17-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <aI3wuBNWPyKhHbnC@p100>
References: <aI3wuBNWPyKhHbnC@p100>
X-PR-Tracked-List-Id: <linux-fbdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <aI3wuBNWPyKhHbnC@p100>
X-PR-Tracked-Remote: http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-6.17-rc1
X-PR-Tracked-Commit-Id: 81b96e4aef9592493873507eec52eca68f0721ac
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eacf91b0c78a7113844830ed65ebf543eb9052c5
Message-Id: <175415415789.201848.14590140157219989268.pr-tracker-bot@kernel.org>
Date: Sat, 02 Aug 2025 17:02:37 +0000
To: Helge Deller <deller@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 2 Aug 2025 13:04:24 +0200:

> http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-6.17-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eacf91b0c78a7113844830ed65ebf543eb9052c5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
