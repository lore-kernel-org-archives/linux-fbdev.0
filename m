Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B172B189912;
	Wed, 18 Sep 2024 11:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726657811; cv=none; b=MFerd/pKSZLDLUfLcKATLSdvAaXMXTLZhdCRLGsspR5y0/apXZSjdfbpZg68/nO+gFBdJh2DvA6lC1ZP0p97nymas0WzvplDebFSnQh4TDi69TIHlLn5S68yQrvP/mZQQPwyCXYzPdAzHyLiMvHvMY15lYvEIA7S36TKv+oXYrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726657811; c=relaxed/simple;
	bh=sMliz4gd2eFGqi4kOsHVZgumrrOMtR68PGAmjugcjMU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=mr/3q051nNuEsvSt0RO8NgYGeqHSnfRrz9HjkWwPe7OcedxcJgAd+X85sKs0wvA9NJ6xSTr5DKPnDcEF+cHLdH+VgOvh87o6rqvb9FlxUH4WXI0TWO54Ld31+8lW4+V+HeJTUvkaA6O9UInYkJS3cAtTLS+cHi+9CVLcHraTQzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HLa+huUg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HLa+huUg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 945BCC4CED0;
	Wed, 18 Sep 2024 11:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726657811;
	bh=sMliz4gd2eFGqi4kOsHVZgumrrOMtR68PGAmjugcjMU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=HLa+huUgVHl4F+elncCOjwwY9h7ORr/YLcUoFyWk4wB8M4+rbrYBWaht5Qs8doHMS
	 ii/pDDa7NEjr+mIRAawl7gI7up0/NjnDCQdL3pk4VivbE1bItUkM0j/xaZrbUcKyCS
	 kFlTPMewP4L7l1c8YlZ03hChGbp+pAvYvFSbEB82Guoc8AzzYkIGyKwtkXaAdDU+L6
	 Aoyp3YFk61xX8YfzQ9s4b10ur3MjFY0x0SAijPDjCp2vbdtf/twBSKEhqDUm7xid0r
	 4nk98g/9YQV6zAT3jbSgEmS84JdNP6ifd3iXxFYZ7poaSIS+ZkLRMozR3cwRSHFWfk
	 aZGlJuTYkdDVw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9E3333806656;
	Wed, 18 Sep 2024 11:10:14 +0000 (UTC)
Subject: Re: [GIT PULL] fbdev fixes and cleanups for v6.12-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZumkJA3zfB8AhDsF@carbonx1>
References: <ZumkJA3zfB8AhDsF@carbonx1>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZumkJA3zfB8AhDsF@carbonx1>
X-PR-Tracked-Remote: http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-6.12-rc1
X-PR-Tracked-Commit-Id: de5e89b6654ea0b021a5737e0f55fc6bed625550
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f4960b002ce81f8e51245bfad0fb7eb4103962ff
Message-Id: <172665781355.783948.6236421147987972661.pr-tracker-bot@kernel.org>
Date: Wed, 18 Sep 2024 11:10:13 +0000
To: Helge Deller <deller@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 17 Sep 2024 17:45:40 +0200:

> http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-6.12-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f4960b002ce81f8e51245bfad0fb7eb4103962ff

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
