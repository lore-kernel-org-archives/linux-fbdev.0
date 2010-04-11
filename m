From: <martin@ti.com>
Date: Sun, 11 Apr 2010 17:34:14 +0000
Subject: [Resubmit: PATCH v3 0/1] DA8XX/OMAP-L1XX: FB: Implement double buffering
Message-Id: <1271007255-3401-1-git-send-email-martin@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Martin Ambrose <martin@ti.com>

Changes from v2 patch set:
        . Fixed register clear sequence in isr to avoid spurious interrupt.
        . Removed unused wait queue variable in wait_for_vsync().
        . Moved initialization of vsync_wait prior to register_framebuffer.
  

 drivers/video/da8xx-fb.c |  301 +++++++++++++++++++++++++++++++++++----------
 include/video/da8xx-fb.h |    1 +
 2 files changed, 235 insertions(+), 67 deletions(-)

