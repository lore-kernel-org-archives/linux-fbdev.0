From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Wed, 29 Apr 2015 21:36:07 +0000
Subject: [PATCH v4 0/5] pci/devres: add and use pci_iomap_wc() and pcim_iomap_wc()
Message-Id: <1430343372-687-1-git-send-email-mcgrof@do-not-panic.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: bhelgaas@google.com, mst@redhat.com, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, airlied@linux.ie, daniel.vetter@intel.com
Cc: linux-fbdev@vger.kernel.org, luto@amacapital.net, cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org, "Luis R. Rodriguez" <mcgrof@suse.com>

From: "Luis R. Rodriguez" <mcgrof@suse.com>

This series adds pci_iomap_wc() and the respective devm helper pcim_iomap_wc().

Luis R. Rodriguez (5):
  pci: add pci_iomap_wc() variants
  lib: devres: add pcim_iomap_wc() variants
  video: fbdev: arkfb: use arch_phys_wc_add() and pci_iomap_wc()
  video: fbdev: s3fb: use arch_phys_wc_add() and pci_iomap_wc()
  video: fbdev: vt8623fb: use arch_phys_wc_add() and pci_iomap_wc()

 drivers/video/fbdev/arkfb.c     | 36 +++----------------
 drivers/video/fbdev/s3fb.c      | 35 ++++--------------
 drivers/video/fbdev/vt8623fb.c  | 31 ++++------------
 include/asm-generic/pci_iomap.h | 14 ++++++++
 include/linux/pci.h             |  2 ++
 lib/devres.c                    | 78 +++++++++++++++++++++++++++++++++++++++++
 lib/pci_iomap.c                 | 61 ++++++++++++++++++++++++++++++++
 7 files changed, 172 insertions(+), 85 deletions(-)

-- 
2.3.2.209.gd67f9d5.dirty

