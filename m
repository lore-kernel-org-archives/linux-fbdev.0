Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1A220D51D;
	Fri, 25 Oct 2024 18:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729879823; cv=none; b=XVzQ59zdJBJhIS5goD+SpIwEHaO1jPWdgFSpF3D0OHp27LkbNzJDkeMvsz9RHDOh+X8aGiyoGupM+sYHS/ep08E1OTzBdFA8DaFVihUCe6AKoIKD37GlolH2N6LoSHFrCYekVq5/bAGJVk22UrpRe3SLU/NXUA3v1vmARDzy2v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729879823; c=relaxed/simple;
	bh=8sijDT/Ff+1t0myfCntf06u9CjTz1M02ecQUg3/BSkg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=n9+9jVrjDcQDsiPcRjjNPcTDMgH8FlRVNp2s11dQpQbhuM+eotn0pVfMnMxbL6ElSGTE+iO01znrfffa2aQZnWu8m3Cd2cmHDfqe2IxGMlCznO1ZU/cqxsGH8qExsSYZC+OeytDXQ99oaAxXJfVmsyLGkVRSvPV6qz4t8Pv5UAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QsaCGM3q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QsaCGM3q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EB02C4CEE7;
	Fri, 25 Oct 2024 18:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729879823;
	bh=8sijDT/Ff+1t0myfCntf06u9CjTz1M02ecQUg3/BSkg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=QsaCGM3qi+l3fCu6h+96IUWCyVhcjWle3QErjT0ERDy5GnVYHFsCFWvO3idBjTi+X
	 D0DDqjibSqDjHAzfT0aL3433rv3zmEbBc7ZbyJ0L6KdNfGGup1NanC2RwULsJAsqBg
	 8RHnCg2PkhHx/fjOS7dv+pgd+Dx835NWI2Wv1dbILYxVR7/xm58oql3SeIN677XZPR
	 Uh0XHPF/6rmbU626om+ufzSRwiCosg9uL32NPgEgspFFcsZlyQSGTkonbb48vq63Gn
	 eh8Rsjtk6i0vloW3zCg5wCy4zayCHA+Bxuy1mtbKj58RFFvrifSMDcwrEkMuQMOCIR
	 kzjDjvhdsjPdQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 65A553809A8B;
	Fri, 25 Oct 2024 18:10:31 +0000 (UTC)
Subject: Re: [GIT PULL] fbdev late fixes for v6.12-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZxvBfDuqSC_TEM78@carbonx1>
References: <ZxvBfDuqSC_TEM78@carbonx1>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZxvBfDuqSC_TEM78@carbonx1>
X-PR-Tracked-Remote: http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-6.12-rc5
X-PR-Tracked-Commit-Id: 51521d2e2c35959cc70a62ccddf694965e29c950
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 86d6688e6099594e732841ddad69fad196e95245
Message-Id: <172987983019.2993589.17998271439482235659.pr-tracker-bot@kernel.org>
Date: Fri, 25 Oct 2024 18:10:30 +0000
To: Helge Deller <deller@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 25 Oct 2024 18:04:12 +0200:

> http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-6.12-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/86d6688e6099594e732841ddad69fad196e95245

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
