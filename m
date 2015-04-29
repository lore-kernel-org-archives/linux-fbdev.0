From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Wed, 29 Apr 2015 21:44:09 +0000
Subject: [PATCH v4 4/6] video: fbdev: atyfb: clarify ioremap() base and length used
Message-Id: <1430343851-967-5-git-send-email-mcgrof@do-not-panic.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1430343851-967-1-git-send-email-mcgrof@do-not-panic.com>
In-Reply-To: <1430343851-967-1-git-send-email-mcgrof@do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: mingo@elte.hu, tglx@linutronix.de, hpa@zytor.com, bp@suse.de, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, daniel.vetter@intel.com, airlied@linux.ie
Cc: dledford@redhat.com, awalls@md.metrocast.net, syrjala@sci.fi, luto@amacapital.net, mst@redhat.com, cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org, "Luis R. Rodriguez" <mcgrof@suse.com>, Toshi Kani <toshi.kani@hp.com>, Suresh Siddha <sbsiddha@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Juergen Gross <jgross@suse.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Dave Airlie <airlied@redhat.com>, Antonino Daplas <adaplas@gmail.com>, Rob Clark <robdclark@gmail.com>, Mathias Krause <minipli@googlemail.com>, Andrzej Hajda <a.hajda@samsung.com>, Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>, Davidlohr Bueso <dbueso@suse.de>, linux-fbdev@vger.kernel.org

From: "Luis R. Rodriguez" <mcgrof@suse.com>

This has no functional changes, it just adjusts
the ioremap() call for the framebuffer to use
the same values we later use for the framebuffer,
this will make it easier to review the next change.

The size of the framebuffer varies but since this is
for PCI we *know* this defaults to 0x800000.
atyfb_setup_generic() is *only* used on PCI probe.

Cc: Toshi Kani <toshi.kani@hp.com>
Cc: Suresh Siddha <sbsiddha@gmail.com>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Juergen Gross <jgross@suse.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Antonino Daplas <adaplas@gmail.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Ville Syrjälä <syrjala@sci.fi>
Cc: Rob Clark <robdclark@gmail.com>
Cc: Mathias Krause <minipli@googlemail.com>
Cc: Andrzej Hajda <a.hajda@samsung.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Borislav Petkov <bp@suse.de>
Cc: Davidlohr Bueso <dbueso@suse.de>
Cc: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>
---
 drivers/video/fbdev/aty/atyfb_base.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/aty/atyfb_base.c b/drivers/video/fbdev/aty/atyfb_base.c
index 16936bb..8025624 100644
--- a/drivers/video/fbdev/aty/atyfb_base.c
+++ b/drivers/video/fbdev/aty/atyfb_base.c
@@ -3489,7 +3489,9 @@ static int atyfb_setup_generic(struct pci_dev *pdev, struct fb_info *info,
 
 	/* Map in frame buffer */
 	info->fix.smem_start = addr;
-	info->screen_base = ioremap(addr, 0x800000);
+	info->fix.smem_len = 0x800000;
+
+	info->screen_base = ioremap(info->fix.smem_start, info->fix.smem_len);
 	if (info->screen_base = NULL) {
 		ret = -ENOMEM;
 		goto atyfb_setup_generic_fail;
-- 
2.3.2.209.gd67f9d5.dirty

