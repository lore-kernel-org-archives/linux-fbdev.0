From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 21 Feb 2014 14:39:15 +0000
Subject: [PATCH] hyperv-fb: kick off efifb early
Message-Id: <1392993555-650-1-git-send-email-kraxel@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, kys@microsoft.com, haiyangz@microsoft.com, jasowang@redhat.com, Gerd Hoffmann <kraxel@redhat.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, "open list:Hyper-V CORE AND..." <devel@linuxdriverproject.org>

Remove firmware framebuffer before initializing hyperv-fb.  Needed
on gen2 virtual machines.   Letting register_framebuffer handle the
switchover results in efifb still being active while hyperv graphics
are initialized, which in turn can make the linux kernel hang.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/video/hyperv_fb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/hyperv_fb.c b/drivers/video/hyperv_fb.c
index f956cd9..3901ffe 100644
--- a/drivers/video/hyperv_fb.c
+++ b/drivers/video/hyperv_fb.c
@@ -683,6 +683,7 @@ static int hvfb_getmem(struct fb_info *info)
 		info->apertures->ranges[0].base = pci_resource_start(pdev, 0);
 		info->apertures->ranges[0].size = pci_resource_len(pdev, 0);
 	}
+	remove_conflicting_framebuffers(info->apertures, "hyperv-fb", false);
 
 	info->fix.smem_start = par->mem.start;
 	info->fix.smem_len = screen_fb_size;
-- 
1.8.3.1

