Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547A01EEA3C;
	Sat, 25 Apr 2026 15:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777130397; cv=none; b=HPHBKAwX05dfBOALseoavyhAvMP87VwTUc6tDXCQFrCd/ydmitHsQarBXWVyRGD32r0XV5kHVYg3bJuhSntfhYknd8qxeNQ90aLcWUU7akXbdGVbqTbjG0y3i3UrkKDeajIEMwlgIDBcNKwyfZ7khYuzknNIcXCVGPIO7u6gAJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777130397; c=relaxed/simple;
	bh=p+/TJClLL7ZSy93mPEIFdv+ZR12IgWfKo9hdpLIaYi8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=IeU2bme9rZAqVqHueJ7ABSlBl/+8r0yqX70v71ulBAhP5FAXu5u1bBAkPMa4POJQit1iPqY7PSE9ygzk2UucWR7EPIIeJlJAu0hA8A3w4P5d4JP/G39tNdRgnbNBGqe0jOcvVo9+LXRfDzC4iJ3Deu03B8Ur+YOOm/d50rzpvB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WL2nHQhs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WL2nHQhs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38669C2BCB0;
	Sat, 25 Apr 2026 15:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777130397;
	bh=p+/TJClLL7ZSy93mPEIFdv+ZR12IgWfKo9hdpLIaYi8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=WL2nHQhsc+Nxw5XNlhzqx5BfS/rzgiM+5MMA2xckIvS3LChNfcT8tRsNeKPrMStVq
	 13Gi71D5avbaOO8JU/jmDT3ze/qSnj4VNU5CzXKxCBbevf/Hi+8xjXddf8ajEXm9R0
	 xz77iDJ12VKP9L7dZruESZVHZJQ+HHEyiieNbfCxrrqODNj3C8xGcxgko6A6JXy1Zm
	 fBf5AS/GSET6/suNRgyUYHMJNR9+uJIiRn1kvN+NE+ALNEQbqAA2kiYhIMiWDos8Mv
	 IH+79UdpfTMS8Mn1XYQPK+/5V9XyoNeyvdXuJsXOA2kZfiDPQkRDU6PG9ZYliz1/yE
	 PZ8nWtkwPNmAw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02EB538119CB;
	Sat, 25 Apr 2026 15:19:18 +0000 (UTC)
Subject: Re: [GIT PULL] more fbdev fixes for v7.1-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <aex66_AU379EYm_a@carbonx1>
References: <aex66_AU379EYm_a@carbonx1>
X-PR-Tracked-List-Id: <linux-fbdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <aex66_AU379EYm_a@carbonx1>
X-PR-Tracked-Remote: http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-7.1-rc1-2
X-PR-Tracked-Commit-Id: 448aaf54d3ae1b73dfcf723c9f8a02c2116f3358
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 897d54018cc9aa97fd1529ca08a53b429d05a566
Message-Id: <177713035656.1989237.16063921227445244104.pr-tracker-bot@kernel.org>
Date: Sat, 25 Apr 2026 15:19:16 +0000
To: Helge Deller <deller@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 25 Apr 2026 10:27:23 +0200:

> http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-7.1-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/897d54018cc9aa97fd1529ca08a53b429d05a566

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
