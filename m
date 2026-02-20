Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0031D555;
	Fri, 20 Feb 2026 07:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771573781; cv=none; b=lfqQiOK5lBYyFZKxUfeQRvEaCqQXeq1MPfHdXN0AFHggfevxSKoyRFiVIZYZn1y2M1nJ3oWqdKwoZvgCpgituSl7eFK0Ry8nMC7fAypZzvg/LWFBqsbWor9qDZ+3qgBfecLHxHSpHXT7PwjIYUI6tEil3LPe8UwGGJi/0Zy12Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771573781; c=relaxed/simple;
	bh=UzVeBE3iCh3DSBT9JWduA7mU0vNfL1xU4qqoBfwV5VA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EfX/3zO9CikEt84lLs8HKK6rSZ2g8S0+ci1JtmuP0sxFgfdwbvcaGJAa3dDL6uZUx+UT0QHMzClSMsD+1SlAS5dPukqyp96kcJHWoptpaVkJU/8yG5Z8PeyaPBrUq0elpupBv03Ss5wgbNRTxLkDa6BPZe1qu3Xrlkn2ZydZhgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jkbzd5p6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jkbzd5p6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1115EC116C6;
	Fri, 20 Feb 2026 07:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771573780;
	bh=UzVeBE3iCh3DSBT9JWduA7mU0vNfL1xU4qqoBfwV5VA=;
	h=Date:From:To:Cc:Subject:From;
	b=jkbzd5p6L86cvUNE5W0/AIY/bChKdWTd1SrL2ZKRxlRP9nIiHUZJgxuGbPHkxruR0
	 biqh344PmHRGvUrg6EwmYNQ7ayQGyKSCmtm6tvsgi3A7FQsbG4cM2iXXbCe+eMTbON
	 tpStkzWaQnbfi7DsPAKUKMGu6pRxH9U20wDUpp1wq9IP6I0SKT78/1gmuCUSzo4dmF
	 dsh+v8hHGDFC4Re0q+KU1vOGByyKUt99BtjDdOOJwnUTrJ6cKaKCSXKU/ifLqNhIRl
	 693UkIkx58gWmFW70Ot5eBf2mVN2G3X8imOB98t+E5KeRVAB8vpCpWK4Guc8PAPJd3
	 sHPL6190NLqSg==
Date: Fri, 20 Feb 2026 08:49:35 +0100
From: Helge Deller <deller@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: Uwe =?iso-8859-15?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Subject: [GIT PULL] au1100fb fbdev updates for v7.0-rc1
Message-ID: <aZgSDyT2VcYM4R_Z@carbonx1>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Linus,

please pull a series of patches with code cleanups for the au1100fb driver.

Thanks!
Helge

----------------------------------------------------------------

The following changes since commit 26a4cfaff82a2dcb810f6bfd5f4842f9b6046c8a:

  Merge tag 'docs-7.0-2' of git://git.kernel.org/pub/scm/linux/kernel/git/docs/linux (2026-02-15 10:47:59 -0800)

are available in the Git repository at:

  http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-7.0-rc1-2

for you to fetch changes up to 0f967cb8ea04486953f85b249b42dda3de842053:

  fbdev: au1100fb: Replace license boilerplate by SPDX header (2026-02-19 17:38:17 +0100)

----------------------------------------------------------------
fbdev enhancements for 7.0-rc1:

A series with code cleanups for the au1100fb fbdev driver [Uwe Kleine-König].

----------------------------------------------------------------
Uwe Kleine-König (7):
      fbdev: au1100fb: Don't store device specific data in global variables
      fbdev: au1100fb: Mark several local functions as static
      fbdev: au1100fb: Use proper conversion specifiers in printk formats
      fbdev: au1100fb: Make driver compilable on non-mips platforms
      fbdev: au1100fb: Replace custom printk wrappers by pr_*
      fbdev: au1100fb: Fold au1100fb.h into its only user
      fbdev: au1100fb: Replace license boilerplate by SPDX header

 drivers/video/fbdev/Kconfig    |   3 +-
 drivers/video/fbdev/au1100fb.c | 487 ++++++++++++++++++++++++++++++++++-------
 drivers/video/fbdev/au1100fb.h | 379 --------------------------------
 3 files changed, 406 insertions(+), 463 deletions(-)
 delete mode 100644 drivers/video/fbdev/au1100fb.h
