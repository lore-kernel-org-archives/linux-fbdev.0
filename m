From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Tue, 21 Apr 2015 20:20:30 +0000
Subject: [PATCH v3 0/4] pci: add and use pci_ioremap_wc_bar()
Message-Id: <1429647634-17169-1-git-send-email-mcgrof@do-not-panic.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: cocci@systeme.lip6.fr

From: "Luis R. Rodriguez" <mcgrof@suse.com>

This series adds pci_ioremap_wc_bar() and makes use of it
on a few framebuffer device drivers.

Luis R. Rodriguez (4):
  pci: add pci_ioremap_wc_bar()
  video: fbdev: i740fb: use arch_phys_wc_add() and pci_ioremap_wc_bar()
  video: fbdev: kyrofb: use arch_phys_wc_add() and pci_ioremap_wc_bar()
  video: fbdev: gxt4500: use pci_ioremap_wc_bar() for framebuffer

 drivers/pci/pci.c                | 14 ++++++++++++++
 drivers/video/fbdev/gxt4500.c    |  2 +-
 drivers/video/fbdev/i740fb.c     | 35 ++++++-----------------------------
 drivers/video/fbdev/kyro/fbdev.c | 33 +++++++++++----------------------
 include/linux/pci.h              |  1 +
 include/video/kyro.h             |  4 +---
 6 files changed, 34 insertions(+), 55 deletions(-)

-- 
2.3.2.209.gd67f9d5.dirty

