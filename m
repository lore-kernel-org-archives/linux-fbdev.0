Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC231DE8BE;
	Fri,  8 Aug 2025 03:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754625577; cv=none; b=irf7yqAVUStiffTOtETsfnYds18zRJwzsbbY0JwuVGnSwu8dqBvRzNXkRZuGl4Wi88ven8nZwXchtWDNl+tze8FDWG3Spoq4F7z2BqdbEcZUfeB+c4GgUlWHO310O2I+s+YQNqwKw0NGs5mOGVMSBl1rCyFmk1EuJ2f7clI8noM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754625577; c=relaxed/simple;
	bh=dDGVzNI0/8rXzUldWHO1T8JVe4m2KDTBNlVV4OVdgA4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=GACviuuwddK7M65Oz2f/7z64Lb25IHz5WinwB6hFHMqoIoiCFAXnxpXrxUyteVICv+NgZ/5pUsXYyEegq3MJgEzoLsvJKvgaEvBOUZCb9IAMFIVlLxt1otlOpyE4nnwfauxzfkMaUPhG4QcivmHEobDKlBQMvM0KWMwomtBAEs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FV6DHNXl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FV6DHNXl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BEEEC4CEF9;
	Fri,  8 Aug 2025 03:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754625577;
	bh=dDGVzNI0/8rXzUldWHO1T8JVe4m2KDTBNlVV4OVdgA4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=FV6DHNXl6fB1wSdGM6tWfrPY6KwDxxSRgq7LR+Bni06E1CkAI5W90Oap7C+5R5A6s
	 oBXwHVk7Il0MMQ4SXpI7aKPiklbS5H6QogYmfRHSwuY8Mm0XLrh7tlZt5kppdIQKnn
	 m+R4OTeB9szzjVB0MoRImSlvQu0hGshUEyWIGzBnXG8KzVuMfX/4MdbHDzk6s2K6Or
	 VTYvKFlVsaOgqzpzjaJWjDrbAFxeL63voAqaQrJsDLaYJHGHRyi5Priun1YyIfFbN2
	 vpq9oE8SDdHPWK1aTf3bVx1LhdZMeJNOeBjUmeEkAiEi/mj4PavtMuVW1PHjHzL/ra
	 VBYpGMdkyQvaw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAECC383BF4E;
	Fri,  8 Aug 2025 03:59:51 +0000 (UTC)
Subject: Re: [GIT PULL] fbdev last fixes for v6.17-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <aJSMS8PhMMe0NL63@p100>
References: <aJSMS8PhMMe0NL63@p100>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aJSMS8PhMMe0NL63@p100>
X-PR-Tracked-Remote: http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-6.17-rc1-2
X-PR-Tracked-Commit-Id: e4fc307d8e24f122402907ebf585248cad52841d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2939a792c47e55fda4ae5b7f9ff47e34ddcef61a
Message-Id: <175462559058.3795225.6138069126738275835.pr-tracker-bot@kernel.org>
Date: Fri, 08 Aug 2025 03:59:50 +0000
To: Helge Deller <deller@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 7 Aug 2025 13:21:47 +0200:

> http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-6.17-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2939a792c47e55fda4ae5b7f9ff47e34ddcef61a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
