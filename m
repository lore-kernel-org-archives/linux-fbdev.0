Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792703775;
	b=J/Wv9v3N+a+/UvvLlCl2hAvaQQpHgsSc+WTSkW3Mv6R6a6O2oOgl8diStoOnCPW7Enr8
	 Os4oZNkpP4UquI5kG9RNu+YwL//ZTnPodB27awVK9pEZO1837ax6vf19zYLT29BC/Xyup
	 ts65jylpOGEH2iXq4pWWZz2+cWWx1pxroX65sPuUIC3U/Ns7EshYB4TD5Rv2wQwaCMnu5
	 OtZ1O0cmk1Jzfa7W/upeq0paosjTF/iBtDHZEEX97K1LJQ/CorIliMHkbjqQ3nLDnKAPc
	 l5/kgMGW0lrsCDxykHqriS5tm7db00XykVrFJeXCeDZCBq1EYznxvnJDgXpdB5eayzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792703775;
	h=Received:DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version:
	 Content-Type:Content-Disposition;
	bh=ULiUyno5q/1ByPzV5Oc12QZ9vof4bDO1Z38qpJk8WTc=;
	b=4FtjvGXJI/Xqm/E7PuNoUH/eKuKCYh52w66G2V1sxmyTK8HuuxpcnqwOWvp9wXMwyqA0
	 34GM/9qoeTQBVvkSiY+fvrqsKOFfI+uNxDKNAGmxFLNOZI1zrHfwsGTtsdjNzlAqRVOKj
	 Bf3EVIOlY1kKz9jf58DEhvc8E1YlgwH8HBVU16OzvzlO1Yczz538iuWrtPnmobRL6FTr8
	 0YdqyxC5Z+gecIh6nBUqM9fclAzQnbj+w52NdKUZw/Ut0NkjkW5ftpS3lEQJwRStw65aU
	 1b0qJDPvkw0W4RHGKkNfkcCYc8mDzFQZgx4oVOelHiK/vE3pkvkAWzas4sVPFS6rh6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ncc1etqj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0667606A319;
	Thu, 22 Oct 2026 21:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ncc1etqj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DD8A1F01825;
	Thu, 22 Oct 2026 21:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792703774;
	bh=ULiUyno5q/1ByPzV5Oc12QZ9vof4bDO1Z38qpJk8WTc=;
	h=Date:From:To:Subject;
	b=Ncc1etqjoKYP2taNTsSlTYum2oye1Y8LhmHqk/IxJTZAbTUGi+NCXEr1v5ul3JyY7
	 7vu3wug+MiFHEvZ0PKAC/hIgXQkuCrlW538sI7RM92Cs5adswCD/D1CeXrG1Nq0V/0
	 fTUvSJmEsXh4dtWAaW647MnHqPD+sjx/xBYgg5HbzCxlylMfPA8k/05qm+WqBLSeJQ
	 LfxfIQuy3q+xBmqjTuYO+JI5deozTOXh5TbU3W/SPQn9Q84mV+4KcKjO0KZP6vG4rR
	 vnPI37JaSAtT/hisAX2BZm+sa3Lf/TsnGwvumk9sPF/VzvgpTNvrKJ5HPhQUOBZq2N
	 ij2ZH0WUsvxCQ==
Date: Thu, 22 Oct 2026 23:16:10 +0200
From: Helge Deller <deller@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [GIT PULL] fbdev fixes and updates for v7.4-rc1
Message-ID: <atp9GlM3gE8uF0xo@carbonx1>
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Dear Linus,

please pull the first bunch of fbdev fixes and cleanups for kernel v7.4-rc1:

A whole lot of small fixes all over many drivers, but the majority of changes
are related to code cleanups regarding the cursor handling in vt and fbcon.

Thanks!
Helge

----------------------------------------------------------------
The following changes since commit 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907:

  Linux 7.3-rc7 (2026-10-11 20:04:55 -0700)

are available in the Git repository at:

  http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-7.4-rc1

for you to fetch changes up to 61e1a43ca5825acb137a10ac7d52746632bfb124:

  fbdev: xilinxfb: Use FB blanking constants (2026-10-20 22:36:14 +0200)

----------------------------------------------------------------
fbdev fixes and cleanups for 7.4-rc1:

Fixes:
- core: initialize modelist in framebuffer_alloc()
- core: bitblit: fix glyph clipping when fbcon pans
- fbcon: restore font geometry if font rotation fails
- sh_mobile_lcdcfb: restore the per-overlay sysfs attributes
- udlfb: don't rebuild the mode list while the framebuffer is in use
- atmel_lcdfb: prevent FIFO work after removal

