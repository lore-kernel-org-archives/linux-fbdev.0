Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1FF2264CA;
	Sat, 14 Feb 2026 12:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771070803; cv=none; b=NS0Tq2OFBYIjM2r614bRIwYQd140cKIyllaOm6oLG/IOZ2Lm6+ID8/6+HLDxXA3pAVUVis5ESxIAwfx2y1o//xqHY2hRnEykGJ0MYnl099EodFkkV+3NQiTsFvmz4OOvUQKkwPhXpIpJwwDZyMNqaTX7Iy+BBGAKOTGBMlTBh4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771070803; c=relaxed/simple;
	bh=C+5N8wnofV6y0FnEdqg1HPPMkU9929stwxn37ACo5B4=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FiqaH/8t3wDOii6IDQNJ02PzsRdHEh4AiwKCb1vvY8mvfJIyWH874cUQo82sDSyu+Lp7bxN9Yo60AL0mpcF9XJk2FJD9642PQzVAZbbQxDFV8XgfFrsXM4NmzBKyLSHK3M9iN3HEZTub22LGw0xh9Kv86h3SZu2leIdh5FZrmME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tq2XbG6D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tq2XbG6D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2348DC16AAE;
	Sat, 14 Feb 2026 12:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771070803;
	bh=C+5N8wnofV6y0FnEdqg1HPPMkU9929stwxn37ACo5B4=;
	h=Date:From:To:Subject:From;
	b=tq2XbG6D87ELtiqmkwqJXbl3xF3lSuVjymOMqiWfroQBla6BG0SdvSM3bIR3evOmq
	 MaSnIpNYFVAqVpuGOh+n04fXwkUH5umtR6elMn6AkoA76Yp6wnARzRQTsNNlgup0Zz
	 w7Sa0ygx4TL/PdmIQMGpHAxPMi7QIeP4rJ4cvkoniovuocFD9s0MTE4NVF6SVWU13z
	 foUgcgGqNcxX982JgIZWilMZDWCgkeNRANJENtG7+uvnNfjZfe2bHJDzj2Aaunmhvv
	 dpg14VJgZ0f07laYepWcHnukJ3tcEg8ihImyIzDc3qI3yYXlaM9C79xrqDeo6MjPHx
	 wUad+HxeU6FbA==
Date: Sat, 14 Feb 2026 13:06:38 +0100
From: Helge Deller <deller@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [GIT PULL] fbdev fixes and updates for v7.0-rc1
Message-ID: <aZBlTsIwTzS0tqBD@carbonx1>
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

please pull fixes and updates for fbdev for kernel 7.0-rc1.

Thanks to patches from Vincent Mailhol it's now easily possible to replace the
framebuffer penguin boot logo with an own logo at compile time.

The hyperv framebuffer driver has been removed, since the hyperv DRM driver now
seems to provide equal functionality.

Various console_conditional_schedule() calls across the console drivers (fbcon,
printk, vt) have been removed since they don't seem to be necessary any longer.

All other patches are either fixes in au1100fb, au1200fb, ffb, rivafb,
vt8500lcdfb and of_display_timing, or minor cleanups in the fbcon and omapfb
drivers.

All patches have been in for-next for the last 4-12 days without issues, but I
had to rebase to solve a trivial merge conflict with your tree.

Thanks!
Helge

----------------------------------------------------------------

The following changes since commit 770aaedb461a055f79b971d538678942b6607894:

  Merge tag 'bootconfig-v7.0' of git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace (2026-02-13 19:33:39 -0800)

are available in the Git repository at:

  http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-7.0-rc1

for you to fetch changes up to a86039b76e5d1e886d42ec28f569a9ef76409750:

  fbcon: Declare struct fb_info.fbcon_par as of type struct fbcon_par (2026-02-14 11:09:47 +0100)

----------------------------------------------------------------
fbdev fixes & enhancements for 7.0-rc1:

New features:
- Allow custom fbdev boot logo [Vincent Mailhol]

