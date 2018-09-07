From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Date: Fri, 07 Sep 2018 17:47:08 +0000
Subject: [PATCH v2] fbdev: fix kerneldoc
Message-Id: <38ca9044455a33e398b45e0281643cc24da3c2fc.1536342224.git.mirq-linux@rere.qmqm.pl>
List-Id: <linux-fbdev.vger.kernel.org>
References: <0172c6973edcb3827244d5fc3d0970e6f1fddfd8.1536341619.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <0172c6973edcb3827244d5fc3d0970e6f1fddfd8.1536341619.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: dri-devel@lists.freedesktop.org
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

As noticed by kbuild test robot <lkp@intel.com>,
remove_conflicting_pci_framebuffers()'s second argument
is called res_id not resource_id. Fix this.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
* Against drm-misc-next, as that's where original patchset went to.

v2: include second occurrence of @resource_id

---
 drivers/video/fbdev/core/fbmem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 5ffadc8e681d..0da75c55660d 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1834,11 +1834,11 @@ EXPORT_SYMBOL(remove_conflicting_framebuffers);
 /**
  * remove_conflicting_pci_framebuffers - remove firmware-configured framebuffers for PCI devices
  * @pdev: PCI device
- * @resource_id: index of PCI BAR configuring framebuffer memory
+ * @res_id: index of PCI BAR configuring framebuffer memory
  * @name: requesting driver name
  *
  * This function removes framebuffer devices (eg. initialized by firmware)
- * using memory range configured for @pdev's BAR @resource_id.
+ * using memory range configured for @pdev's BAR @res_id.
  *
  * The function assumes that PCI device with shadowed ROM drives a primary
  * display and so kicks out vga16fb.
-- 
2.18.0
