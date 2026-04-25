Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E824280309;
	Sat, 25 Apr 2026 08:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777105648; cv=none; b=nox4GzNI1ea6GYR57OoccfrT/pJcp/77kJt5Jo0XTmDkKybr23+yVtguh7VskcRDG6lzgOFVi8hMGR3qbTTtN5AxoqL0uwCzZMNXB9QZVyRNgLr1iF+yI+nUb/soKhnMbwDPi+p/6INC79p09ZJB6bXqfBYmS+hp+A/AyBQ25fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777105648; c=relaxed/simple;
	bh=JGYbF/CAx2fm2Y2c+p/5FAbpm8wEl0YaPWaPki3UAQI=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gPNDAmBZ3wcTmnU9m18tCTC4+vsqwmhlaEhqGo1DBmZPb22yHlY5YGg8QLD37l1/yL0zdjjSA8N+3qv7dlrby+ieyv6gGFCdRdoVs4F0trYBM/6Guov/d9QeoQJgW9EiCtwhO2RxIOKMA8JEVV7jv9S3B40UoZnpdLg1/hmL26I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V5TqowGn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V5TqowGn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94A00C2BCB0;
	Sat, 25 Apr 2026 08:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777105648;
	bh=JGYbF/CAx2fm2Y2c+p/5FAbpm8wEl0YaPWaPki3UAQI=;
	h=Date:From:To:Subject:From;
	b=V5TqowGnA37KGTd6X1s5M/3iguCrArMV0LRVsj1ZCmCZxECDF8R85ciG05iRBvOvS
	 84dm7AUuxGMWztjh+QDQ5ySaiZj+iHgXb31F8pR5dGvid1G8NYfrxnQSWv2Xozu0se
	 aIurOIF5d8WfFe2dAVp3q2GzAdJ0H2Z/RrLz99bIeZBvFc9lKTVWTBqHnRMNlKFo9+
	 wApSaK4IziZrXgwHRKR91NoV4s6dDymvp472Z5pl+ztFQNculj3TS8n6JObXkUWyKT
	 B4FmfmxbwMGuVL3GPa67nlyxwii3jVE6UHDL+bVBN8rWLOFhB1YghG2c2HiKpl5oEi
	 wCGX/5Vm0WP9g==
Date: Sat, 25 Apr 2026 10:27:23 +0200
From: Helge Deller <deller@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [GIT PULL] more fbdev fixes for v7.1-rc1
Message-ID: <aex66_AU379EYm_a@carbonx1>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

please pull a few remaining fbdev fixes for this merge window.

Thanks!
Helge

----------------------------------------------------------------


The following changes since commit 6596a02b207886e9e00bb0161c7fd59fea53c081:

  Merge tag 'drm-next-2026-04-22' of https://gitlab.freedesktop.org/drm/kernel (2026-04-21 17:39:21 -0700)

are available in the Git repository at:

  http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-7.1-rc1-2

for you to fetch changes up to 448aaf54d3ae1b73dfcf723c9f8a02c2116f3358:

  fbdev: hgafb: Request memory region before ioremap (2026-04-22 17:02:55 +0200)

----------------------------------------------------------------
fbdev fixes & cleanups for 7.1-rc1:

- request memory region before use (cobalt_lcdfb, clps711x-fb, hgafb)
- reference cleanups in failure path (offb, savage)
- a spelling fix (atyfb)

----------------------------------------------------------------
Amit Barzilai (2):
      fbdev: cobalt_lcdfb: Request memory region
      fbdev: clps711x-fb: Request memory region for MMIO

Ethan Carter Edwards (1):
      fbdev: atyfb: Fix spelling mistake "enfore" -> "enforce"

Hardik Phalet (1):
      fbdev: hgafb: Request memory region before ioremap

Yuho Choi (2):
      fbdev: offb: fix PCI device reference leak on probe failure
      fbdev: savage: fix probe-path EDID cleanup leaks

 drivers/video/fbdev/aty/radeon_monitor.c     |  2 +-
 drivers/video/fbdev/clps711x-fb.c            |  9 +++------
 drivers/video/fbdev/cobalt_lcdfb.c           | 12 +++---------
 drivers/video/fbdev/hgafb.c                  |  9 +++++++--
 drivers/video/fbdev/offb.c                   |  7 ++++++-
 drivers/video/fbdev/savage/savagefb_driver.c |  2 ++
 6 files changed, 22 insertions(+), 19 deletions(-)