Cleanups:
- vt, fbcon, vgacon: cursor code rework & cleanups
- MAINTAINERS: name the deller/linux-fbdev for-next branch
- drop unused FB_IOMEM_HELPERS_DEFERRED Kconfig option
- acornfb: remove unused code
- atafb: fix sparse warnings and avoid casts
- sstfb: use managed PCI device enable
- gxt4500, kyro, nvidia: release write-combining handle on probe failure
- various drivers: typo fixes in comments
- various drivers: fix error path on fb_deferred_io_init() failure
- various drivers: use FB blanking constants instead of VESA constants

----------------------------------------------------------------
Andrey Misiurov (1):
      fbdev: core: Initialize modelist in framebuffer_alloc()

Ethan Nelson-Moore (1):
      fbdev: acornfb: remove unused code for 26-bit hardware

Helge Deller (3):
      fbdev: Drop unused FB_IOMEM_HELPERS_DEFERRED Kconfig option
      fbdev: atafb: fix sparse warnings
      fbdev: atafb: avoid cast when assigning buffer address pointer

Hemanth Selam (20):
      fbdev: s1d13xxxfb: fix typos in comments
      fbdev: sticore: fix typos in comments
      fbdev: viafb: fix typos in comments
      fbdev: sstfb: fix typos in comments
      fbdev: tgafb: fix typos in comments
      fbdev: tridentfb: fix typos in comments
      fbdev: mmp: fix typos in comments
      fbdev: au1100fb: fix typos in comments
      fbdev: efifb: fix typos in comments
      fbdev: grvga: fix typos in comments
      fbdev: kyro: fix typos in comments
      fbdev: maxinefb: fix typos in comments
      fbdev: pm2fb: fix typos in comments
      fbdev: skeletonfb: fix typos in comments
      fbdev: ocfb: fix typos in comments
      fbdev: omap2fb: fix typos in comments
      fbdev: radeonfb: fix typos in comments
      fbdev: mach64: fix typos in comments
      fbdev: aty128fb: fix typos in comments
      fbdev: atyfb_base: fix typos in comments

Karl Mehltretter (1):
      fbdev: sh_mobile_lcdcfb: Restore the per-overlay sysfs attributes

Lorenzo Stoakes (ARM) (6):
      fbdev: ssd1307fb: check for fb_deferred_io_init() error
      fbdev: xen-fbfront: check for fb_deferred_io_init() error
      HID: picoLCD: check for fb_deferred_io_init() error
      fbdev: udlfb: check for fb_deferred_io_init() error
      fbdev: smscufx: check for fb_deferred_io_init() error
      fbdev: sh_mobile_lcdc: check for fb_deferred_io_init() error

Matthias Goergens (1):
      MAINTAINERS: name the deller/linux-fbdev for-next branch

Myeonghun Pak (4):
      fbdev: gxt4500: Release WC setup on probe failure
      fbdev: kyro: Release WC setup on registration failure
      fbdev: nvidia: Release write-combining handle on probe failure
      fbdev: sstfb: use managed PCI device enable

Thomas Zimmermann (10):
      vt: Add cursor-size helpers
      vgacon: Remove trailing whitespaces
      vgacon: Use vt_cursor_{start,end}()
      lib/fonts: Add font_glyph_cursor() helper
      fbcon: Replace fbcon_fill_cursor_mask() with fbcon_cursor_glyph()
      fbdev: au1100fb: Use FB blanking constants
      fbdev: i810fb: Use FB blanking constants
      fbdev: sa1100fb: Remove comment on VESA DPMS modes
      fbdev: platinumfb: Use FB blanking constants
      fbdev: xilinxfb: Use FB blanking constants

Tingjie Zhong (1):
      fbdev: bitblit: Fix glyph clipping when fbcon pans

Xiang Mei (1):
      fbdev: udlfb: don't rebuild the mode list while the framebuffer is in use

Yao Yiqi (3):
      fbcon: Include font geometry in the rotated font cache
      fbcon: Rebuild rotated font buffer on font change
      fbcon: Retry rotated font allocation after failure

