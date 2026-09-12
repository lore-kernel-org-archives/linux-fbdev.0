Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD93400DF6;
	Sat, 12 Sep 2026 15:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789226248; cv=none; b=ppPFNX+Q/TZqwsaRVT2acq/fxzW2Nv1CTn7iwEHreSmHWgVSjHKuGzorSat4z/oAqzfNE4ePLNnXjqVMytbAvYVIXzkEtD2zn5k546KmLxD3n2nP4bOIJyTRd5ebuy25VkFi226nmgFrsiaD0RAe3LekHW3e1yY/lErAWtahpRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789226248; c=relaxed/simple;
	bh=pYetSNUKX7hfX/6t5uE3LMmym//KDaNB1zsQB6NxHNY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=sPiKqwgOZXn2ZqJhJ5uKdmAle0Dmk6dLyNAd1UX9PV2WggpOnGn8FOalghlvVoPCLzMtWffH/b52kVFQgV2VmtnF19ghUY1bPNfA2x6CTNYUDcZ8zW6BX4oy9RSpsDzggW1tdCJoLgIpNxcUSnhK5wLpv0yViDUaeH+5lKEReYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Njfjkhlf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Njfjkhlf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C722F1F00898;
	Sat, 12 Sep 2026 15:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789226246;
	bh=l4z4UUE2cvte4absAeVMzuQneJVY5GD1Ku0ix4zvAOQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=Njfjkhlf1hqsUD5tuPROKSSfIHm0lfuw7xztLe1SOKQdtP8DZJxfe1cXXbJxSHbHC
	 hMMdibTBCdsCsaa4T/l+Y2Cz3ByLHPFRkraj9HD5vFyybfRFu8jUxa9ZAxt7xsdpN2
	 67YejZCzqg3sKhqSJP/USKLvhXWScT2LRyhtSKNd5W5qZEDX5oFLtzSRipRQTTvDaF
	 HxE9h+qW4/R/VCU6daJZw1ANHhFMsXw6o8mQF2Nyhqp+/8nbEgeYxbPTukxrmKfzzV
	 uEr7Dr8RwG2yhUXjR8qrqkG+N906ypCnD3ZQLOkx1xB/1A3A+QzsVH6f9+mk1+TNZ8
	 Y4tpm2PhA12nw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56B86380820D;
	Sat, 12 Sep 2026 15:16:24 +0000 (UTC)
Subject: Re: [GIT PULL] fbdev fixes for v7.3-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <aqURvm8xf2oDLypa@carbonx1>
References: <aqURvm8xf2oDLypa@carbonx1>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <aqURvm8xf2oDLypa@carbonx1>
X-PR-Tracked-Remote: http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-7.3-rc3
X-PR-Tracked-Commit-Id: a0a34a40ed299c9c7cff6af163a5b883ee9d6d73
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 31a4327ffe2d8cbd0f51a3af6a3ffc5ecd7fdbee
Message-Id: <178922618297.3511661.11196158861938310035.pr-tracker-bot@kernel.org>
Date: Sat, 12 Sep 2026 15:16:22 +0000
To: Helge Deller <deller@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 12 Sep 2026 10:47:58 +0200:

> http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-7.3-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/31a4327ffe2d8cbd0f51a3af6a3ffc5ecd7fdbee

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
