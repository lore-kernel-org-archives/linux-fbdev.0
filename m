From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Fri, 20 Mar 2015 23:18:35 +0000
Subject: [PATCH v1 45/47] video: fbdev: geode gxfb: use ioremap_wc() for framebuffer
Message-Id: <1426893517-2511-46-git-send-email-mcgrof@do-not-panic.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426893517-2511-1-git-send-email-mcgrof@do-not-panic.com>
In-Reply-To: <1426893517-2511-1-git-send-email-mcgrof@do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: luto@amacapital.net, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, jgross@suse.com, JBeulich@suse.com, bp@suse.de, suresh.b.siddha@intel.com, venkatesh.pallipadi@intel.com, airlied@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, x86@kernel.org, xen-devel@lists.xenproject.org, "Luis R. Rodriguez" <mcgrof@suse.com>, Ingo Molnar <mingo@elte.hu>, Daniel Vetter <daniel.vetter@ffwll.ch>, Antonino Daplas <adaplas@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

From: "Luis R. Rodriguez" <mcgrof@suse.com>

The driver doesn't use mtrr_add() or arch_phys_wc_add() but
since we know the framebuffer is isolated already on an
ioremap() we can take advantage of write combining for
performance where possible.

In this case there are a few motivations for this:

a) Take advantage of PAT when available

b) Help with the goal of eventually using _PAGE_CACHE_UC over
   _PAGE_CACHE_UC_MINUS on x86 on ioremap_nocache() (de33c442e)

Cc: Suresh Siddha <suresh.b.siddha@intel.com>
Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Juergen Gross <jgross@suse.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Antonino Daplas <adaplas@gmail.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>
---
 drivers/video/fbdev/geode/gxfb_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/geode/gxfb_core.c b/drivers/video/fbdev/geode/gxfb_core.c
index 124d7c7..ec9fc9a 100644
--- a/drivers/video/fbdev/geode/gxfb_core.c
+++ b/drivers/video/fbdev/geode/gxfb_core.c
@@ -263,7 +263,8 @@ static int gxfb_map_video_memory(struct fb_info *info, struct pci_dev *dev)
 
 	info->fix.smem_start = pci_resource_start(dev, 0);
 	info->fix.smem_len = vram ? vram : gx_frame_buffer_size();
-	info->screen_base = ioremap(info->fix.smem_start, info->fix.smem_len);
+	info->screen_base = ioremap_wc(info->fix.smem_start,
+				       info->fix.smem_len);
 	if (!info->screen_base)
 		return -ENOMEM;
 
-- 
2.3.2.209.gd67f9d5.dirty

