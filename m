Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B792B21ADA6;
	Fri, 24 Jan 2025 20:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737749089; cv=none; b=l2jNEwaGO4ZMYkVBrbT8/5qG6AnAtbnxyF5fhT/TKhwmp7vFbAYlRk6OjKWpCdkN2D4Zie6LzmPmiJRhmFyJ3tCuhR5abnGmcbanDI743kHuiKMmLtPKRFAbAG0LPsYsrBU35GaW8EeF65kvYO0brXA3DRtybrll8d8saTOxQnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737749089; c=relaxed/simple;
	bh=66DAqseZ2lNKxCLXrNtC9M/P/NwPacWgh830TNY+CdQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=R/ijSoygK33jQ5azMpE4kYFQ7VzaxCGtR51qxkjDdfSPZJo7rR1By5dSCt0FQKyMDQ+30JZQhgnSgs+6FvTwTX3NoXMk7Ws8kq9rbzPUwg5/098yATwRIW8iF75Z4gaI6Vmo1BJuMsXb/XK/oRU6P23AFQY6GgmxeWpdoJyz97A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NVTQa6Hb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NVTQa6Hb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ADBCC4CED2;
	Fri, 24 Jan 2025 20:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737749089;
	bh=66DAqseZ2lNKxCLXrNtC9M/P/NwPacWgh830TNY+CdQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=NVTQa6HbfERISaWyU1xrg3q78ynrZZdGXhg2pmWMu09dkggzC4c01soeh8/avpNM5
	 vdj1iI1be4UdOuG6n7vg5J24yLY0SITLqLjMtZ/HVe6BfgcPGGfomJUXrimlfpgcaA
	 HCGJnFx8yz0W9vhUew5FSPHPeb8aAkR3fahUpZL966dzH0ZASHRKCjUdOAILvNTiyo
	 PuW27gLsMr1kEGHDYUAkHwBL1qhkb8i70mqHjy6aBP8MmquWhD2bSxJ9gKoNNxFUj+
	 M+cImD+lBP7C+zhllLmEdFOyBTOQY6rM8Qa18+qrPY3pqASywJ9cgRE9bsiGp528MO
	 w9U89cU8zt+Uw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE535380AA79;
	Fri, 24 Jan 2025 20:05:15 +0000 (UTC)
Subject: Re: [GIT PULL] fbdev fixes and cleanups for v6.14-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z5JwASMQjjTjEncJ@carbonx1>
References: <Z5JwASMQjjTjEncJ@carbonx1>
X-PR-Tracked-List-Id: <linux-fbdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <Z5JwASMQjjTjEncJ@carbonx1>
X-PR-Tracked-Remote: http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-6.14-rc1
X-PR-Tracked-Commit-Id: d08e78362a5f5e156b6a1dae90c28ed48c0a8357
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ac0761d8d8315759562a3b85120d482cedf44328
Message-Id: <173774911422.2152159.1279783714348469917.pr-tracker-bot@kernel.org>
Date: Fri, 24 Jan 2025 20:05:14 +0000
To: Helge Deller <deller@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 23 Jan 2025 17:36:17 +0100:

> http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-6.14-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ac0761d8d8315759562a3b85120d482cedf44328

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
