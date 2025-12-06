Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D3D3BB40;
	Sat,  6 Dec 2025 20:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765053729; cv=none; b=gnqPh7VVuwZGQXYlj+Oz8uMQQJGtdQivcAcYpCpIE/pXsC8W0431Zld3qpM9oxjQ7PCgjOSjmGHrf7zBHy7YUaYi46fb/PMwTT0SDOdTs4HX/2N2DDZK9wZ1lsAyqg4z6sZx5B/Iwz6SWWpMynvP7KbDOyhBjFh6+pNGrXnVQzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765053729; c=relaxed/simple;
	bh=7BwMILfJJsFt2vaY2BPn7ViYStQSseiZUe5ZM2MrxHo=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=iCdnuk6B/Uvg6AwT5PhNKL6P41Fo7KKi4lauJnvFKc2ahlu7icGGNzWJiFPoIYP69TZ1AuoZyl9mJvUteFEguLj8kb4Z83rFY+zzlxDjl1ZXE8ospc9y/SqqGn/+EeM6hsR40xbfg8sSDFeHIxmA7VzryZQUoMhMnfBVNiMwhks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X1wr3kCF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1wr3kCF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD8CDC4CEF5;
	Sat,  6 Dec 2025 20:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765053725;
	bh=7BwMILfJJsFt2vaY2BPn7ViYStQSseiZUe5ZM2MrxHo=;
	h=Date:From:To:Subject:From;
	b=X1wr3kCFC7R+Syd8e3ZeNe7lojSfIaEzZKZwohvCFxyLDEu0j8X9FuNSZfMjnz2lp
	 G++KvFZd4pV9iRIu/6diADTAIeXldKQ2AYl2trCJLju185GzXqGdwYnkeAUdi9Y+9d
	 4Ag+8PFjVz9tlQ2RXUln8loiDTJhnlDVqKv0+kG0NgYEZl3PRyRg1+laC5SLeG+N1y
	 72dS9/51EbXZg69QJ7mfUC+gajjHA9nPCU3NbIpPyId+P6ApYBR4C13EWAymqB8IwU
	 sTUuCZK+aNJ9t0EIzAVxZxCBqaL6D/yEnbYN1NDM9S0pD78yKICoj65laVs/jjzpGE
	 d3eJLClmb6Whg==
Date: Sat, 6 Dec 2025 21:42:00 +0100
From: Helge Deller <deller@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [GIT PULL] fbdev fixes for v6.19-rc1
Message-ID: <aTSVGN47DAA1AvGH@carbonx1>
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

please pull the updates for fbdev for 6.19-rc1.

The Termius 10x18 console bitmap font has been added. It is good suited for
modern 13-16 inch laptop displays with resolutions like 1280x800 and 1440x900
pixels.

The gbefb and tcx.c drivers got some fixes to restore X11 support, pxafb was
not actually clamping input values and the ssd1307fb driver leaked memory in
the failure path. 

The other patches convert some common drivers to use dev_info() and dev_dbg()
instead of printk().

Thanks!
Helge

----------------------------------------------------------------
The following changes since commit e9a6fb0bcdd7609be6969112f3fbfcce3b1d4a7c:

  Linux 6.18-rc5 (2025-11-09 15:10:19 -0800)

are available in the Git repository at:

  http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-6.19-rc1

for you to fetch changes up to 164312662ae9764b83b84d97afb25c42eb2be473:

  fbdev: ssd1307fb: fix potential page leak in ssd1307fb_probe() (2025-12-05 11:29:14 +0100)

----------------------------------------------------------------
fbdev fixes & enhancements for 6.19-rc1:

Framework updates:
- fonts: Add Terminus 10x18 console font [Neilay Kharwadkar]

Driver fixes:
- gbefb: fix to use physical address instead of dma address [René Rebe]
- tcx.c fix mem_map to correct smem_start offset [René Rebe]
- pxafb: Fix multiple clamped values in pxafb_adjust_timing [Thorsten Blum]
- ssd1307fb: fix potential page leak in ssd1307fb_probe() [Abdun Nihaal]

Cleanups:
- vga16fb: Request memory region [Javier Garcia]
- vga16fb: replace printk() with dev_*() in probe [Vivek BalachandharTN]
- vesafb, gxt4500fb, tridentfb: Use dev_dbg() instead of printk() [Javier Garcia]
- i810: use dev_info() [Shi Hao]

----------------------------------------------------------------
Abdun Nihaal (1):
      fbdev: ssd1307fb: fix potential page leak in ssd1307fb_probe()

Javier Garcia (4):
      fbdev: vga16fb: Request memory region
      fbdev: vesafb: Use dev_* fn's instead printk
      fbdev: gxt4500fb: Use dev_err instead of printk
      fbdev: tridentfb: replace printk() with dev_*() in probe

Neilay Kharwadkar (1):
      lib/fonts: Add Terminus 10x18 console font

Rene Rebe (1):
      fbdev: gbefb: fix to use physical address instead of dma address

René Rebe (1):
      fbdev: tcx.c fix mem_map to correct smem_start offset

Shi Hao (1):
      fbdev: i810: use appopriate log interface dev_info

Thorsten Blum (1):
      fbdev: pxafb: Fix multiple clamped values in pxafb_adjust_timing

Vivek BalachandharTN (1):
      fbdev: vga16fb: replace printk() with dev_*() in probe

 drivers/video/fbdev/gbefb.c          |    5 +-
 drivers/video/fbdev/gxt4500.c        |    2 +-
 drivers/video/fbdev/i810/i810_main.c |   46 +-
 drivers/video/fbdev/pxafb.c          |   12 +-
 drivers/video/fbdev/ssd1307fb.c      |    4 +-
 drivers/video/fbdev/tcx.c            |    2 +-
 drivers/video/fbdev/tridentfb.c      |    4 +-
 drivers/video/fbdev/vesafb.c         |   29 +-
 drivers/video/fbdev/vga16fb.c        |   21 +-
 include/linux/font.h                 |    4 +-
 lib/fonts/Kconfig                    |   12 +
 lib/fonts/Makefile                   |    1 +
 lib/fonts/font_ter10x18.c            | 5143 ++++++++++++++++++++++++++++++++++
 lib/fonts/fonts.c                    |    3 +
 14 files changed, 5231 insertions(+), 57 deletions(-)
 create mode 100644 lib/fonts/font_ter10x18.c