Yibo Tan (1):
      fbdev: atmel_lcdfb: Prevent FIFO work after removal

 MAINTAINERS                                     |   2 +-
 drivers/hid/hid-picolcd_fb.c                    |  12 ++-
 drivers/tty/vt/vt.c                             | 114 ++++++++++++++++++++++++
 drivers/video/console/vgacon.c                  |  43 +++------
 drivers/video/fbdev/acornfb.c                   |  57 +++---------
 drivers/video/fbdev/acornfb.h                   |   9 +-
 drivers/video/fbdev/atafb.c                     |  28 +-----
 drivers/video/fbdev/atmel_lcdfb.c               |  11 ++-
 drivers/video/fbdev/aty/aty128fb.c              |   2 +-
 drivers/video/fbdev/aty/atyfb_base.c            |   4 +-
 drivers/video/fbdev/aty/mach64_cursor.c         |   2 +-
 drivers/video/fbdev/aty/radeon_base.c           |   4 +-
 drivers/video/fbdev/aty/radeon_monitor.c        |   4 +-
 drivers/video/fbdev/aty/radeonfb.h              |   2 +-
 drivers/video/fbdev/au1100fb.c                  |  20 ++---
 drivers/video/fbdev/core/Kconfig                |   6 --
 drivers/video/fbdev/core/bitblit.c              |  10 ++-
 drivers/video/fbdev/core/fb_info.c              |   1 +
 drivers/video/fbdev/core/fbcon.c                |  91 ++++++++++++-------
 drivers/video/fbdev/core/fbcon.h                |  21 +++--
 drivers/video/fbdev/core/fbcon_ccw.c            |   3 +-
 drivers/video/fbdev/core/fbcon_cw.c             |   3 +-
 drivers/video/fbdev/core/fbcon_rotate.c         |  10 ++-
 drivers/video/fbdev/core/fbcon_ud.c             |   3 +-
 drivers/video/fbdev/efifb.c                     |   4 +-
 drivers/video/fbdev/grvga.c                     |   2 +-
 drivers/video/fbdev/gxt4500.c                   |   1 +
 drivers/video/fbdev/i810/i810_main.c            |   2 +-
 drivers/video/fbdev/kyro/STG4000OverlayDevice.c |   2 +-
 drivers/video/fbdev/kyro/fbdev.c                |   4 +-
 drivers/video/fbdev/maxinefb.c                  |   2 +-
 drivers/video/fbdev/mmp/core.c                  |   2 +-
 drivers/video/fbdev/mmp/hw/mmp_ctrl.c           |   4 +-
 drivers/video/fbdev/mmp/hw/mmp_ctrl.h           |   4 +-
 drivers/video/fbdev/mmp/hw/mmp_spi.c            |   2 +-
 drivers/video/fbdev/nvidia/nvidia.c             |   1 +
 drivers/video/fbdev/ocfb.c                      |   2 +-
 drivers/video/fbdev/omap2/omapfb/dss/dispc.c    |   4 +-
 drivers/video/fbdev/platinumfb.c                |   8 +-
 drivers/video/fbdev/pm2fb.c                     |   2 +-
 drivers/video/fbdev/s1d13xxxfb.c                |   6 +-
 drivers/video/fbdev/sa1100fb.c                  |  29 ------
 drivers/video/fbdev/sh_mobile_lcdcfb.c          |  45 ++++++----
 drivers/video/fbdev/skeletonfb.c                |   6 +-
 drivers/video/fbdev/smscufx.c                   |   9 +-
 drivers/video/fbdev/ssd1307fb.c                 |   6 +-
 drivers/video/fbdev/sstfb.c                     |   5 +-
 drivers/video/fbdev/tgafb.c                     |   6 +-
 drivers/video/fbdev/tridentfb.c                 |   2 +-
 drivers/video/fbdev/udlfb.c                     |  14 ++-
 drivers/video/fbdev/via/dvi.c                   |   6 +-
 drivers/video/fbdev/via/hw.c                    |   2 +-
 drivers/video/fbdev/via/viafbdev.c              |   4 +-
 drivers/video/fbdev/xen-fbfront.c               |   7 +-
 drivers/video/fbdev/xilinxfb.c                  |   2 +-
 drivers/video/sticore.c                         |   2 +-
 include/linux/console_struct.h                  |   8 ++
 include/linux/font.h                            |   4 +
 include/video/mmp_disp.h                        |   6 +-
 lib/fonts/Makefile                              |   3 +-
 lib/fonts/font_cursor.c                         |  56 ++++++++++++
 61 files changed, 444 insertions(+), 292 deletions(-)
 create mode 100644 lib/fonts/font_cursor.c
