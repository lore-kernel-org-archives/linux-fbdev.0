From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 20 Dec 2010 16:14:18 +0000
Subject: [GIT PULL] fbdev updates for 2.6.37-rc7
Message-Id: <20101220161418.GG26766@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Please pull from:

	master.kernel.org:/pub/scm/linux/kernel/git/lethal/fbdev-2.6.git fbdev-fixes-for-linus

Which contains:

Tomi Valkeinen (2):
      OMAP: DSS: VRAM: Align start & size of vram to 2M
      OMAP: OMAPFB: disable old omapfb for OMAP4 builds

 drivers/video/omap/Kconfig |    4 ++--
 drivers/video/omap2/vram.c |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)
