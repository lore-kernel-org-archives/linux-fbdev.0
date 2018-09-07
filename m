From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Date: Fri, 07 Sep 2018 17:35:15 +0000
Subject: [PATCH] fbdev: fix kerneldoc
Message-Id: <0172c6973edcb3827244d5fc3d0970e6f1fddfd8.1536341619.git.mirq-linux@rere.qmqm.pl>
List-Id: <linux-fbdev.vger.kernel.org>
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

* Against drm-misc-next, as this is the branch original patchset was
applied to.

---
 drivers/video/fbdev/core/fbmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 5ffadc8e681d..4a2193fe3bc3 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1834,7 +1834,7 @@ EXPORT_SYMBOL(remove_conflicting_framebuffers);
 /**
  * remove_conflicting_pci_framebuffers - remove firmware-configured framebuffers for PCI devices
  * @pdev: PCI device
- * @resource_id: index of PCI BAR configuring framebuffer memory
+ * @res_id: index of PCI BAR configuring framebuffer memory
  * @name: requesting driver name
  *
  * This function removes framebuffer devices (eg. initialized by firmware)
-- 
2.18.0
