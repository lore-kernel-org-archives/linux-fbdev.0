Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9A1EEBA;
	Sat, 29 Mar 2025 01:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743210074; cv=none; b=usw/caBO058eYXlZUE/UndEx3A0DysUClV5WLFzCVs7uGGDQRRZLG5YNcTSHWpG4HFl6sL3hRvktSujy8U/YbDN3XmUN3rBHqoEe6lQD0Ty+/da8NDbhkUpjKUgZ6OmXLa9cVqvb/IBXJgjxI1iObfFFqMIC2cGb7Z6K7HY4444=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743210074; c=relaxed/simple;
	bh=sqiKEDM9mdNJ8ZhtkSRpedz2piPMJrTIfUBcVnm0wuI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=pyxMstojhewqmCCe17/h/qESTfDxx3fNU000WwJ4WxbrZvKuvd8aSCEG1uZiWT1JOjt1GZRardp7Dv96B/Dg/dXKr53dJiYG+bPyXD4z5ecSD8ghKleyi7o6e45R1hXow1rxYDN0V8YwJ8vJWt1ksq073cqu4XEDhaeudLI0x2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XXYeE0Mn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XXYeE0Mn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A8B2C4CEE5;
	Sat, 29 Mar 2025 01:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743210074;
	bh=sqiKEDM9mdNJ8ZhtkSRpedz2piPMJrTIfUBcVnm0wuI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=XXYeE0MnBGIpDfBQGvUWD1EdVC033KEdbhDYfQLiNbWRLjXZAK7QWChM0/Aj8dxLX
	 hxdbKPZrRbNhThUttUB9xTmzBDWLwBY+TvZOJTljBC58CHq3WIyZJ4Lknk5qJAljOM
	 5bfUY+h20y16BivtUP8YkNtEk7UVb/lo2pG/kMLmzRmXphwcXnGi7MWkHhbJ71WZ/S
	 pObFcbdVtf8P2hjwObQvXsv+EVHQDmCiwe2F4yZeKIDKlLQp1BRgUX+vyPxhU42Ghq
	 sD5QDLxqHWdasH56sSUEqkQVcIvi+wVRldnhRMBuP+qXyH8p2LzXnktllbqoqL1R8y
	 KzIbY8XRN84pw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1A290380AA79;
	Sat, 29 Mar 2025 01:01:52 +0000 (UTC)
Subject: Re: [GIT PULL] fbdev updates for v6.15-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z-WS-lDPPmxnbG3W@carbonx1>
References: <Z-WS-lDPPmxnbG3W@carbonx1>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Z-WS-lDPPmxnbG3W@carbonx1>
X-PR-Tracked-Remote: http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-6.15-rc1
X-PR-Tracked-Commit-Id: 86d16cd12efa547ed43d16ba7a782c1251c80ea8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 51aad189f8e0f926c0977d180cae6a78df445f27
Message-Id: <174321011079.3019715.58612314047981354.pr-tracker-bot@kernel.org>
Date: Sat, 29 Mar 2025 01:01:50 +0000
To: Helge Deller <deller@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 27 Mar 2025 19:03:38 +0100:

> http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-6.15-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/51aad189f8e0f926c0977d180cae6a78df445f27

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
