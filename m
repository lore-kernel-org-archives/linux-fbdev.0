Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13471311AC;
	Sun, 24 Nov 2024 17:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732469911; cv=none; b=GrjyiULl88x1JUbddh619HFVJW6QK6yxA6AYwliduXt5rzotbbfCGIhyFJFSCz7kAoIpu7vnpR49YwdE0VvbIYX8oL8bc+XAe7aHJ0X/p65HTI5r4+9zH0B6fYE4R/yJiYE++TvBxs6Hq6IqpwOKOeSUXSO0RFhAcpOBoVO8cy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732469911; c=relaxed/simple;
	bh=HxTYlh3ZiQ6RZupeK62kAyRgWiWDGmzBXEGGc5CWI4k=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=owl71o7vfIy4Gno4BN4byHRTe01P1ed9PGYAmGMtqubhTJ39ZsGwAzjGSdQX7XsWay0oLebLUY2zOEhYrnpf3ZXSLZ9FKy2wDnwKwAM6c9eNmYLjPvD8G+rOulxsNB8chmAtBhqVyZ6LZqjtiYQ/M+Cb4e8hGU7qU38b3RLlh0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iuLcgPE6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iuLcgPE6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D09E2C4CED8;
	Sun, 24 Nov 2024 17:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732469911;
	bh=HxTYlh3ZiQ6RZupeK62kAyRgWiWDGmzBXEGGc5CWI4k=;
	h=Date:From:To:Subject:From;
	b=iuLcgPE6ckXSU0xRVeNsTB6l2H0Gv2iF1wq7juLYDbQEW3sy7bx5LG+izQkra0srH
	 CI7K9HNj6TiRYUY7h+y7V3nBEZAMdroJhR8oqEzE+fpTI8QdTsvN43Wc9Z8L+JJUfm
	 sR5HtDb0a5Mlh/QUww5BwAs4dXY4ZMVI10tXMa45lEoisHrOa+pWhyxDcsIQ6CNmpx
	 cqUrMKeeQvDWUp8TFoVLZd+Cxkc9DsQhgMH5U/qrsDIlObFkpwFU417I3Wrn7Sc4VH
	 UMqFTtZoSDnjah7E4bwMRs4dX1qqA5a1PRCbklbKDcnQp45wykrBi+ilTGMnLytiEv
	 qceZq+Qcg4F4w==
Date: Sun, 24 Nov 2024 18:38:26 +0100
From: Helge Deller <deller@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [GIT PULL] fbdev fixes and cleanups for v6.13-rc1
Message-ID: <Z0NkkihDqEwi3k9Y@carbonx1>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

please pull two patches for fbdev for this merge window:
One removes a memory leak in an error path, the other drops unused code.

Thanks,
Helge

----------------------------------------------------------------
The following changes since commit 2d5404caa8c7bb5c4e0435f94b28834ae5456623:

  Linux 6.12-rc7 (2024-11-10 14:19:35 -0800)

are available in the Git repository at:

  http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-6.13-rc1

for you to fetch changes up to 8d7493133bfd89322349be3daaf39a256e4354ac:

  fbdev: omapfb: Remove some deadcode (2024-11-14 15:30:36 +0100)

----------------------------------------------------------------
fbdev fixes and updates for 6.13-rc1:

- omapfb: Remove unused code (Dr. David Alan Gilbert)
- sh7760fb: Fix memory leak in error path of sh7760fb_alloc_mem()
  (Zhen Lei)

----------------------------------------------------------------
Dr. David Alan Gilbert (1):
      fbdev: omapfb: Remove some deadcode

Zhen Lei (1):
      fbdev: sh7760fb: Fix a possible memory leak in sh7760fb_alloc_mem()

 drivers/video/fbdev/omap2/omapfb/dss/dispc.c | 27 ---------------------------
 drivers/video/fbdev/omap2/omapfb/dss/dss.h   |  3 ---
 drivers/video/fbdev/sh7760fb.c               |  3 +--
 3 files changed, 1 insertion(+), 32 deletions(-)
