From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 03 Dec 2010 07:49:58 +0000
Subject: [GIT PULL] fbdev updates for 2.6.37-rc5
Message-Id: <20101203074958.GA1602@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Please pull from:

	master.kernel.org:/pub/scm/linux/kernel/git/lethal/fbdev-2.6.git fbdev-fixes-for-linus

Which contains:

Caglar Akyuz (1):
      video: da8xx: Register IRQ as last thing in driver probing.

Daniel Drake (1):
      lxfb: Maintain video processor palette through suspend/resume

Randy Dunlap (1):
      framebuffer: fix fbcmap.c kernel-doc warning

 drivers/video/da8xx-fb.c       |   14 ++++++--------
 drivers/video/fbcmap.c         |    1 +
 drivers/video/geode/lxfb.h     |    4 +++-
 drivers/video/geode/lxfb_ops.c |   20 +++++++++++++++-----
 4 files changed, 25 insertions(+), 14 deletions(-)
