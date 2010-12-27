From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 27 Dec 2010 14:20:46 +0000
Subject: [GIT PULL] fbdev updates for 2.6.37-rc8
Message-Id: <20101227142046.GD16946@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

This is a fairly straightforward set of bugfixes and regression fixes.

When the SH-Mobile driver underwent some rework the userspace-facing var
info ceased propagating accurate mode information to userspace tools,
which is now corrected. A further patch for the LCDC fixes up bounding
for invalid mode settings that was triggered on older platforms, which
previously had a working fbcon but broken application interface.

Please pull from:

	master.kernel.org:/pub/scm/linux/kernel/git/lethal/fbdev-2.6.git fbdev-fixes-for-linus

Which contains:

Dave Airlie (1):
      fb: fix overlapping test off-by-one.

Fabio Estevam (1):
      video: imxfb: Fix the maximum value for yres

Guennadi Liakhovetski (3):
      fbdev: sh-mobile: restore display size configuration
      fbdev: sh-mobile: retrieve and propagate display sizes from EDID
      fbdev: sh_mobile_lcdc: increase maximum framebuffer size to support 1080p

 drivers/video/fbmem.c            |    2 +-
 drivers/video/imxfb.c            |    9 +++------
 drivers/video/sh_mobile_hdmi.c   |   16 +++++++++++++---
 drivers/video/sh_mobile_lcdcfb.c |   30 +++++++++++-------------------
 4 files changed, 28 insertions(+), 29 deletions(-)
