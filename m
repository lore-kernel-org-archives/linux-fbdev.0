Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA47318859B;
	Thu, 30 Oct 2025 16:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761840854; cv=none; b=dhPcxwtxEAWbwXx6M8gVbvecR01q89Tnz6BFWdtia8vO/NuztoPWY86lJ9Xft8bYTnWt+V3fpMYBo3ao10UCbEsn+g4gVercFtaO5j5+sNvVJJzpca5gbnwg/44PjZzH0vKNQfwlzQ2YzX9oHrQSWDh4reHrQsr/XoqvY82WUY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761840854; c=relaxed/simple;
	bh=WadIyrGhjZmtFOmTht7Qz2UfFstKfJJoO9MBbxCO7VM=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aw9IX99SEnjAh33H4YrbgY6bE/+4TWp9EXZDe2/8Vx1Tc0ShjHg1UpCcLDr1rWI1J7qNybh48zjD2VeaFmHBQVDBs47apqnfe9Lw+787vQOIM482RpTF/y8ga36Jny0JP4Sf5dSql8K58wfCvcm36mHyEDBQAHMSvIZ+MuhxlSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dWCpovhC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dWCpovhC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83245C4CEF8;
	Thu, 30 Oct 2025 16:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761840852;
	bh=WadIyrGhjZmtFOmTht7Qz2UfFstKfJJoO9MBbxCO7VM=;
	h=Date:From:To:Subject:From;
	b=dWCpovhC0QJKOMFQNIVOMcghgZoDCVTglKArdzpJGz5p50ZqJFbM+73TRaXAVSL7x
	 xPz931w1iIC/lBgNRyVQMinkpdaA/M/7TPCZl7Mxc6dtkBkfgzMxHUJFKU8B/tWlEn
	 ZlOEXP4TFX8MyqYg4v3b1vIIcimhLq8cw665CDuaGJwKhTbSoV+Fup7Eti5Ept0Hyl
	 YzB0JxSlRo5a59VWXh3wH7jpmgJuY9Ei++8hdUd2Ft/Pp3EPOasWzAJRG5o6edUKim
	 UfQiJp4JiSOblN3V2Vh1t+brbguYQWZ/lm/9pmrJj9q81scFDPwQQpuFxvQKI0ZRYP
	 YYKIQNxrqZvSQ==
Date: Thu, 30 Oct 2025 17:14:07 +0100
From: Helge Deller <deller@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [GIT PULL] fbdev fixes for v6.18-rc4
Message-ID: <aQOOz7Q27BbUo-_4@carbonx1>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

please pull a few important bugfixes for various fbdev drivers for 6.18-rc4.

All patches are tagged for stable series.
Includes a trivial typo fix for the fb.h header as well.

Thanks!
Helge

----------------------------------------------------------------
The following changes since commit dcb6fa37fd7bc9c3d2b066329b0d27dedf8becaa:

  Linux 6.18-rc3 (2025-10-26 15:59:49 -0700)

are available in the Git repository at:

  http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-6.18-rc4

for you to fetch changes up to 7073c7fc8d8ba47194e5fc58fcafc0efe7586e9b:

  fbdev: atyfb: Check if pll_ops->init_pll failed (2025-10-28 22:59:19 +0100)

----------------------------------------------------------------
fbdev fixes for 6.18-rc4:

- atyfb: Avoid hard lock up when PLL not initialized (Daniel Palmer)
- pvr2fb: Fix build error when CONFIG_PVR2_DMA enabled (Florian Fuchs)
- bitblit: Fix out-of-bounds read in bit_putcs* (Junjie Cao)
- valkyriefb: Fix reference count leak (Miaoqian Lin)
- fbcon: Fix slab-use-after-free in fb_mode_is_equal (Quanmin Yan)
- fb.h: Fix typo in "vertical" (Piyush Choudhary)

----------------------------------------------------------------
Daniel Palmer (1):
      fbdev: atyfb: Check if pll_ops->init_pll failed

Florian Fuchs (1):
      fbdev: pvr2fb: Fix leftover reference to ONCHIP_NR_DMA_CHANNELS

Junjie Cao (1):
      fbdev: bitblit: bound-check glyph index in bit_putcs*

Miaoqian Lin (1):
      fbdev: valkyriefb: Fix reference count leak in valkyriefb_init

PIYUSH CHOUDHARY (1):
      video: fb: Fix typo in comment in fb.h

Quanmin Yan (1):
      fbcon: Set fb_display[i]->mode to NULL when the mode is released

 drivers/video/fbdev/aty/atyfb_base.c |  8 ++++++--
 drivers/video/fbdev/core/bitblit.c   | 16 ++++++++++++----
 drivers/video/fbdev/core/fbcon.c     | 19 +++++++++++++++++++
 drivers/video/fbdev/core/fbmem.c     |  1 +
 drivers/video/fbdev/pvr2fb.c         |  2 +-
 drivers/video/fbdev/valkyriefb.c     |  2 ++
 include/linux/fbcon.h                |  2 ++
 include/uapi/linux/fb.h              |  2 +-
 8 files changed, 44 insertions(+), 8 deletions(-)
