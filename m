Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C611F463F;
	Sat,  2 Aug 2025 11:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754132668; cv=none; b=RCMdCCUAQ6aXN5NBR/ZLXxJJeUBwtZPrqI4kAtPFmRV0+oVjdiCaYW4BPp5c9fnjOuSVkGPgPCh17EcxsHLnwVJSjEe7BefSNKHAGaq8omdMtCVJIb7uADAyil30PunXO3VVSzFbEke5ki8Nvo1Nyaj6POVvwZV3QJmuaW+p2uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754132668; c=relaxed/simple;
	bh=RvvqUhC+UfRuk8J9nsZJ+DKXPVlzN7atw9EhZE6QMJw=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=m4pvuqJxFUxhRQoY1m/0uvdfPP/Gmaxy1JOSPRU/ZExz3iGIPrSzrdHJHG4sqBdbc8ptmtzIrmFl0KvUBgeULsEbktkE/Q2T38imdDxsFYN6XDpJ2w41ZkaJzza4ka4bfJucgIO0fP1JhGvcAi0rz/CdZnxy7NkgMO8c1sgoN48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PnZWtb5L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PnZWtb5L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13482C4CEEF;
	Sat,  2 Aug 2025 11:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754132668;
	bh=RvvqUhC+UfRuk8J9nsZJ+DKXPVlzN7atw9EhZE6QMJw=;
	h=Date:From:To:Subject:From;
	b=PnZWtb5LE5Glzfcx4zWnTCqAenMhae+/2K0T1CyS92hPJQAbZXL2jBBMMvSTn5FM1
	 G+emXgVw86A82LWcGr0YoAsZ6ZBUFkWkA2VpaTvEYbA+/Xe0gjaelIlmb7kzhLrA6K
	 rwQ334VrvLrKS+y3tY3GqkcfRaYBZQPA0lg9vFVUPuoXYm/IeY4bV56uFEBcsPXgJh
	 +WoIvXhy0s3jfgw3EZdLDOHRzmGQhw20/xdxu9mc3zBIHhbFDWRXhlVw7pr7EyxRRy
	 iBvTBzCJdN5oEEVeqBqiMLVlWZQgU699hp4du287lXtHmt5K8IDZjuUIN1oB0AruyM
	 C+JFV15uDL7yQ==
Date: Sat, 2 Aug 2025 13:04:24 +0200
From: Helge Deller <deller@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [GIT PULL] fbdev fixes and updates for v6.17-rc1
Message-ID: <aI3wuBNWPyKhHbnC@p100>
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

please pull the fbdev fixes and updates for 6.17-rc1:

One potential buffer overflow fix in the framebuffer registration function,
some fixes for the imxfb, nvidiafb and simplefb drivers, and a bunch of
cleanups for fbcon, kyrofb and svgalib.

Thanks,
Helge

----------------------------------------------------------------
The following changes since commit 89be9a83ccf1f88522317ce02f854f30d6115c41:

  Linux 6.16-rc7 (2025-07-20 15:18:33 -0700)

are available in the Git repository at:

  http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-6.17-rc1

for you to fetch changes up to 81b96e4aef9592493873507eec52eca68f0721ac:

  fbcon: Use 'bool' where appopriate (2025-07-27 19:56:52 +0200)

----------------------------------------------------------------
fbdev fixes and cleanups for 6.17-rc1:

Framework fixes:
- fix potential buffer overflow in do_register_framebuffer() [Yongzhen Zhang]

Driver fixes:
- imxfb: prevent null-ptr-deref [Chenyuan Yang]
- nvidiafb: fix build on 32-bit ARCH=um [Johannes Berg]
- nvidiafb: add depends on HAS_IOPORT [Randy Dunlap]
- simplefb: Use of_reserved_mem_region_to_resource() for "memory-region" [Rob Herring]

Cleanups:
- fbcon: various code cleanups wrt blinking [Ville Syrjälä]
- kyrofb: Convert to devm_*() functions [Giovanni Di Santi]
- svgalib: Coding style cleanups [Darshan R.]
- Fix typo in Kconfig text for FB_DEVICE [Daniel Palmer]

----------------------------------------------------------------
Chenyuan Yang (1):
      fbdev: imxfb: Check fb_add_videomode to prevent null-ptr-deref

Daniel Palmer (1):
      fbdev: Fix typo in Kconfig text for FB_DEVICE

Darshan R. (1):
      fbdev: svgalib: Clean up coding style

Giovanni Di Santi (3):
      fbdev: kyro: Add missing PCI memory region request
      fbdev: kyro: Use devm_ioremap() for mmio registers
      fbdev: kyro: Use devm_ioremap_wc() for screen mem

Johannes Berg (1):
      fbdev: nvidiafb: fix build on 32-bit ARCH=um

Randy Dunlap (1):
      fbdev: nvidiafb: add depends on HAS_IOPORT

Rob Herring (Arm) (1):
      fbdev: simplefb: Use of_reserved_mem_region_to_resource() for "memory-region"

Ville Syrjälä (4):
      fbcon: fbcon_cursor_noblink -> fbcon_cursor_blink
      fbcon: fbcon_is_inactive() -> fbcon_is_active()
      fbcon: Introduce get_{fg,bg}_color()
      fbcon: Use 'bool' where appopriate

Yongzhen Zhang (1):
      fbdev: fix potential buffer overflow in do_register_framebuffer()

 drivers/video/fbdev/Kconfig           |  2 +-
 drivers/video/fbdev/core/Kconfig      |  2 +-
 drivers/video/fbdev/core/fbcon.c      | 77 ++++++++++++++++------------
 drivers/video/fbdev/core/fbmem.c      |  3 ++
 drivers/video/fbdev/core/svgalib.c    | 95 ++++++++++++++++-------------------
 drivers/video/fbdev/imxfb.c           |  9 +++-
 drivers/video/fbdev/kyro/fbdev.c      | 24 ++++-----
 drivers/video/fbdev/nvidia/nv_local.h |  2 +-
 drivers/video/fbdev/simplefb.c        | 17 ++-----
 9 files changed, 116 insertions(+), 115 deletions(-)
