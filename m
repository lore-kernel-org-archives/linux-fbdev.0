Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB621E7C12;
	Fri, 10 Oct 2025 13:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760103091; cv=none; b=Puw+PCTelWqFMxEI6r0qZRccT8Ncz/C901GDm0P0fXOBIEyO2fyH+7DBV60Xm48tsK6Q9Oypd0xg6dRDXirtfQtj7P6rIrU5s9S4DFax7BVdGSIfSk9+UrrgC11snm6dvZ/76xadZptAyaUg/L7isb/rANp1tCjFTmL1vhaJBw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760103091; c=relaxed/simple;
	bh=DBBGRFqDlMVt5G1ikqwvqLGMEPnfjnHGilMhjC87DJQ=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=iD952B6bxkstOQpRrW0RCUAQu212UbaikoqMg9h6wDyfzw/DYlmLvsdQSE+BY6iL0QLJjZ6//t7pNoySkvZYEQjhpfDWhtg1iMyVttUpH75za9WccwTkKeOg1nXUJsGId5niNdnOAf39ZMBSTe3GAjVQkHV/ZtQ9XprnEwp5kOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cLMDkBYV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cLMDkBYV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93E9EC4CEF1;
	Fri, 10 Oct 2025 13:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760103091;
	bh=DBBGRFqDlMVt5G1ikqwvqLGMEPnfjnHGilMhjC87DJQ=;
	h=Date:From:To:Subject:From;
	b=cLMDkBYV3nNQ67EHcMPOETbVwjTgVdaJ17impKXuFxM7IaSvWpmR0yxb6/lz9fMfT
	 m7vsAF1E2MBFUxHNJE5PvYSGeQ2UzuqgibaTx0WzSNr6euijOSH70A9STnQpcy9I3q
	 KLV4Qe1fxscm6mUxtEu5uqrqQXqvsHhmiVzOH+Wl9vOvAOKbQxjaDfNPHeJcNJwCm5
	 sEa5N9wesZaC8NpRUtu62bCJzLmeVug9CjYsK53nCI9l2iARWF33gR7buUv8Q/SFnO
	 qMtLIkm+35cKSr9Xkwe+3A7a9WqfgyJE0Ep31WQOCgMVwFkwXPzbqWPN6ZJYHlDSrZ
	 2YQeeD5K1vMDg==
Date: Fri, 10 Oct 2025 15:31:26 +0200
From: Helge Deller <deller@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [GIT PULL] fbdev updates for v6.18-rc1
Message-ID: <aOkKroU5EAorYET0@carbonx1>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

please pull the fbdev updates for 6.18-rc1.

Beside the usual bunch of smaller bug fixes, the majority of changes
were by Zsolt Kajtar to improve the s3fb driver.

All patches have been a few days in for-next.
Last minute I decided to drop one patch yesterday, which is why it seems the
newest patch isn't that long in for-next yet....

Thanks,
Helge

----------------------------------------------------------------
The following changes since commit e5f0a698b34ed76002dc5cff3804a61c80233a7a:

  Linux 6.17 (2025-09-28 14:39:22 -0700)

are available in the Git repository at:

  http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-6.18-rc1

for you to fetch changes up to 15df28699b28d6b49dc305040c4e26a9553df07a:

  fbdev: Fix logic error in "offb" name match (2025-10-10 00:31:13 +0200)

----------------------------------------------------------------
fbdev fixes & enhancements for 6.18-rc1:

Bug fixes:
- Add bounds checking in bit_putcs to fix vmalloc-out-of-bounds (Albin Babu Varghese)
- Fix logic error in "offb" name match (Finn Thain)
- simplefb: Fix use after free in simplefb_detach_genpds() (Janne Grunau)
- s3fb: Various fixes and powersave improvements (Zsolt Kajtar)

Enhancements & code cleanups:
- Various fixes in the documentation (Bagas Sanjaya)
- Use string choices helpers (Chelsy Ratnawat)
- xenfb: Use vmalloc_array to simplify code (Qianfeng Rong)
- mb862xxfb: Use int type to store negative error codes (Qianfeng Rong)
- Make drivers depend on LCD_CLASS_DEVICE (Thomas Zimmermann)
- radeonfb: Remove stale product link in Kconfig (Sukrut Heroorkar)

----------------------------------------------------------------
Albin Babu Varghese (1):
      fbdev: Add bounds checking in bit_putcs to fix vmalloc-out-of-bounds

Bagas Sanjaya (3):
      Documentation: fb: Split toctree
      Documentation: fb: ep93xx: Demote section headings
      Documentation: fb: Retitle driver docs

Chelsy Ratnawat (1):
      fbdev: Use string choices helpers

Finn Thain (1):
      fbdev: Fix logic error in "offb" name match

Janne Grunau (1):
      fbdev: simplefb: Fix use after free in simplefb_detach_genpds()

Qianfeng Rong (2):
      fbdev: xenfb: Use vmalloc_array to simplify code
      fbdev: mb862xxfb: Use int type to store negative error codes

Sukrut Heroorkar (1):
      fbdev: radeonfb: Remove stale product link in Kconfig

Thomas Zimmermann (1):
      fbdev: Make drivers depend on LCD_CLASS_DEVICE

Zsolt Kajtar (4):
      fbdev: s3fb: Implement powersave for S3 FB
      fbdev: s3fb: Implement 1 and 2 BPP modes, improve 4 BPP
      fbdev: core: Fix ubsan warning in pixel_to_pat
      fbdev: s3fb: Revert mclk stop in suspend

 Documentation/fb/aty128fb.rst              |   8 +-
 Documentation/fb/efifb.rst                 |   6 +-
 Documentation/fb/ep93xx-fb.rst             |   4 -
 Documentation/fb/gxfb.rst                  |   8 +-
 Documentation/fb/index.rst                 |  80 +++++++------
 Documentation/fb/lxfb.rst                  |   9 +-
 Documentation/fb/matroxfb.rst              |   9 +-
 Documentation/fb/pvr2fb.rst                |   6 +-
 Documentation/fb/sa1100fb.rst              |   9 +-
 Documentation/fb/sisfb.rst                 |   6 +-
 Documentation/fb/sm712fb.rst               |   6 +-
 Documentation/fb/tgafb.rst                 |   6 +-
 Documentation/fb/udlfb.rst                 |   6 +-
 Documentation/fb/vesafb.rst                |   6 +-
 drivers/video/fbdev/Kconfig                |   8 +-
 drivers/video/fbdev/core/bitblit.c         |  17 +++
 drivers/video/fbdev/core/fb_cmdline.c      |   2 +-
 drivers/video/fbdev/core/fb_fillrect.h     |   3 +-
 drivers/video/fbdev/core/fbmon.c           |   7 +-
 drivers/video/fbdev/mb862xx/mb862xxfbdrv.c |   2 +-
 drivers/video/fbdev/nvidia/nvidia.c        |   3 +-
 drivers/video/fbdev/pxafb.c                |   3 +-
 drivers/video/fbdev/s3fb.c                 | 177 ++++++++++++++++++++---------
 drivers/video/fbdev/simplefb.c             |  31 +++--
 drivers/video/fbdev/xen-fbfront.c          |   2 +-
 25 files changed, 259 insertions(+), 165 deletions(-)
