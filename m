From: Wang YanQing <udknight@gmail.com>
Date: Wed, 05 Mar 2014 16:16:11 +0000
Subject: [PATCH] video: fbdev: uvesafb: use CONFIG_X86_PAE surround _PAGE_NX check code
Message-Id: <20140305161611.GA32461@udknight>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@ti.com
Cc: plagnioj@jcrosoft.com, fengguang.wu@intel.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Because _PAGE_NX check will always false when we don't define
CONFIG_X86_PAE for CONFIG_X86_32, so use CONFIG_X86_PAE surround
the check code.

Although I believe "smart" compile will optimize out and generate
the same code, but use CONFIG_X86_PAE surround check code will
clear it and prohibit warning from static source code analyze tool.

[ This patch fix warning report by fengguang.wu@intel.com
  "drivers/video/fbdev/uvesafb.c:816 uvesafb_vbe_init()
   warn: bitwise AND condition is false here" ]

Signed-off-by: Wang YanQing <udknight@gmail.com>
---
 drivers/video/fbdev/uvesafb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/video/fbdev/uvesafb.c b/drivers/video/fbdev/uvesafb.c
index 509d452..102858c 100644
--- a/drivers/video/fbdev/uvesafb.c
+++ b/drivers/video/fbdev/uvesafb.c
@@ -813,6 +813,7 @@ static int uvesafb_vbe_init(struct fb_info *info)
 	par->ypan = ypan;
 
 	if (par->pmi_setpal || par->ypan) {
+#ifdef CONFIG_X86_PAE
 		if (__supported_pte_mask & _PAGE_NX) {
 			par->pmi_setpal = par->ypan = 0;
 			printk(KERN_WARNING "uvesafb: NX protection is active, "
@@ -820,6 +821,9 @@ static int uvesafb_vbe_init(struct fb_info *info)
 		} else {
 			uvesafb_vbe_getpmi(task, par);
 		}
+#else
+		uvesafb_vbe_getpmi(task, par);
+#endif
 	}
 #else
 	/* The protected mode interface is not available on non-x86. */
-- 
1.8.3.4.8.g69490f3.dirty