Driver removal:
- fbdev: hyperv_fb: Remove hyperv_fb driver [Prasanna Kumar T S M]

Fixes:
- fbcon: check return value of con2fb_acquire_newinfo() [Andrey Vatoropin]
- fbdev: au1100fb: Check return value of clk_enable() in .resume() [Chen Ni]
- fbdev: au1200fb: Fix a memory leak in au1200fb_drv_probe() [Felix Gu]
- fbdev: ffb: fix corrupted video output on Sun FFB1 [René Rebe]
- fbdev: of_display_timing: Fix device node reference leak in of_get_display_timings() [Felix Gu]
- fbdev: of: display_timing: fix refcount leak in of_get_display_timings() [Weigang He]
- fbdev: rivafb: fix divide error in nv3_arb() [Guangshuo Li]
- fbdev: smscufx: properly copy ioctl memory to kernelspace [Greg Kroah-Hartman]
- fbdev: Use device_create_with_groups() to fix sysfs groups registration race [Hans de Goede]
- fbdev: vt8500lcdfb: fix missing dma_free_coherent() [Thomas Fourier]

Cleanups:
- fbcon: printk, vt: Remove console_conditional_schedule() [Sebastian Andrzej Siewior]
- fbcon: Declare struct fb_info.fbcon_par as of type struct fbcon_par [Thomas Zimmermann]
- fbcon: Remove struct fbcon_display.inverse [Thomas Zimmermann]
- fbdev: fix fb_pad_unaligned_buffer mask [Osama Abdelkader]
- fbdev: omapfb: remove duplicate check in omapfb_setup_mem() [Dan Carpenter]
- fbdev: omapfb, sh_mobile_lcdc, fbtft: Make FB_DEVICE dependency optional [Chintan Patel]

----------------------------------------------------------------
Andrey Vatoropin (1):
      fbcon: check return value of con2fb_acquire_newinfo()

Chen Ni (1):
      fbdev: au1100fb: Check return value of clk_enable() in .resume()

Chintan Patel (6):
      fb: Add dev_of_fbinfo() helper for optional sysfs support
      staging: fbtft: Make FB_DEVICE dependency optional
      fbdev: omapfb: Make FB_DEVICE dependency optional
      fbdev: sh_mobile_lcdc: Make FB_DEVICE dependency optional
      staging: fbtft: Fix build failure when CONFIG_FB_DEVICE=n
      staging: fbtft: Make framebuffer registration message debug-only

Dan Carpenter (1):
      fbdev: omapfb: remove duplicate check in omapfb_setup_mem()

Felix Gu (2):
      fbdev: of_display_timing: Fix device node reference leak in of_get_display_timings()
      fbdev: au1200fb: Fix a memory leak in au1200fb_drv_probe()

Greg Kroah-Hartman (1):
      fbdev: smscufx: properly copy ioctl memory to kernelspace

Guangshuo Li (1):
      fbdev: rivafb: fix divide error in nv3_arb()

Hans de Goede (1):
      fbdev: Use device_create_with_groups() to fix sysfs groups registration race

Osama Abdelkader (1):
      fbdev: fix fb_pad_unaligned_buffer mask

Prasanna Kumar T S M (3):
      fbdev: hyperv_fb: Remove hyperv_fb driver
      drivers: hv: vmbus_drv: Remove reference to hpyerv_fb
      drm/hyperv: Remove reference to hyperv_fb driver

René Rebe (1):
      fbdev: ffb: fix corrupted video output on Sun FFB1

Sebastian Andrzej Siewior (1):
      printk, vt, fbcon: Remove console_conditional_schedule()

Thomas Fourier (1):
      fbdev: vt8500lcdfb: fix missing dma_free_coherent()

Thomas Zimmermann (2):
      fbcon: Remove struct fbcon_display.inverse
      fbcon: Declare struct fb_info.fbcon_par as of type struct fbcon_par

