From: Manuel Lauss <manuel.lauss@googlemail.com>
Date: Fri, 02 Sep 2011 14:40:45 +0000
Subject: [PATCH 0/6] fbdev: au1200fb updates
Message-Id: <1314974451-8535-1-git-send-email-manuel.lauss@googlemail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This is a resend of 5 patches Paul Mundt previously added to the fbdev tree,
plus a new one to silence excessive dmesg output.  Please consider for 3.2.

Among other things, patch #2 fixes an annoying build failure with CONFIG_PM=y
which has been bugging Ralf Baechle (MIPS maintainer) for quite some time.

Run-tested on DB1200 and DB1300 evaluation boards.

Manuel Lauss (6):
  au1200fb: use framebuffer_alloc()
  au1200fb: fixup PM
  au1200fb: make number of windows configurable at load time.
  au1200fb: switch to FB_SYS helpers
  au1200fb: fix hardcoded IRQ
  fbdev: au1200fb: silence debug output

 drivers/video/Kconfig    |    7 +-
 drivers/video/au1200fb.c |  299 ++++++++++++++++++++--------------------------
 2 files changed, 136 insertions(+), 170 deletions(-)

-- 
1.7.6

