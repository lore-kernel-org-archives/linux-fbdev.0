From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] fbdev: Kill Atari vblank cursor blinking
Date: Fri, 2 Jan 2009 11:11:05 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0901021109210.24191@anakin>
Mime-Version: 1.0
Return-path: <linux-m68k-owner@vger.kernel.org>
Sender: linux-m68k-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>
Cc: Linux/m68k <linux-m68k@vger.kernel.org>

Kill the last remaining vblank cursor blinking user

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/video/console/fbcon.c |   38 --------------------------------------
 1 files changed, 0 insertions(+), 38 deletions(-)

diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
index 4bcff81..1657b96 100644
--- a/drivers/video/console/fbcon.c
+++ b/drivers/video/console/fbcon.c
@@ -78,13 +78,6 @@
 #include <asm/fb.h>
 #include <asm/irq.h>
 #include <asm/system.h>
-#ifdef CONFIG_ATARI
-#include <asm/atariints.h>
-#endif
-#if defined(__mc68000__)
-#include <asm/machdep.h>
-#include <asm/setup.h>
-#endif
 
 #include "fbcon.h"
 
@@ -155,9 +148,6 @@ static int fbcon_set_origin(struct vc_data *);
 
 #define CURSOR_DRAW_DELAY		(1)
 
-/* # VBL ints between cursor state changes */
-#define ATARI_CURSOR_BLINK_RATE		(42)
-
 static int vbl_cursor_cnt;
 static int fbcon_cursor_noblink;
 
@@ -403,20 +393,6 @@ static void fb_flashcursor(struct work_struct *work)
 	release_console_sem();
 }
 
-#ifdef CONFIG_ATARI
-static int cursor_blink_rate;
-static irqreturn_t fb_vbl_handler(int irq, void *dev_id)
-{
-	struct fb_info *info = dev_id;
-
-	if (vbl_cursor_cnt && --vbl_cursor_cnt == 0) {
-		schedule_work(&info->queue);	
-		vbl_cursor_cnt = cursor_blink_rate; 
-	}
-	return IRQ_HANDLED;
-}
-#endif
-	
 static void cursor_timer_handler(unsigned long dev_addr)
 {
 	struct fb_info *info = (struct fb_info *) dev_addr;
@@ -1017,15 +993,6 @@ static const char *fbcon_startup(void)
 		info->var.yres,
 		info->var.bits_per_pixel);
 
-#ifdef CONFIG_ATARI
-	if (MACH_IS_ATARI) {
-		cursor_blink_rate = ATARI_CURSOR_BLINK_RATE;
-		(void)request_irq(IRQ_AUTO_4, fb_vbl_handler,
-				IRQ_TYPE_PRIO, "framebuffer vbl",
-				info);
-	}
-#endif /* CONFIG_ATARI */
-
 	fbcon_add_cursor_timer(info);
 	fbcon_has_exited = 0;
 	return display_desc;
@@ -3454,11 +3421,6 @@ static void fbcon_exit(void)
 	if (fbcon_has_exited)
 		return;
 
-#ifdef CONFIG_ATARI
-	if (MACH_IS_ATARI)
-		free_irq(IRQ_AUTO_4, fb_vbl_handler);
-#endif
-
 	kfree((void *)softback_buf);
 	softback_buf = 0UL;
 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