Vincent Mailhol (8):
      video/logo: remove orphan .pgm Makefile rule
      video/logo: add a type parameter to the logo makefile function
      video/logo: allow custom logo
      newport_con: depend on LOGO_LINUX_CLUT224 instead of LOGO_SGI_CLUT224
      sh: defconfig: remove CONFIG_LOGO_SUPERH_*
      video/logo: remove logo_mac_clut224
      video/logo: move logo selection logic to Kconfig
      video/logo: don't select LOGO_LINUX_MONO and LOGO_LINUX_VGA16 by default

Weigang He (1):
      fbdev: of: display_timing: fix refcount leak in of_get_display_timings()

 MAINTAINERS                                     |   10 -
 arch/sh/configs/dreamcast_defconfig             |    2 -
 arch/sh/configs/ecovec24_defconfig              |    2 -
 arch/sh/configs/kfr2r09_defconfig               |    2 -
 arch/sh/configs/migor_defconfig                 |    2 -
 arch/sh/configs/rts7751r2d1_defconfig           |    2 -
 arch/sh/configs/rts7751r2dplus_defconfig        |    2 -
 arch/sh/configs/se7724_defconfig                |    2 -
 arch/sh/configs/se7780_defconfig                |    2 -
 arch/sh/configs/sh7785lcr_defconfig             |    3 -
 arch/sh/configs/urquell_defconfig               |    3 -
 drivers/gpu/drm/Kconfig                         |  146 +++
 drivers/gpu/drm/hyperv/hyperv_drm_proto.c       |   15 +-
 drivers/hv/vmbus_drv.c                          |    4 +-
 drivers/staging/fbtft/Kconfig                   |    5 +-
 drivers/staging/fbtft/fbtft-core.c              |   19 +-
 drivers/staging/fbtft/fbtft-sysfs.c             |   20 +-
 drivers/tty/vt/vt.c                             |    1 -
 drivers/video/console/newport_con.c             |    4 +-
 drivers/video/fbdev/Kconfig                     |   11 -
 drivers/video/fbdev/Makefile                    |    1 -
 drivers/video/fbdev/au1100fb.c                  |    5 +-
 drivers/video/fbdev/au1200fb.c                  |    6 +-
 drivers/video/fbdev/core/fbcon.c                |    9 +-
 drivers/video/fbdev/core/fbcon.h                |    1 -
 drivers/video/fbdev/core/fbmem.c                |    2 +-
 drivers/video/fbdev/core/fbsysfs.c              |   36 +-
 drivers/video/fbdev/ffb.c                       |   14 +-
 drivers/video/fbdev/hyperv_fb.c                 | 1388 --------------------
 drivers/video/fbdev/omap/omapfb_main.c          |   10 +-
 drivers/video/fbdev/omap2/omapfb/Kconfig        |    3 +-
 drivers/video/fbdev/omap2/omapfb/omapfb-sysfs.c |   18 +-
 drivers/video/fbdev/riva/riva_hw.c              |    3 +
 drivers/video/fbdev/sh_mobile_lcdcfb.c          |    5 +-
 drivers/video/fbdev/smscufx.c                   |    8 +-
 drivers/video/fbdev/vt8500lcdfb.c               |    5 +-
 drivers/video/logo/Kconfig                      |   82 +-
 drivers/video/logo/Makefile                     |   29 +-
 drivers/video/logo/logo.c                       |   46 +-
 drivers/video/logo/logo_mac_clut224.ppm         | 1604 -----------------------
 drivers/video/of_display_timing.c               |   10 +-
 include/linux/console.h                         |    1 -
 include/linux/fb.h                              |   13 +-
 include/linux/linux_logo.h                      |    8 -
 kernel/printk/printk.c                          |   16 -
 45 files changed, 324 insertions(+), 3256 deletions(-)
 delete mode 100644 drivers/video/fbdev/hyperv_fb.c
 delete mode 100644 drivers/video/logo/logo_mac_clut224.ppm
